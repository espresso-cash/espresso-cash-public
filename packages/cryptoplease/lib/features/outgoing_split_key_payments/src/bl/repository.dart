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
import '../../models/outgoing_split_key_payment.dart';

@injectable
class OSKPRepository {
  OSKPRepository(this._db, this._tokens);

  final MyDatabase _db;
  final TokenList _tokens;

  Future<OutgoingSplitKeyPayment?> load(String id) {
    final query = _db.select(_db.oSKPRows)..where((p) => p.id.equals(id));

    return query.getSingleOrNull().then((row) => row?.toModel(_tokens));
  }

  Future<void> save(OutgoingSplitKeyPayment payment) async =>
      _db.into(_db.oSKPRows).insertOnConflictUpdate(await payment.toDto());

  Stream<OutgoingSplitKeyPayment?> watch(String id) {
    final query = _db.select(_db.oSKPRows)..where((p) => p.id.equals(id));

    return query.watchSingleOrNull().asyncMap((row) => row?.toModel(_tokens));
  }

  Stream<List<OutgoingSplitKeyPayment>> watchWithReadyLinks() {
    final query = _db.select(_db.oSKPRows)
      ..where((p) => p.status.equalsValue(OSKPStatusDto.linksReady));

    return query.watch().asyncMap(
          (rows) => Future.wait(rows.map((row) => row.toModel(_tokens))),
        );
  }

  Future<void> clear() => _db.delete(_db.oSKPRows).go();
}

class OSKPRows extends Table with AmountMixin, EntityMixin {
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
          currency: CryptoCurrency(token: tokens.findTokenByMint(token)!),
        ),
        status: await status.toOSKPStatus(this),
      );
}

extension on OSKPStatusDto {
  Future<OSKPStatus> toOSKPStatus(OSKPRow row) async {
    final tx = row.tx?.let(SignedTx.decode);
    final txId = row.txId;
    final withdrawTxId = row.withdrawTxId;
    final escrow = await row.privateKey
        ?.let(base58decode)
        .let((it) => Ed25519HDKeyPair.fromPrivateKeyBytes(privateKey: it));
    final link1 = row.link1?.let(Uri.parse);
    final link2 = row.link2?.let(Uri.parse);
    final link3 = row.link3?.let(Uri.parse);
    final cancelTx = row.cancelTx?.let(SignedTx.decode);
    final cancelTxId = row.cancelTxId;

    switch (this) {
      case OSKPStatusDto.txCreated:
        return OSKPStatus.txCreated(tx!, escrow: escrow!);
      case OSKPStatusDto.txSent:
        return OSKPStatus.txSent(tx ?? StubSignedTx(txId!), escrow: escrow!);
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
        return OSKPStatus.withdrawn(txId: txId!);
      case OSKPStatusDto.withdrawn:
        return OSKPStatus.withdrawn(txId: withdrawTxId!);
      case OSKPStatusDto.canceled:
        if (cancelTxId == null) {
          // For compatibility with old versions
          return OSKPStatus.canceled(txId: withdrawTxId!);
        } else {
          return OSKPStatus.canceled(txId: cancelTxId);
        }
      case OSKPStatusDto.txFailure:
        return OSKPStatus.txFailure(reason: row.txFailureReason);
      case OSKPStatusDto.txSendFailure:
        return OSKPStatus.txSendFailure(tx!, escrow: escrow!);
      case OSKPStatusDto.txWaitFailure:
        return OSKPStatus.txWaitFailure(
          tx ?? StubSignedTx(txId!),
          escrow: escrow!,
        );
      case OSKPStatusDto.txLinksFailure:
        return OSKPStatus.txLinksFailure(escrow: escrow!);
      case OSKPStatusDto.cancelTxCreated:
        return OSKPStatus.cancelTxCreated(cancelTx!, escrow: escrow!);
      case OSKPStatusDto.cancelTxFailure:
        return OSKPStatus.cancelTxFailure(escrow: escrow!);
      case OSKPStatusDto.cancelTxSent:
        return OSKPStatus.cancelTxSent(cancelTx!, escrow: escrow!);
      case OSKPStatusDto.cancelTxSendFailure:
        return OSKPStatus.cancelTxSendFailure(cancelTx!, escrow: escrow!);
      case OSKPStatusDto.cancelTxWaitFailure:
        return OSKPStatus.cancelTxWaitFailure(cancelTx!, escrow: escrow!);
    }
  }
}

extension on OutgoingSplitKeyPayment {
  Future<OSKPRow> toDto() async => OSKPRow(
        amount: amount.value,
        token: amount.currency.token.address,
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
        txSendFailure: always(OSKPStatusDto.txSendFailure),
        txWaitFailure: always(OSKPStatusDto.txWaitFailure),
        txLinksFailure: always(OSKPStatusDto.txLinksFailure),
        canceled: always(OSKPStatusDto.canceled),
        cancelTxCreated: always(OSKPStatusDto.cancelTxCreated),
        cancelTxFailure: always(OSKPStatusDto.cancelTxFailure),
        cancelTxSent: always(OSKPStatusDto.cancelTxSent),
        cancelTxSendFailure: always(OSKPStatusDto.cancelTxSendFailure),
        cancelTxWaitFailure: always(OSKPStatusDto.cancelTxWaitFailure),
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
        linksReady: (it) async =>
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
}
