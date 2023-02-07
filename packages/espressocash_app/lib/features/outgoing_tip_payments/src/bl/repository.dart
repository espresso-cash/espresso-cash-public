// ignore_for_file: avoid-non-null-assertion

import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/base58.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../../../core/amount.dart';
import '../../../../core/currency.dart';
import '../../../../core/tokens/token_list.dart';
import '../../../../core/transactions/tx_sender.dart';
import '../../../../data/db/db.dart';
import '../../../../data/db/mixins.dart';
import '../../models/outgoing_tip_payment.dart';

@injectable
class OTRepository {
  OTRepository(this._db, this._tokens);

  final MyDatabase _db;
  final TokenList _tokens;

  Future<OutgoingTipPayment?> load(String id) {
    final query = _db.select(_db.oTRows)..where((p) => p.id.equals(id));

    return query.getSingleOrNull().then((row) => row?.toModel(_tokens));
  }

  Future<void> save(OutgoingTipPayment payment) async =>
      _db.into(_db.oTRows).insertOnConflictUpdate(await payment.toDto());

  Stream<OutgoingTipPayment?> watch(String id) {
    final query = _db.select(_db.oTRows)..where((p) => p.id.equals(id));

    return query.watchSingleOrNull().asyncMap((row) => row?.toModel(_tokens));
  }

  Stream<List<OutgoingTipPayment>> watchWithReadyLink() {
    final query = _db.select(_db.oTRows)
      ..where((p) => p.status.equalsValue(OTStatusDto.linkReady));

    return query.watch().asyncMap(
          (rows) => Future.wait(rows.map((row) => row.toModel(_tokens))),
        );
  }

  Future<void> clear() => _db.delete(_db.oTRows).go();
}

class OTRows extends Table with AmountMixin, EntityMixin {
  IntColumn get status => intEnum<OTStatusDto>()();

  // Status fields
  TextColumn get tx => text().nullable()();
  TextColumn get txId => text().nullable()();
  TextColumn get withdrawTxId => text().nullable()();
  TextColumn get privateKey => text().nullable()();
  TextColumn get link => text().nullable()();
  IntColumn get txFailureReason => intEnum<TxFailureReason>().nullable()();
  TextColumn get cancelTx => text().nullable()();
  TextColumn get cancelTxId => text().nullable()();
}

enum OTStatusDto {
  txCreated,
  txSent,
  txConfirmed,
  linkReady,
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

extension OutgoingTipRowExt on OTRow {
  Future<OutgoingTipPayment> toModel(TokenList tokens) async =>
      OutgoingTipPayment(
        id: id,
        created: created,
        amount: CryptoAmount(
          value: amount,
          cryptoCurrency: CryptoCurrency(token: tokens.findTokenByMint(token)!),
        ),
        status: await status.toOutgoingTipStatus(this),
      );
}

extension on OTStatusDto {
  Future<OTStatus> toOutgoingTipStatus(OTRow row) async {
    final tx = row.tx?.let(SignedTx.decode);
    final txId = row.txId;
    final withdrawTxId = row.withdrawTxId;
    final escrow = await row.privateKey
        ?.let(base58decode)
        .let((it) => Ed25519HDKeyPair.fromPrivateKeyBytes(privateKey: it));
    final link1 = row.link?.let(Uri.parse);
    final cancelTx = row.cancelTx?.let(SignedTx.decode);
    final cancelTxId = row.cancelTxId;

    switch (this) {
      case OTStatusDto.txCreated:
        return OTStatus.txCreated(tx!, escrow: escrow!);
      case OTStatusDto.txSent:
        return OTStatus.txSent(
          tx ?? StubSignedTx(txId!),
          escrow: escrow!,
        );
      case OTStatusDto.txConfirmed:
        return OTStatus.txConfirmed(escrow: escrow!);
      case OTStatusDto.linkReady:
        return OTStatus.linkReady(
          link: link1!,
          escrow: escrow!,
        );
      case OTStatusDto.success:
        // For compatibility with old versions
        return OTStatus.withdrawn(txId: txId!);
      case OTStatusDto.withdrawn:
        return OTStatus.withdrawn(txId: withdrawTxId!);
      case OTStatusDto.canceled:
        return OTStatus.canceled(txId: cancelTxId!);
      case OTStatusDto.txFailure:
        return OTStatus.txFailure(reason: row.txFailureReason);
      case OTStatusDto.txSendFailure:
        return OTStatus.txSendFailure(tx!, escrow: escrow!);
      case OTStatusDto.txWaitFailure:
        return OTStatus.txWaitFailure(
          tx ?? StubSignedTx(txId!),
          escrow: escrow!,
        );
      case OTStatusDto.txLinksFailure:
        return OTStatus.txLinksFailure(escrow: escrow!);
      case OTStatusDto.cancelTxCreated:
        return OTStatus.cancelTxCreated(cancelTx!, escrow: escrow!);
      case OTStatusDto.cancelTxFailure:
        return OTStatus.cancelTxFailure(escrow: escrow!);
      case OTStatusDto.cancelTxSent:
        return OTStatus.cancelTxSent(cancelTx!, escrow: escrow!);
      case OTStatusDto.cancelTxSendFailure:
        return OTStatus.cancelTxSendFailure(cancelTx!, escrow: escrow!);
      case OTStatusDto.cancelTxWaitFailure:
        return OTStatus.cancelTxWaitFailure(cancelTx!, escrow: escrow!);
    }
  }
}

extension on OutgoingTipPayment {
  Future<OTRow> toDto() async => OTRow(
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
      );
}

extension on OTStatus {
  OTStatusDto toDto() => this.map(
        txCreated: always(OTStatusDto.txCreated),
        txSent: always(OTStatusDto.txSent),
        txConfirmed: always(OTStatusDto.txConfirmed),
        linkReady: always(OTStatusDto.linkReady),
        withdrawn: always(OTStatusDto.withdrawn),
        txFailure: always(OTStatusDto.txFailure),
        txSendFailure: always(OTStatusDto.txSendFailure),
        txWaitFailure: always(OTStatusDto.txWaitFailure),
        txLinksFailure: always(OTStatusDto.txLinksFailure),
        canceled: always(OTStatusDto.canceled),
        cancelTxCreated: always(OTStatusDto.cancelTxCreated),
        cancelTxFailure: always(OTStatusDto.cancelTxFailure),
        cancelTxSent: always(OTStatusDto.cancelTxSent),
        cancelTxSendFailure: always(OTStatusDto.cancelTxSendFailure),
        cancelTxWaitFailure: always(OTStatusDto.cancelTxWaitFailure),
      );

