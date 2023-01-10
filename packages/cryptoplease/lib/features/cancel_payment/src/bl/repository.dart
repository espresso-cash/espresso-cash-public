// ignore_for_file: avoid-non-null-assertion

import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/base58.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../../../data/db/db.dart';
import '../payment_cancel.dart';

@injectable
class PaymentCancelRepository {
  PaymentCancelRepository(this._db);

  final MyDatabase _db;

  Future<PaymentCancel?> load(String paymentId) {
    final query = _db.select(_db.paymentCancelRows)
      ..where((p) => p.paymentId.equals(paymentId));

    return query.getSingleOrNull().then((row) => row?.toModel());
  }

  Stream<PaymentCancel?> watch(String paymentId) {
    final query = _db.select(_db.paymentCancelRows)
      ..where((p) => p.paymentId.equals(paymentId));

    return query.watchSingleOrNull().asyncMap((row) => row?.toModel());
  }

  Future<void> save(PaymentCancel payment) async => _db
      .into(_db.paymentCancelRows)
      .insertOnConflictUpdate(await payment.toDto());

  Future<void> clear() => _db.delete(_db.paymentCancelRows).go();
}

class PaymentCancelRows extends Table {
  TextColumn get paymentId => text()();
  DateTimeColumn get created => dateTime()();

  TextColumn get privateKey => text()();
  IntColumn get status => intEnum<PaymentCancelStatusDto>()();

  // Status fields
  TextColumn get tx => text().nullable()();
  TextColumn get txId => text().nullable()();

  @override
  Set<Column<dynamic>>? get primaryKey => {paymentId};
}

enum PaymentCancelStatusDto {
  txCreated,
  txSent,
  success,
  txFailure,
  txSendFailure,
  txWaitFailure,
  txEscrowFailure,
}

extension on PaymentCancelRow {
  Future<PaymentCancel> toModel() async {
    final escrow = await privateKey
        .let(base58decode)
        .let((it) => Ed25519HDKeyPair.fromPrivateKeyBytes(privateKey: it));

    return PaymentCancel(
      paymentId: paymentId,
      status: status.toModel(this),
      created: created,
      escrow: escrow,
    );
  }
}

extension on PaymentCancelStatusDto {
  PaymentCancelStatus toModel(PaymentCancelRow row) {
    final tx = row.tx?.let(SignedTx.decode);
    final txId = row.txId;

    switch (this) {
      case PaymentCancelStatusDto.txCreated:
        return PaymentCancelStatus.txCreated(tx!);
      case PaymentCancelStatusDto.txSent:
        return PaymentCancelStatus.txSent(tx!);
      case PaymentCancelStatusDto.success:
        return PaymentCancelStatus.success(txId: txId!);
      case PaymentCancelStatusDto.txFailure:
        return const PaymentCancelStatus.txFailure();
      case PaymentCancelStatusDto.txSendFailure:
        return PaymentCancelStatus.txSendFailure(tx!);
      case PaymentCancelStatusDto.txWaitFailure:
        return PaymentCancelStatus.txWaitFailure(tx!);
      case PaymentCancelStatusDto.txEscrowFailure:
        return const PaymentCancelStatus.txEscrowFailure();
    }
  }
}

extension on PaymentCancel {
  Future<PaymentCancelRow> toDto() async => PaymentCancelRow(
        paymentId: paymentId,
        created: created,
        privateKey:
            await escrow.extract().then((it) => it.bytes).then(base58encode),
        status: status.toDto(),
        tx: status.toTx(),
        txId: status.toTxId(),
      );
}

extension on PaymentCancelStatus {
  PaymentCancelStatusDto toDto() => this.map(
        txCreated: always(PaymentCancelStatusDto.txCreated),
        txSent: always(PaymentCancelStatusDto.txSent),
        success: always(PaymentCancelStatusDto.success),
        txFailure: always(PaymentCancelStatusDto.txFailure),
        txSendFailure: always(PaymentCancelStatusDto.txSendFailure),
        txWaitFailure: always(PaymentCancelStatusDto.txWaitFailure),
        txEscrowFailure: always(PaymentCancelStatusDto.txEscrowFailure),
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
