// ignore_for_file: avoid-non-null-assertion

import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:solana/base58.dart';
import 'package:solana/encoder.dart';

import '../../../core/amount.dart';
import '../../../core/currency.dart';
import '../../../core/escrow_private_key.dart';
import '../../../core/tokens/token_list.dart';
import '../../../data/db/db.dart';
import '../../../data/db/mixins.dart';
import '../../transactions/models/tx_sender.dart';
import '../models/outgoing_link_payment.dart';

@injectable
class OLPRepository {
  const OLPRepository(this._db, this._tokens);

  final MyDatabase _db;
  final TokenList _tokens;

  Future<OutgoingLinkPayment?> load(String id) {
    final query = _db.select(_db.oLPRows)..where((p) => p.id.equals(id));

    return query.getSingleOrNull().then((row) => row?.toModel(_tokens));
  }

  Future<void> save(OutgoingLinkPayment payment) async {
    await payment.status.maybeMap(
      txFailure: (status) async {
        await Sentry.captureMessage(
          'OLP tx failure',
          level: SentryLevel.warning,
          withScope: (scope) => scope.setContexts('data', {
            'reason': status.reason,
          }),
        );
      },
      cancelTxFailure: (status) async {
        await Sentry.captureMessage(
          'OLP cancel tx failure',
          level: SentryLevel.warning,
          withScope: (scope) => scope.setContexts('data', {
            'reason': status.reason,
          }),
        );
      },
      orElse: () async {},
    );

    await _db.into(_db.oLPRows).insertOnConflictUpdate(await payment.toDto());
  }

  Stream<OutgoingLinkPayment> watch(String id) {
    final query = _db.select(_db.oLPRows)..where((p) => p.id.equals(id));

    return query.watchSingle().asyncMap((row) => row.toModel(_tokens));
  }

  /// Watches for statuses that can be moved to withdrawn or canceled directly,
  /// i.e. all the transactions are already submitted and confirmed.
  Stream<IList<OutgoingLinkPayment>> watchReady() => _watchWithStatuses([
        OLPStatusDto.linkReady,
        OLPStatusDto.cancelTxCreated,
        OLPStatusDto.cancelTxSendFailure,
        OLPStatusDto.cancelTxSent,
        OLPStatusDto.cancelTxWaitFailure,
        OLPStatusDto.cancelTxFailure,
      ]);

  Stream<IList<OutgoingLinkPayment>> watchTxCreated() => _watchWithStatuses([
        OLPStatusDto.txCreated,
        OLPStatusDto.txSendFailure,
      ]);

  Stream<IList<OutgoingLinkPayment>> watchTxConfirmed() => _watchWithStatuses([
        OLPStatusDto.txConfirmed,
        OLPStatusDto.txLinksFailure,
      ]);

  Stream<IList<OutgoingLinkPayment>> watchCancelTxCreated() =>
      _watchWithStatuses([
        OLPStatusDto.cancelTxCreated,
        OLPStatusDto.cancelTxSendFailure,
      ]);

  Stream<IList<OutgoingLinkPayment>> watchTxSent() => _watchWithStatuses([
        OLPStatusDto.txSent,
        OLPStatusDto.txWaitFailure,
      ]);

  Stream<IList<OutgoingLinkPayment>> watchCancelTxSent() => _watchWithStatuses([
        OLPStatusDto.cancelTxSent,
        OLPStatusDto.cancelTxWaitFailure,
      ]);

  Future<void> clear() => _db.delete(_db.oLPRows).go();

  Stream<IList<OutgoingLinkPayment>> _watchWithStatuses(
    Iterable<OLPStatusDto> statuses,
  ) {
    final query = _db.select(_db.oLPRows)
      ..where((p) => p.status.isInValues(statuses));

    return query
        .watch()
        .asyncMap(
          (rows) => Future.wait(rows.map((row) => row.toModel(_tokens))),
        )
        .map((event) => event.lock);
  }
}

class OLPRows extends Table with AmountMixin, EntityMixin {
  const OLPRows();

  IntColumn get status => intEnum<OLPStatusDto>()();

  // Status fields
  TextColumn get tx => text().nullable()();
  TextColumn get txId => text().nullable()();
  TextColumn get withdrawTxId => text().nullable()();
  TextColumn get privateKey => text().nullable()();
  TextColumn get link => text().nullable()();
  IntColumn get txFailureReason => intEnum<TxFailureReason>().nullable()();
  TextColumn get cancelTx => text().nullable()();
  TextColumn get cancelTxId => text().nullable()();
  DateTimeColumn get generatedLinksAt => dateTime().nullable()();
  DateTimeColumn get resolvedAt => dateTime().nullable()();
  TextColumn get slot => text().nullable()();
}