  String? toTx() => mapOrNull(
        txCreated: (it) => it.tx.encode(),
        txSendFailure: (it) => it.tx.encode(),
        txSent: (it) => it.tx.encode(),
        txWaitFailure: (it) => it.tx.encode(),
      );

  String? toTxId() => mapOrNull(
        txCreated: (it) => it.tx.id,
        txSent: (it) => it.tx.id,
        txSendFailure: (it) => it.tx.id,
        txWaitFailure: (it) => it.tx.id,
      );

  String? toWithdrawTxId() => mapOrNull(withdrawn: (it) => it.txId);

  String? toCancelTx() => mapOrNull(
        cancelTxCreated: (it) => it.tx.encode(),
        cancelTxSent: (it) => it.tx.encode(),
        cancelTxSendFailure: (it) => it.tx.encode(),
        cancelTxWaitFailure: (it) => it.tx.encode(),
      );

  String? toCancelTxId() => mapOrNull(
        cancelTxCreated: (it) => it.tx.id,
        cancelTxSent: (it) => it.tx.id,
        cancelTxSendFailure: (it) => it.tx.id,
        cancelTxWaitFailure: (it) => it.tx.id,
        canceled: (it) => it.txId,
      );

  Future<String?> toPrivateKey() async => this.map(
        txCreated: (it) async =>
            it.escrow.extract().then((it) => it.bytes).then(base58encode),
        txSent: (it) async =>
            it.escrow.extract().then((it) => it.bytes).then(base58encode),
        txConfirmed: (it) async =>
            it.escrow.extract().then((it) => it.bytes).then(base58encode),
        linkReady: (it) async =>
            it.escrow.extract().then((it) => it.bytes).then(base58encode),
        withdrawn: (it) async => null,
        canceled: (it) async => null,
        txFailure: (it) async => null,
        txSendFailure: (it) async =>
            it.escrow.extract().then((it) => it.bytes).then(base58encode),
        txWaitFailure: (it) async =>
            it.escrow.extract().then((it) => it.bytes).then(base58encode),
        txLinksFailure: (it) async =>
            it.escrow.extract().then((it) => it.bytes).then(base58encode),
        cancelTxCreated: (it) async =>
            it.escrow.extract().then((it) => it.bytes).then(base58encode),
        cancelTxFailure: (it) async =>
            it.escrow.extract().then((it) => it.bytes).then(base58encode),
        cancelTxSent: (it) async =>
            it.escrow.extract().then((it) => it.bytes).then(base58encode),
        cancelTxSendFailure: (it) async =>
            it.escrow.extract().then((it) => it.bytes).then(base58encode),
        cancelTxWaitFailure: (it) async =>
            it.escrow.extract().then((it) => it.bytes).then(base58encode),
      );

  String? toLink() => mapOrNull(
        linkReady: (it) => it.link.toString(),
      );

  TxFailureReason? toTxFailureReason() => mapOrNull<TxFailureReason?>(
        txFailure: (it) => it.reason,
        cancelTxFailure: (it) => it.reason,
      );
}
