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
import 'outgoing_tip_payment.dart';

@injectable
class OutgoingTipRepository {
  OutgoingTipRepository(this._db, this._tokens);

  final MyDatabase _db;
  final TokenList _tokens;

  Future<OutgoingTipPayment?> load(String id) {
    final query = _db.select(_db.outgoingTipRows)
      ..where((p) => p.id.equals(id));

    return query.getSingleOrNull().then((row) => row?.toModel(_tokens));
  }

  Future<void> save(OutgoingTipPayment payment) async => _db
      .into(_db.outgoingTipRows)
      .insertOnConflictUpdate(await payment.toDto());

  Stream<OutgoingTipPayment?> watch(String id) {
    final query = _db.select(_db.outgoingTipRows)
      ..where((p) => p.id.equals(id));

    return query.watchSingleOrNull().asyncMap((row) => row?.toModel(_tokens));
  }

  Stream<List<OutgoingTipPayment>> watchWithReadyLinks() {
    final query = _db.select(_db.outgoingTipRows)
      ..where((p) => p.status.equalsValue(OutgoingTipStatusDto.linkReady));

    return query.watch().asyncMap(
          (rows) => Future.wait(rows.map((row) => row.toModel(_tokens))),
        );
  }

  Future<void> clear() => _db.delete(_db.outgoingTipRows).go();
}

class OutgoingTipRows extends Table with AmountMixin, EntityMixin {
  IntColumn get status => intEnum<OutgoingTipStatusDto>()();

  // Status fields
  TextColumn get tx => text().nullable()();
  TextColumn get txId => text().nullable()();
  TextColumn get privateKey => text().nullable()();
  TextColumn get link => text().nullable()();
  IntColumn get txFailureReason => intEnum<TxFailureReason>().nullable()();
}

enum OutgoingTipStatusDto {
  txCreated,
  txSent,
  txConfirmed,
  linkReady,
  success,
  txFailure,
  txSendFailure,
  txWaitFailure,
  txLinksFailure,
}

extension OutgoingTipRowExt on OutgoingTipRow {
  Future<OutgoingTipPayment> toModel(TokenList tokens) async =>
      OutgoingTipPayment(
        id: id,
        created: created,
        amount: CryptoAmount(
          value: amount,
          currency: CryptoCurrency(token: tokens.findTokenByMint(token)!),
        ),
        status: await status.toOutgoingTipStatus(this),
      );
}

extension on OutgoingTipStatusDto {
  Future<OutgoingTipStatus> toOutgoingTipStatus(OutgoingTipRow row) async {
    final tx = row.tx?.let(SignedTx.decode);
    final txId = row.txId;
    final escrow = await row.privateKey
        ?.let(base58decode)
        .let((it) => Ed25519HDKeyPair.fromPrivateKeyBytes(privateKey: it));
    final link1 = row.link?.let(Uri.parse);

    switch (this) {
      case OutgoingTipStatusDto.txCreated:
        return OutgoingTipStatus.txCreated(tx!, escrow: escrow!);
      case OutgoingTipStatusDto.txSent:
        return OutgoingTipStatus.txSent(
          tx ?? StubSignedTx(txId!),
          escrow: escrow!,
        );
      case OutgoingTipStatusDto.txConfirmed:
        return OutgoingTipStatus.txConfirmed(escrow: escrow!);
      case OutgoingTipStatusDto.linkReady:
        return OutgoingTipStatus.linkReady(
          link: link1!,
          escrow: escrow!,
        );
      case OutgoingTipStatusDto.success:
        return OutgoingTipStatus.success(txId: txId!);
      case OutgoingTipStatusDto.txFailure:
        return OutgoingTipStatus.txFailure(reason: row.txFailureReason);
      case OutgoingTipStatusDto.txSendFailure:
        return OutgoingTipStatus.txSendFailure(tx!, escrow: escrow!);
      case OutgoingTipStatusDto.txWaitFailure:
        return OutgoingTipStatus.txWaitFailure(
          tx ?? StubSignedTx(txId!),
          escrow: escrow!,
        );
      case OutgoingTipStatusDto.txLinksFailure:
        return OutgoingTipStatus.txLinksFailure(escrow: escrow!);
    }
  }
}

extension on OutgoingTipPayment {
  Future<OutgoingTipRow> toDto() async => OutgoingTipRow(
        amount: amount.value,
        token: amount.currency.token.address,
        id: id,
        created: created,
        status: status.toDto(),
        tx: status.toTx(),
        txId: status.toTxId(),
        privateKey: await status.toPrivateKey(),
        link: status.toLink(),
        txFailureReason: status.toTxFailureReason(),
      );
}

extension on OutgoingTipStatus {
  OutgoingTipStatusDto toDto() => this.map(
        txCreated: always(OutgoingTipStatusDto.txCreated),
        txSent: always(OutgoingTipStatusDto.txSent),
        txConfirmed: always(OutgoingTipStatusDto.txConfirmed),
        linkReady: always(OutgoingTipStatusDto.linkReady),
        success: always(OutgoingTipStatusDto.success),
        txFailure: always(OutgoingTipStatusDto.txFailure),
        txSendFailure: always(OutgoingTipStatusDto.txSendFailure),
        txWaitFailure: always(OutgoingTipStatusDto.txWaitFailure),
        txLinksFailure: always(OutgoingTipStatusDto.txLinksFailure),
      );

  String? toTx() => mapOrNull(
        txCreated: (it) => it.tx.encode(),
        txSendFailure: (it) => it.tx.encode(),
        txSent: (it) => it.tx.encode(),
        txWaitFailure: (it) => it.tx.encode(),
      );

  String? toTxId() => mapOrNull(
        success: (it) => it.txId,
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
        success: (it) async => null,
        txFailure: (it) async => null,
        txSendFailure: (it) async =>
            it.escrow.extract().then((it) => it.bytes).then(base58encode),
        txWaitFailure: (it) async =>
            it.escrow.extract().then((it) => it.bytes).then(base58encode),
        txLinksFailure: (it) async =>
            it.escrow.extract().then((it) => it.bytes).then(base58encode),
      );

  String? toLink() => mapOrNull(
        linkReady: (it) => it.link.toString(),
      );

  TxFailureReason? toTxFailureReason() => mapOrNull<TxFailureReason?>(
        txFailure: (it) => it.reason,
      );
}
