// ignore_for_file: avoid-non-null-assertion

import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/base58.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../../../data/db/db.dart';
import '../cancel_outgoing_payment.dart';

@injectable
class COPRepository {
  COPRepository(this._db);

  final MyDatabase _db;

  Future<CancelOutgoingPayment?> load(String paymentId) {
    final query = _db.select(_db.cOPRows)
      ..where((p) => p.paymentId.equals(paymentId));

    return query.getSingleOrNull().then((row) => row?.toModel());
  }

  Stream<CancelOutgoingPayment?> watch(String paymentId) {
    final query = _db.select(_db.cOPRows)
      ..where((p) => p.paymentId.equals(paymentId));

    return query.watchSingleOrNull().asyncMap((row) => row?.toModel());
  }

  Future<void> save(CancelOutgoingPayment payment) async =>
      _db.into(_db.cOPRows).insertOnConflictUpdate(await payment.toDto());

  Future<void> clear() => _db.delete(_db.cOPRows).go();
}

class COPRows extends Table {
  TextColumn get paymentId => text()();
  DateTimeColumn get created => dateTime()();

  TextColumn get privateKey => text()();
  IntColumn get status => intEnum<COPStatusDto>()();

  // Status fields
  TextColumn get tx => text().nullable()();
  TextColumn get txId => text().nullable()();

  @override
  Set<Column<dynamic>>? get primaryKey => {paymentId};
}

enum COPStatusDto {
  txCreated,
  txSent,
  success,
  txFailure,
  txSendFailure,
  txWaitFailure,
  txEscrowFailure,
}

extension on COPRow {
  Future<CancelOutgoingPayment> toModel() async {
    final escrow = await privateKey
        .let(base58decode)
        .let((it) => Ed25519HDKeyPair.fromPrivateKeyBytes(privateKey: it));

    return CancelOutgoingPayment(
      paymentId: paymentId,
      status: status.toModel(this),
      created: created,
      escrow: escrow,
    );
  }
}

extension on COPStatusDto {
  COPStatus toModel(COPRow row) {
    final tx = row.tx?.let(SignedTx.decode);
    final txId = row.txId;

    switch (this) {
      case COPStatusDto.txCreated:
        return COPStatus.txCreated(tx!);
      case COPStatusDto.txSent:
        return COPStatus.txSent(tx!);
      case COPStatusDto.success:
        return COPStatus.success(txId: txId!);
      case COPStatusDto.txFailure:
        return const COPStatus.txFailure();
      case COPStatusDto.txSendFailure:
        return COPStatus.txSendFailure(tx!);
      case COPStatusDto.txWaitFailure:
        return COPStatus.txWaitFailure(tx!);
      case COPStatusDto.txEscrowFailure:
        return const COPStatus.txEscrowFailure();
    }
  }
}

extension on CancelOutgoingPayment {
  Future<COPRow> toDto() async => COPRow(
        paymentId: paymentId,
        created: created,
        privateKey:
            await escrow.extract().then((it) => it.bytes).then(base58encode),
        status: status.toDto(),
        tx: status.toTx(),
        txId: status.toTxId(),
      );
}

extension on COPStatus {
  COPStatusDto toDto() => this.map(
        txCreated: always(COPStatusDto.txCreated),
        txSent: always(COPStatusDto.txSent),
        success: always(COPStatusDto.success),
        txFailure: always(COPStatusDto.txFailure),
        txSendFailure: always(COPStatusDto.txSendFailure),
        txWaitFailure: always(COPStatusDto.txWaitFailure),
        txEscrowFailure: always(COPStatusDto.txEscrowFailure),
      );

  String? toTx() => mapOrNull(
        txCreated: (it) => it.tx.encode(),
        txSendFailure: (it) => it.tx.encode(),
      );

  String? toTxId() => mapOrNull(
        txSent: (it) => it.tx.id,
        success: (it) => it.txId,
        txWaitFailure: (it) => it.tx.id,
      );
}