enum OLPStatusDto {
  txCreated,
  txSent,
  txConfirmed,
  linkReady,
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

extension OLPRowExt on OLPRow {
  Future<OutgoingLinkPayment> toModel(TokenList tokens) async =>
      OutgoingLinkPayment(
        id: id,
        created: created,
        amount: CryptoAmount(
          value: amount,
          cryptoCurrency: CryptoCurrency(token: tokens.findTokenByMint(token)!),
        ),
        status: await status.toOLPStatus(this),
        linksGeneratedAt: generatedLinksAt,
      );
}

extension on OLPStatusDto {
  Future<OLPStatus> toOLPStatus(OLPRow row) async {
    final tx = row.tx?.let(SignedTx.decode);
    final txId = row.txId;
    final withdrawTxId = row.withdrawTxId;
    final escrow = row.privateKey?.let(base58decode).let(EscrowPrivateKey.new);
    final link = row.link?.let(Uri.parse);
    final cancelTx = row.cancelTx?.let(SignedTx.decode);
    final cancelTxId = row.cancelTxId;
    final resolvedAt = row.resolvedAt;
    final slot = row.slot?.let(BigInt.tryParse);

    switch (this) {
      case OLPStatusDto.txSendFailure:
      case OLPStatusDto.txCreated:
        return OLPStatus.txCreated(
          tx!,
          escrow: escrow!,
          slot: slot ?? BigInt.zero,
        );
      case OLPStatusDto.txWaitFailure:
      case OLPStatusDto.txSent:
        return OLPStatus.txSent(
          tx ?? StubSignedTx(txId!),
          escrow: escrow!,
          slot: slot ?? BigInt.zero,
        );
      case OLPStatusDto.txLinksFailure:
      case OLPStatusDto.txConfirmed:
        return OLPStatus.txConfirmed(escrow: escrow!);
      case OLPStatusDto.linkReady:
        return OLPStatus.linkReady(
          link: link!,
          escrow: escrow!,
        );
      case OLPStatusDto.withdrawn:
        return OLPStatus.withdrawn(txId: withdrawTxId!, timestamp: resolvedAt);
      case OLPStatusDto.canceled:
        if (cancelTxId == null && withdrawTxId != null) {
          // For compatibility with old versions
          return OLPStatus.canceled(
            txId: withdrawTxId,
            timestamp: resolvedAt,
          );
        }

        return OLPStatus.canceled(txId: cancelTxId, timestamp: resolvedAt);
      case OLPStatusDto.txFailure:
        return OLPStatus.txFailure(
          reason: row.txFailureReason ?? TxFailureReason.unknown,
        );
      case OLPStatusDto.cancelTxSendFailure:
      case OLPStatusDto.cancelTxCreated:
        return OLPStatus.cancelTxCreated(
          cancelTx!,
          escrow: escrow!,
          slot: slot ?? BigInt.zero,
        );
      case OLPStatusDto.cancelTxFailure:
        return OLPStatus.cancelTxFailure(
          escrow: escrow!,
          reason: row.txFailureReason ?? TxFailureReason.unknown,
        );
      case OLPStatusDto.cancelTxWaitFailure:
      case OLPStatusDto.cancelTxSent:
        return OLPStatus.cancelTxSent(
          cancelTx!,
          escrow: escrow!,
          slot: slot ?? BigInt.zero,
        );
    }
  }
}

extension on OutgoingLinkPayment {
  Future<OLPRow> toDto() async => OLPRow(
        amount: amount.value,
        token: amount.cryptoCurrency.token.address,
        id: id,
        created: created,
        status: status.toDto(),
        tx: status.toTx(),
        txId: status.toTxId(),
        withdrawTxId: status.toWithdrawTxId(),
        privateKey: await status.toPrivateKey(),
        link: status.toLink(),
        txFailureReason: status.toTxFailureReason(),
        cancelTx: status.toCancelTx(),
        cancelTxId: status.toCancelTxId(),
        slot: status.toSlot().toString(),
        generatedLinksAt: linksGeneratedAt,
        resolvedAt: status.toResolvedAt(),
      );
}

extension on OLPStatus {
  OLPStatusDto toDto() => this.map(
        txCreated: always(OLPStatusDto.txCreated),
        txSent: always(OLPStatusDto.txSent),
        txConfirmed: always(OLPStatusDto.txConfirmed),
        linkReady: always(OLPStatusDto.linkReady),
        withdrawn: always(OLPStatusDto.withdrawn),
        txFailure: always(OLPStatusDto.txFailure),
        canceled: always(OLPStatusDto.canceled),
        cancelTxCreated: always(OLPStatusDto.cancelTxCreated),
        cancelTxFailure: always(OLPStatusDto.cancelTxFailure),
        cancelTxSent: always(OLPStatusDto.cancelTxSent),
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
        linkReady: (it) async => base58encode(it.escrow.bytes),
        withdrawn: (it) async => null,
        canceled: (it) async => null,
        txFailure: (it) async => null,
        cancelTxCreated: (it) async => base58encode(it.escrow.bytes),
        cancelTxFailure: (it) async => base58encode(it.escrow.bytes),
        cancelTxSent: (it) async => base58encode(it.escrow.bytes),
      );

  String? toLink() => mapOrNull(
        linkReady: (it) => it.link.toString(),
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
