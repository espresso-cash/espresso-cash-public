// ignore_for_file: avoid-non-null-assertion

import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:solana/base58.dart';
import 'package:solana/encoder.dart';

import '../../../../core/amount.dart';
import '../../../../core/api_version.dart';
import '../../../../core/currency.dart';
import '../../../../core/escrow_private_key.dart';
import '../../../../core/tokens/token_list.dart';
import '../../../../core/transactions/tx_sender.dart';
import '../../../../data/db/db.dart';
import '../../../../data/db/mixins.dart';
import '../../models/outgoing_split_key_payment.dart';

@injectable
class OSKPRepository {
  const OSKPRepository(this._db, this._tokens);

  final MyDatabase _db;
  final TokenList _tokens;

  Future<OutgoingSplitKeyPayment?> load(String id) {
    final query = _db.select(_db.oSKPRows)..where((p) => p.id.equals(id));

    return query.getSingleOrNull().then((row) => row?.toModel(_tokens));
  }

  Future<void> save(OutgoingSplitKeyPayment payment) async {
    await payment.status.maybeMap(
      txFailure: (status) async {
        await Sentry.captureMessage(
          'OSKP tx failure',
          level: SentryLevel.warning,
          withScope: (scope) => scope.setContexts('data', {
            'reason': status.reason,
          }),
        );
      },
      cancelTxFailure: (status) async {
        await Sentry.captureMessage(
          'OSKP cancel tx failure',
          level: SentryLevel.warning,
          withScope: (scope) => scope.setContexts('data', {
            'reason': status.reason,
          }),
        );
      },
      orElse: () async {},
    );

    await _db.into(_db.oSKPRows).insertOnConflictUpdate(await payment.toDto());
  }

  Stream<OutgoingSplitKeyPayment> watch(String id) {
    final query = _db.select(_db.oSKPRows)..where((p) => p.id.equals(id));

    return query.watchSingle().asyncMap((row) => row.toModel(_tokens));
  }

  /// Watches for statuses that can be moved to withdrawn or canceled directly,
  /// i.e. all the transactions are already submitted and confirmed.
  Stream<IList<OutgoingSplitKeyPayment>> watchReady() => _watchWithStatuses([
        OSKPStatusDto.linksReady,
        OSKPStatusDto.cancelTxCreated,
        OSKPStatusDto.cancelTxSendFailure,
        OSKPStatusDto.cancelTxSent,
        OSKPStatusDto.cancelTxWaitFailure,
        OSKPStatusDto.cancelTxFailure,
      ]);

  Stream<IList<OutgoingSplitKeyPayment>> watchTxCreated() =>
      _watchWithStatuses([
        OSKPStatusDto.txCreated,
        OSKPStatusDto.txSendFailure,
      ]);

  Stream<IList<OutgoingSplitKeyPayment>> watchTxConfirmed() =>
      _watchWithStatuses([
        OSKPStatusDto.txConfirmed,
        OSKPStatusDto.txLinksFailure,
      ]);

  Stream<IList<OutgoingSplitKeyPayment>> watchCancelTxCreated() =>
      _watchWithStatuses([
        OSKPStatusDto.cancelTxCreated,
        OSKPStatusDto.cancelTxSendFailure,
      ]);

  Stream<IList<OutgoingSplitKeyPayment>> watchTxSent() => _watchWithStatuses([
        OSKPStatusDto.txSent,
        OSKPStatusDto.txWaitFailure,
      ]);

  Stream<IList<OutgoingSplitKeyPayment>> watchCancelTxSent() =>
      _watchWithStatuses([
        OSKPStatusDto.cancelTxSent,
        OSKPStatusDto.cancelTxWaitFailure,
      ]);

  Future<void> clear() => _db.delete(_db.oSKPRows).go();

  Stream<IList<OutgoingSplitKeyPayment>> _watchWithStatuses(
    Iterable<OSKPStatusDto> statuses,
  ) {
    final query = _db.select(_db.oSKPRows)
      ..where((p) => p.status.isInValues(statuses));

    return query
        .watch()
        .asyncMap(
          (rows) => Future.wait(rows.map((row) => row.toModel(_tokens))),
        )
        .map((event) => event.lock);
  }
}

class OSKPRows extends Table with AmountMixin, EntityMixin {
  const OSKPRows();

  IntColumn get status => intEnum<OSKPStatusDto>()();

