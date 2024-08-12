// ignore_for_file: avoid-non-null-assertion
import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/encoder.dart';

import '../../../data/db/db.dart';
import '../../accounts/auth_scope.dart';
import '../../blockchain/models/blockchain.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../transactions/models/tx_results.dart';
import '../models/dln_payment.dart';
import '../models/outgoing_payment.dart';

@Singleton(scope: authScope)
class OutgoingDlnPaymentRepository implements Disposable {
  const OutgoingDlnPaymentRepository(this._db);

  final MyDatabase _db;

  Future<OutgoingDlnPayment?> load(String id) {
    final query = _db.select(_db.outgoingDlnPaymentRows)
      ..where((p) => p.id.equals(id));

    return query.getSingleOrNull().then((row) => row?.toModel());
  }

  Stream<List<OutgoingDlnPayment>> watchAllPending() {
    final query = _db.select(_db.outgoingDlnPaymentRows)
      ..where((p) => p.status.equalsValue(ODLNPaymentStatusDto.success).not());

    return query.watch().map(
          (rows) => rows.map((row) => row.toModel()).toList(),
        );
  }

  Future<IList<String>> getAllPending() async {
    final query = _db.select(_db.outgoingDlnPaymentRows)
      ..where(
        (p) => p.status.isNotInValues([
          ODLNPaymentStatusDto.fulfilled,
          ODLNPaymentStatusDto.txFailure,
          ODLNPaymentStatusDto.unfulfilled,
        ]),
      );

    final rows = await query.get();

    return rows.map((row) => row.id).toIList();
  }

  Stream<OutgoingDlnPayment?> watch(String id) {
    final query = _db.select(_db.outgoingDlnPaymentRows)
      ..where((p) => p.id.equals(id));

    return query.watchSingleOrNull().asyncMap((row) => row?.toModel());
  }

  Future<void> save(OutgoingDlnPayment payment) => _db
      .into(_db.outgoingDlnPaymentRows)
      .insertOnConflictUpdate(payment.toDto());

  Future<void> delete(String id) {
    final query = _db.delete(_db.outgoingDlnPaymentRows)
      ..where((p) => p.id.equals(id));

    return query.go();
  }

  @override
  void onDispose() {
    _db.delete(_db.outgoingDlnPaymentRows).go();
  }
}

extension OutgoingDlnPaymentRowExt on OutgoingDlnPaymentRow {
  OutgoingDlnPayment toModel() => OutgoingDlnPayment(
        id: id,
        status: status.toModel(this),
        created: created,
        amount: CryptoAmount(
          value: amount,
          cryptoCurrency: Currency.usdc,
        ),
        payment: DlnPayment(
          receiverAddress: receiverAddress,
          receiverBlockchain: receiverBlockchain.toModel(),
          inputAmount: CryptoAmount(
            value: amount,
            cryptoCurrency: Currency.usdc,
          ),
        ),
      );
}

extension on ODLNPaymentStatusDto {
  OutgoingDlnPaymentStatus toModel(OutgoingDlnPaymentRow row) {
    final tx = row.tx?.let(SignedTx.decode);
    final slot = row.slot?.let(BigInt.tryParse);

    switch (this) {
      case ODLNPaymentStatusDto.txCreated:
        return OutgoingDlnPaymentStatus.txCreated(
          tx!,
          slot: slot ?? BigInt.zero,
        );
      case ODLNPaymentStatusDto.txSent:
        return OutgoingDlnPaymentStatus.txSent(tx!, slot: slot ?? BigInt.zero);
      case ODLNPaymentStatusDto.success:
        return OutgoingDlnPaymentStatus.success(
          tx!,
          orderId: row.orderId ?? '',
        );
      case ODLNPaymentStatusDto.txFailure:
        return OutgoingDlnPaymentStatus.txFailure(
          reason: row.txFailureReason ?? TxFailureReason.unknown,
        );
      case ODLNPaymentStatusDto.fulfilled:
        return OutgoingDlnPaymentStatus.fulfilled(
          tx!,
          orderId: row.orderId ?? '',
        );
      case ODLNPaymentStatusDto.unfulfilled:
        return OutgoingDlnPaymentStatus.unfulfilled(
          tx!,
          orderId: row.orderId ?? '',
        );
    }
  }
}

extension on Blockchain {
  BlockchainDto toDto() => switch (this) {
        Blockchain.solana => BlockchainDto.solana,
        Blockchain.arbitrum => BlockchainDto.arbitrum,
        Blockchain.polygon => BlockchainDto.polygon,
        Blockchain.ethereum => BlockchainDto.ethereum,
      };
}

extension on BlockchainDto {
  Blockchain toModel() => switch (this) {
        BlockchainDto.solana => Blockchain.solana,
        BlockchainDto.arbitrum => Blockchain.arbitrum,
        BlockchainDto.polygon => Blockchain.polygon,
        BlockchainDto.ethereum => Blockchain.ethereum,
      };
}

extension on OutgoingDlnPayment {
  OutgoingDlnPaymentRow toDto() => OutgoingDlnPaymentRow(
        id: id,
        created: created,
        status: status.toDto(),
        tx: status.toTx(),
        txId: status.toTxId(),
        amount: amount.value,
        slot: status.toSlot()?.toString(),
        receiverBlockchain: payment.receiverBlockchain.toDto(),
        receiverAddress: payment.receiverAddress,
        txFailureReason: status.toTxFailureReason(),
        orderId: status.toOrderId(),
      );
}

extension on OutgoingDlnPaymentStatus {
  ODLNPaymentStatusDto toDto() => this.map(
        txCreated: always(ODLNPaymentStatusDto.txCreated),
        txSent: always(ODLNPaymentStatusDto.txSent),
        success: always(ODLNPaymentStatusDto.success),
        txFailure: always(ODLNPaymentStatusDto.txFailure),
        fulfilled: always(ODLNPaymentStatusDto.fulfilled),
        unfulfilled: always(ODLNPaymentStatusDto.unfulfilled),
      );

  String? toTx() => mapOrNull(
        txCreated: (it) => it.tx.encode(),
        txSent: (it) => it.tx.encode(),
        success: (it) => it.tx.encode(),
        unfulfilled: (it) => it.tx.encode(),
      );

  String? toTxId() => mapOrNull(
        txSent: (it) => it.tx.id,
        success: (it) => it.tx.id,
        txCreated: (it) => it.tx.id,
        unfulfilled: (it) => it.tx.id,
      );

  String? toOrderId() => mapOrNull(
        success: (it) => it.orderId,
        fulfilled: (it) => it.orderId,
        unfulfilled: (it) => it.orderId,
      );

  TxFailureReason? toTxFailureReason() => mapOrNull<TxFailureReason?>(
        txFailure: (it) => it.reason,
      );

  BigInt? toSlot() => mapOrNull(
        txCreated: (it) => it.slot,
        txSent: (it) => it.slot,
      );
}
