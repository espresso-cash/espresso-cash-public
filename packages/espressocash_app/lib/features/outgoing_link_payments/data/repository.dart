// ignore_for_file: avoid-non-null-assertion

import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/base58.dart';
import 'package:solana/encoder.dart';

import '../../../data/db/db.dart';
import '../../../data/db/mixins.dart';
import '../../accounts/auth_scope.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../escrow/models/escrow_private_key.dart';
import '../../tokens/token_list.dart';
import '../../transactions/models/tx_results.dart';
import '../models/outgoing_link_payment.dart';

@Singleton(scope: authScope)
class OLPRepository implements Disposable {
  const OLPRepository(this._db, this._tokens);

  final MyDatabase _db;
  final TokenList _tokens;

  Future<OutgoingLinkPayment?> load(String id) {
    final query = _db.select(_db.oLPRows)..where((p) => p.id.equals(id));

    return query.getSingleOrNull().then((row) => row?.toModel(_tokens));
  }

  Future<void> save(OutgoingLinkPayment payment) async {
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
        OLPStatusDto.cancelTxSent,
        OLPStatusDto.cancelTxFailure,
      ]);

  Stream<IList<OutgoingLinkPayment>> watchTxCreated() => _watchWithStatuses([
        OLPStatusDto.txCreated,
      ]);

  Stream<IList<OutgoingLinkPayment>> watchTxConfirmed() => _watchWithStatuses([
        OLPStatusDto.txConfirmed,
      ]);

  Stream<IList<OutgoingLinkPayment>> watchCancelTxCreated() =>
      _watchWithStatuses([
        OLPStatusDto.cancelTxCreated,
      ]);

  Stream<IList<OutgoingLinkPayment>> watchTxSent() => _watchWithStatuses([
        OLPStatusDto.txSent,
      ]);

  Stream<IList<OutgoingLinkPayment>> watchCancelTxSent() => _watchWithStatuses([
        OLPStatusDto.cancelTxSent,
      ]);

  @override
  Future<void> onDispose() => _db.delete(_db.oLPRows).go();

  Stream<IList<OutgoingLinkPayment>> _watchWithStatuses(
    Iterable<OLPStatusDto> statuses,
  ) {
    final query = _db.select(_db.oLPRows)
      ..where((p) => p.status.isInValues(statuses));

    return query
        .watch()
        .map((rows) => rows.map((row) => row.toModel(_tokens)))
        .map((event) => event.toIList());
  }

  Future<IList<String>> getNonCompletedPaymentIds() {
    final query = _db.select(_db.oLPRows)
      ..where(
        (p) => p.status.isNotInValues([
          OLPStatusDto.withdrawn,
          OLPStatusDto.canceled,
        ]),
      );

    return query.get().then((rows) => rows.map((row) => row.id).toIList());
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
  // legacy
  txConfirmed,
  linkReady,
  txFailure,
  withdrawn,
  canceled,
  cancelTxCreated,
  cancelTxFailure,
  cancelTxSent,
}

extension OLPRowExt on OLPRow {
  OutgoingLinkPayment toModel(TokenList tokens) => OutgoingLinkPayment(
        id: id,
        created: created,
        amount: CryptoAmount(
          value: amount,
          cryptoCurrency: CryptoCurrency(
            token: tokens.requireTokenByMint(token),
          ),
        ),
        status: status.toOLPStatus(this),
        linksGeneratedAt: generatedLinksAt,
      );
}

extension on OLPStatusDto {
  OLPStatus toOLPStatus(OLPRow row) {
    final tx = row.tx?.let(SignedTx.decode);
    final escrow = row.privateKey?.let(base58decode).let(EscrowPrivateKey.new);
    final cancelTx = row.cancelTx?.let(SignedTx.decode);
    final resolvedAt = row.resolvedAt;

    switch (this) {
      case OLPStatusDto.txConfirmed:
      case OLPStatusDto.txCreated:
        return OLPStatus.txCreated(
          tx!,
          escrow: escrow!,
        );

      case OLPStatusDto.txSent:
        final txId = row.txId;

        return OLPStatus.txSent(
          tx ?? StubSignedTx(txId!),
          escrow: escrow!,
          signature: row.txId ?? '',
        );
      case OLPStatusDto.linkReady:
        final link = row.link?.let(Uri.parse);

        return OLPStatus.linkReady(link: link!, escrow: escrow!);
      case OLPStatusDto.withdrawn:
        return OLPStatus.withdrawn(
          txId: row.withdrawTxId!,
          timestamp: resolvedAt,
        );
      case OLPStatusDto.canceled:
        return OLPStatus.canceled(txId: row.cancelTxId, timestamp: resolvedAt);
      case OLPStatusDto.txFailure:
        return OLPStatus.txFailure(
          reason: row.txFailureReason ?? TxFailureReason.unknown,
        );
      case OLPStatusDto.cancelTxCreated:
        return OLPStatus.cancelTxCreated(
          cancelTx!,
          escrow: escrow!,
        );
      case OLPStatusDto.cancelTxFailure:
        return OLPStatus.cancelTxFailure(
          escrow: escrow!,
          reason: row.txFailureReason ?? TxFailureReason.unknown,
        );
      case OLPStatusDto.cancelTxSent:
        return OLPStatus.cancelTxSent(
          cancelTx!,
          escrow: escrow!,
          signature: row.cancelTxId ?? '',
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
        generatedLinksAt: linksGeneratedAt,
        resolvedAt: status.toResolvedAt(),
      );
}

extension on OLPStatus {
  OLPStatusDto toDto() => this.map(
        txCreated: always(OLPStatusDto.txCreated),
        txSent: always(OLPStatusDto.txSent),
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
        txSent: (it) => it.signature,
      );

  String? toWithdrawTxId() => mapOrNull(withdrawn: (it) => it.txId);

  String? toCancelTx() => mapOrNull(
        cancelTxCreated: (it) => it.tx.encode(),
        cancelTxSent: (it) => it.tx.encode(),
      );

  String? toCancelTxId() => mapOrNull(
        cancelTxSent: (it) => it.signature,
        canceled: (it) => it.txId,
      );

  Future<String?> toPrivateKey() => this.map(
        txCreated: (it) async => base58encode(it.escrow.bytes),
        txSent: (it) async => base58encode(it.escrow.bytes),
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
}