  // Status fields
  TextColumn get tx => text().nullable()();
  TextColumn get txId => text().nullable()();
  TextColumn get withdrawTxId => text().nullable()();
  TextColumn get privateKey => text().nullable()();
  TextColumn get link1 => text().nullable()();
  TextColumn get link2 => text().nullable()();
  TextColumn get link3 => text().nullable()();
  IntColumn get txFailureReason => intEnum<TxFailureReason>().nullable()();
  TextColumn get cancelTx => text().nullable()();
  TextColumn get cancelTxId => text().nullable()();
  DateTimeColumn get generatedLinksAt => dateTime().nullable()();
  DateTimeColumn get resolvedAt => dateTime().nullable()();
  TextColumn get slot => text().nullable()();
  IntColumn get apiVersion =>
      intEnum<OskpApiVersionDto>().withDefault(const Constant(0))();
}

enum OSKPStatusDto {
  txCreated,
  txSent,
  txConfirmed,
  linksReady,
  success, // Legacy
  txFailure,
  txSendFailure,
  txWaitFailure,
  txLinksFailure,
  withdrawn,
  canceled,
  cancelTxCreated,
  cancelTxFailure,
  cancelTxSent,
  cancelTxSendFailure,
  cancelTxWaitFailure,
}

extension OSKPRowExt on OSKPRow {
  Future<OutgoingSplitKeyPayment> toModel(TokenList tokens) async =>
      OutgoingSplitKeyPayment(
        id: id,
        created: created,
        amount: CryptoAmount(
          value: amount,
          cryptoCurrency: CryptoCurrency(token: tokens.findTokenByMint(token)!),
        ),
        status: await status.toOSKPStatus(this),
        linksGeneratedAt: generatedLinksAt,
        apiVersion: apiVersion.toModel(),
      );
}

enum OskpApiVersionDto {
  manual,
  smartContract,
}

extension on OSKPStatusDto {
  Future<OSKPStatus> toOSKPStatus(OSKPRow row) async {
    final tx = row.tx?.let(SignedTx.decode);
    final txId = row.txId;
    final withdrawTxId = row.withdrawTxId;
    final escrow = row.privateKey?.let(base58decode).let(EscrowPrivateKey.new);
    final link1 = row.link1?.let(Uri.parse);
    final link2 = row.link2?.let(Uri.parse);
    final link3 = row.link3?.let(Uri.tryParse);
    final cancelTx = row.cancelTx?.let(SignedTx.decode);
    final cancelTxId = row.cancelTxId;
    final resolvedAt = row.resolvedAt;
    final slot = row.slot?.let(BigInt.tryParse);

    switch (this) {
      case OSKPStatusDto.txSendFailure:
      case OSKPStatusDto.txCreated:
        return OSKPStatus.txCreated(
          tx!,
          escrow: escrow!,
          slot: slot ?? BigInt.zero,
        );
      case OSKPStatusDto.txWaitFailure:
      case OSKPStatusDto.txSent:
        return OSKPStatus.txSent(
          tx ?? StubSignedTx(txId!),
          escrow: escrow!,
          slot: slot ?? BigInt.zero,
        );
      case OSKPStatusDto.txLinksFailure:
      case OSKPStatusDto.txConfirmed:
        return OSKPStatus.txConfirmed(escrow: escrow!);
      case OSKPStatusDto.linksReady:
        return OSKPStatus.linksReady(
          link1: link1!,
          link2: link2!,
          qrLink: link3,
          escrow: escrow!,
        );
      case OSKPStatusDto.success:
        // For compatibility with old versions
        return OSKPStatus.withdrawn(txId: txId!, timestamp: resolvedAt);
      case OSKPStatusDto.withdrawn:
        return OSKPStatus.withdrawn(txId: withdrawTxId!, timestamp: resolvedAt);
      case OSKPStatusDto.canceled:
        if (cancelTxId == null && withdrawTxId != null) {
          // For compatibility with old versions
          return OSKPStatus.canceled(
            txId: withdrawTxId,
            timestamp: resolvedAt,
          );
        }

        return OSKPStatus.canceled(txId: cancelTxId, timestamp: resolvedAt);
      case OSKPStatusDto.txFailure:
        return OSKPStatus.txFailure(
          reason: row.txFailureReason ?? TxFailureReason.unknown,
        );
      case OSKPStatusDto.cancelTxSendFailure:
      case OSKPStatusDto.cancelTxCreated:
        return OSKPStatus.cancelTxCreated(
          cancelTx!,
          escrow: escrow!,
          slot: slot ?? BigInt.zero,
        );
      case OSKPStatusDto.cancelTxFailure:
        return OSKPStatus.cancelTxFailure(
          escrow: escrow!,
          reason: row.txFailureReason ?? TxFailureReason.unknown,
        );
      case OSKPStatusDto.cancelTxWaitFailure:
      case OSKPStatusDto.cancelTxSent:
        return OSKPStatus.cancelTxSent(
          cancelTx!,
          escrow: escrow!,
          slot: slot ?? BigInt.zero,
        );
    }
  }
}

