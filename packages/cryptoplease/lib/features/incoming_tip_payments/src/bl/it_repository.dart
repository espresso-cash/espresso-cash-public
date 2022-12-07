// ignore_for_file: avoid-non-null-assertion

import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/base58.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../../../core/transactions/tx_sender.dart';
import '../../../../data/db/db.dart';
import '../../../../data/db/mixins.dart';
import 'incoming_tip_payment.dart';

@injectable
class ITRepository {
  ITRepository(this._db);

  final MyDatabase _db;

  Future<IncomingTipPayment?> load(String id) {
    final query = _db.select(_db.incomingTipRows)
      ..where((p) => p.id.equals(id));

    return query.getSingleOrNull().then((row) => row?.toModel());
  }

  Stream<IncomingTipPayment?> watch(String id) {
    final query = _db.select(_db.incomingTipRows)
      ..where((p) => p.id.equals(id));

    return query.watchSingleOrNull().asyncMap((row) => row?.toModel());
  }

  Future<void> save(IncomingTipPayment payment) async => _db
      .into(_db.incomingTipRows)
      .insertOnConflictUpdate(await payment.toDto());

  Future<void> clear() => _db.delete(_db.iSKPRows).go();
}

class IncomingTipRows extends Table with EntityMixin {
  TextColumn get privateKey => text()();
  IntColumn get status => intEnum<ITStatusDto>()();

  // Status fields
  TextColumn get tx => text().nullable()();
  TextColumn get txId => text().nullable()();
}

enum ITStatusDto {
  privateKeyReady,
  txCreated,
  txSent,
  success,
  txFailure,
  txSendFailure,
  txWaitFailure,
  txEscrowFailure,
}

extension on IncomingTipRow {
  Future<IncomingTipPayment> toModel() async {
    final escrow = await privateKey
        .let(base58decode)
        .let((it) => Ed25519HDKeyPair.fromPrivateKeyBytes(privateKey: it));

    return IncomingTipPayment(
      id: id,
      status: status.toModel(this),
      created: created,
      escrow: escrow,
    );
  }
}

extension on ITStatusDto {
  ITStatus toModel(IncomingTipRow row) {
    final tx = row.tx?.let(SignedTx.decode);
    final txId = row.txId;

    switch (this) {
      case ITStatusDto.privateKeyReady:
        return const ITStatus.privateKeyReady();
      case ITStatusDto.txCreated:
        return ITStatus.txCreated(tx!);
      case ITStatusDto.txSent:
        return ITStatus.txSent(tx ?? StubSignedTx(txId!));
      case ITStatusDto.success:
        return ITStatus.success(txId: txId!);
      case ITStatusDto.txFailure:
        return const ITStatus.txFailure();
      case ITStatusDto.txSendFailure:
        return ITStatus.txSendFailure(tx!);
      case ITStatusDto.txWaitFailure:
        return ITStatus.txWaitFailure(tx ?? StubSignedTx(txId!));
      case ITStatusDto.txEscrowFailure:
        return const ITStatus.txEscrowFailure();
    }
  }
}

extension on IncomingTipPayment {
  Future<IncomingTipRow> toDto() async => IncomingTipRow(
        id: id,
        created: created,
        privateKey:
            await escrow.extract().then((it) => it.bytes).then(base58encode),
        status: status.toDto(),
        tx: status.toTx(),
        txId: status.toTxId(),
      );
}

extension on ITStatus {
  ITStatusDto toDto() => this.map(
        privateKeyReady: always(ITStatusDto.privateKeyReady),
        txCreated: always(ITStatusDto.txCreated),
        txSent: always(ITStatusDto.txSent),
        success: always(ITStatusDto.success),
        txFailure: always(ITStatusDto.txFailure),
        txSendFailure: always(ITStatusDto.txSendFailure),
        txWaitFailure: always(ITStatusDto.txWaitFailure),
        txEscrowFailure: always(ITStatusDto.txEscrowFailure),
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
}
