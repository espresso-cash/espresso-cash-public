// ignore_for_file: avoid-non-null-assertion

import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/currency.dart';
import 'package:cryptoplease/core/tokens/token_list.dart';
import 'package:cryptoplease/data/db/db.dart';
import 'package:cryptoplease/data/db/mixins.dart';
import 'package:cryptoplease/features/outgoing_split_key_payments/bl/outgoing_split_key_payment.dart';
import 'package:cryptoplease/features/outgoing_split_key_payments/bl/repository.dart';
import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:solana/base58.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

class DbOSKPRepository implements OSKPRepository {
  DbOSKPRepository(this.db, this.tokens);

  final MyDatabase db;
  final TokenList tokens;

  @override
  Future<OutgoingSplitKeyPayment?> load(String id) {
    final query = db.select(db.oSKPRows)..where((p) => p.id.equals(id));

    return query.getSingleOrNull().then((row) => row?.toModel(tokens));
  }

  @override
  Future<void> save(OutgoingSplitKeyPayment payment) async =>
      db.into(db.oSKPRows).insertOnConflictUpdate(await payment.toDto());

  @override
  Stream<OutgoingSplitKeyPayment?> watch(String id) {
    final query = db.select(db.oSKPRows)..where((p) => p.id.equals(id));

    return query.watchSingleOrNull().asyncMap((row) => row?.toModel(tokens));
  }

  @override
  Future<void> clear() => db.delete(db.oSKPRows).go();
}

class OSKPRows extends Table with AmountMixin, EntityMixin {
  IntColumn get status => intEnum<OSKPStatusDto>()();

  // Status fields
  TextColumn get tx => text().nullable()();
  TextColumn get txId => text().nullable()();
  TextColumn get privateKey => text().nullable()();
  TextColumn get link1 => text().nullable()();
  TextColumn get link2 => text().nullable()();
}

enum OSKPStatusDto {
  txCreated,
  txSent,
  txConfirmed,
  linksReady,
  success,
  txFailure,
  txSendFailure,
  txWaitFailure,
  txLinksFailure,
}

extension on OSKPRow {
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
    final escrow = await row.privateKey
        ?.let(base58decode)
        .let((it) => Ed25519HDKeyPair.fromPrivateKeyBytes(privateKey: it));
    final link1 = row.link1?.let(Uri.parse);
    final link2 = row.link2?.let(Uri.parse);

    switch (this) {
      case OSKPStatusDto.txCreated:
        return OSKPStatus.txCreated(tx!, escrow: escrow!);
      case OSKPStatusDto.txSent:
        return OSKPStatus.txSent(txId!, escrow: escrow!);
      case OSKPStatusDto.txConfirmed:
        return OSKPStatus.txConfirmed(escrow: escrow!);
      case OSKPStatusDto.linksReady:
        return OSKPStatus.linksReady(
          link1: link1!,
          link2: link2!,
          escrow: escrow!,
        );
      case OSKPStatusDto.success:
        return OSKPStatus.success(txId: txId!);
      case OSKPStatusDto.txFailure:
        return const OSKPStatus.txFailure();
      case OSKPStatusDto.txSendFailure:
        return OSKPStatus.txSendFailure(tx!, escrow: escrow!);
      case OSKPStatusDto.txWaitFailure:
        return OSKPStatus.txWaitFailure(txId!, escrow: escrow!);
      case OSKPStatusDto.txLinksFailure:
        return OSKPStatus.txLinksFailure(escrow: escrow!);
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
        privateKey: await status.toPrivateKey(),
        link1: status.toLink1(),
        link2: status.toLink2(),
      );
}

extension on OSKPStatus {
  OSKPStatusDto toDto() => this.map(
        txCreated: always(OSKPStatusDto.txCreated),
        txSent: always(OSKPStatusDto.txSent),
        txConfirmed: always(OSKPStatusDto.txConfirmed),
        linksReady: always(OSKPStatusDto.linksReady),
        success: always(OSKPStatusDto.success),
        txFailure: always(OSKPStatusDto.txFailure),
        txSendFailure: always(OSKPStatusDto.txSendFailure),
        txWaitFailure: always(OSKPStatusDto.txWaitFailure),
        txLinksFailure: always(OSKPStatusDto.txLinksFailure),
      );

  String? toTx() => mapOrNull(
        txCreated: (it) => it.tx.encode(),
        txSendFailure: (it) => it.tx.encode(),
      );

  String? toTxId() => mapOrNull(
        txSent: (it) => it.txId,
        success: (it) => it.txId,
        txWaitFailure: (it) => it.txId,
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
        success: (it) async => null,
        txFailure: (it) async => null,
        txSendFailure: (it) async =>
            it.escrow.extract().then((it) => it.bytes).then(base58encode),
        txWaitFailure: (it) async =>
            it.escrow.extract().then((it) => it.bytes).then(base58encode),
        txLinksFailure: (it) async =>
            it.escrow.extract().then((it) => it.bytes).then(base58encode),
      );

  String? toLink1() => mapOrNull(
        linksReady: (it) => it.link1.toString(),
      );

  String? toLink2() => mapOrNull(
        linksReady: (it) => it.link2.toString(),
      );
}