extension on OutgoingSplitKeyPayment {
  Future<OSKPRow> toDto() async => OSKPRow(
        amount: amount.value,
        token: amount.cryptoCurrency.token.address,
        id: id,
        created: created,
        status: status.toDto(),
        tx: status.toTx(),
        txId: status.toTxId(),
        withdrawTxId: status.toWithdrawTxId(),
        privateKey: await status.toPrivateKey(),
        link1: status.toLink1(),
        link2: status.toLink2(),
        link3: status.toLink3(),
        txFailureReason: status.toTxFailureReason(),
        cancelTx: status.toCancelTx(),
        cancelTxId: status.toCancelTxId(),
        slot: status.toSlot()?.toString(),
        generatedLinksAt: linksGeneratedAt,
        resolvedAt: status.toResolvedAt(),
        apiVersion: apiVersion.toDto(),
      );
}

extension on OSKPStatus {
  OSKPStatusDto toDto() => this.map(
        txCreated: always(OSKPStatusDto.txCreated),
        txSent: always(OSKPStatusDto.txSent),
        txConfirmed: always(OSKPStatusDto.txConfirmed),
        linksReady: always(OSKPStatusDto.linksReady),
        withdrawn: always(OSKPStatusDto.withdrawn),
        txFailure: always(OSKPStatusDto.txFailure),
        canceled: always(OSKPStatusDto.canceled),
        cancelTxCreated: always(OSKPStatusDto.cancelTxCreated),
        cancelTxFailure: always(OSKPStatusDto.cancelTxFailure),
        cancelTxSent: always(OSKPStatusDto.cancelTxSent),
      );

  String? toTx() => mapOrNull(
        txCreated: (it) => it.tx.encode(),
        txSent: (it) => it.tx.encode(),
      );

  String? toTxId() => mapOrNull(
        txCreated: (it) => it.tx.id,
        txSent: (it) => it.tx.id,
      );

  String? toWithdrawTxId() => mapOrNull(withdrawn: (it) => it.txId);

  String? toCancelTx() => mapOrNull(
        cancelTxCreated: (it) => it.tx.encode(),
        cancelTxSent: (it) => it.tx.encode(),
      );

  String? toCancelTxId() => mapOrNull(
        cancelTxCreated: (it) => it.tx.id,
        cancelTxSent: (it) => it.tx.id,
        canceled: (it) => it.txId,
      );

  Future<String?> toPrivateKey() async => this.map(
        txCreated: (it) async => base58encode(it.escrow.bytes),
        txSent: (it) async => base58encode(it.escrow.bytes),
        txConfirmed: (it) async => base58encode(it.escrow.bytes),
        linksReady: (it) async => base58encode(it.escrow.bytes),
        withdrawn: (it) async => null,
        canceled: (it) async => null,
        txFailure: (it) async => null,
        cancelTxCreated: (it) async => base58encode(it.escrow.bytes),
        cancelTxFailure: (it) async => base58encode(it.escrow.bytes),
        cancelTxSent: (it) async => base58encode(it.escrow.bytes),
      );

  String? toLink1() => mapOrNull(
        linksReady: (it) => it.link1.toString(),
      );

  String? toLink2() => mapOrNull(
        linksReady: (it) => it.link2.toString(),
      );

  String? toLink3() => mapOrNull(
        linksReady: (it) => it.qrLink.toString(),
      );

  TxFailureReason? toTxFailureReason() => mapOrNull<TxFailureReason?>(
        txFailure: (it) => it.reason,
        cancelTxFailure: (it) => it.reason,
      );

  DateTime? toResolvedAt() => mapOrNull(
        withdrawn: (it) => it.timestamp,
        canceled: (it) => it.timestamp,
      );

  BigInt? toSlot() => mapOrNull(
        txCreated: (it) => it.slot,
        txSent: (it) => it.slot,
        cancelTxCreated: (it) => it.slot,
        cancelTxSent: (it) => it.slot,
      );
}

extension on SplitKeyApiVersion {
  OskpApiVersionDto toDto() {
    switch (this) {
      case SplitKeyApiVersion.manual:
        return OskpApiVersionDto.manual;
      case SplitKeyApiVersion.smartContract:
        return OskpApiVersionDto.smartContract;
    }
  }
}

extension on OskpApiVersionDto {
  SplitKeyApiVersion toModel() {
    switch (this) {
      case OskpApiVersionDto.manual:
        return SplitKeyApiVersion.manual;
      case OskpApiVersionDto.smartContract:
        return SplitKeyApiVersion.smartContract;
    }
  }
}
