// ignore_for_file: avoid-non-null-assertion

import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/encoder.dart';

import '../../../core/amount.dart';
import '../../../core/blockchain.dart';
import '../../../core/currency.dart';
import '../../../data/db/db.dart';
import '../../../data/db/mixins.dart';
import '../../transactions/models/tx_sender.dart';
import '../models/dln_payment.dart';
import '../models/outgoing_payment.dart';

@injectable
class OutgoingDlnPaymentRepository {
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

  Stream<OutgoingDlnPayment?> watch(String id) {
    final query = _db.select(_db.outgoingDlnPaymentRows)
      ..where((p) => p.id.equals(id));

    return query.watchSingleOrNull().asyncMap((row) => row?.toModel());
  }

  Future<void> save(OutgoingDlnPayment payment) => _db
      .into(_db.outgoingDlnPaymentRows)
      .insertOnConflictUpdate(payment.toDto());

  Future<void> clear() => _db.delete(_db.outgoingDlnPaymentRows).go();

  Stream<IList<OutgoingDlnPayment>> watchTxCreated() => _watchWithStatuses([
        ODLNPaymentStatusDto.txCreated,
      ]);

  Stream<IList<OutgoingDlnPayment>> watchTxSent() => _watchWithStatuses([
        ODLNPaymentStatusDto.txSent,
      ]);

  Stream<IList<OutgoingDlnPayment>> _watchWithStatuses(
    Iterable<ODLNPaymentStatusDto> statuses,
  ) {
    final query = _db.select(_db.outgoingDlnPaymentRows)
      ..where((p) => p.status.isInValues(statuses));

    return query
        .watch()
        .asyncMap((rows) => rows.map((row) => row.toModel()))
        .map((it) => it.toIList());
  }
}

class OutgoingDlnPaymentRows extends Table with EntityMixin, TxStatusMixin {
  const OutgoingDlnPaymentRows();

  TextColumn get receiverBlockchain => textEnum<BlockchainDto>()();
  TextColumn get receiverAddress => text()();
  IntColumn get amount => integer()();
  IntColumn get status => intEnum<ODLNPaymentStatusDto>()();
}

enum BlockchainDto {
  solana,
  arbitrum,
}

enum ODLNPaymentStatusDto {
  txCreated,
  txSent,
  success,
  txFailure,
  fulfilled,
  cancelled,
}

extension OutgoingDlnPaymentRowExt on OutgoingDlnPaymentRow {
  OutgoingDlnPayment toModel() => OutgoingDlnPayment(
        id: id,
        status: status.toModel(this),
        created: created,
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
        return OutgoingDlnPaymentStatus.success(tx!);
      case ODLNPaymentStatusDto.txFailure:
        return OutgoingDlnPaymentStatus.txFailure(
          reason: row.txFailureReason ?? TxFailureReason.unknown,
        );
      case ODLNPaymentStatusDto.fulfilled:
        return OutgoingDlnPaymentStatus.fulfilled(tx!);
      case ODLNPaymentStatusDto.cancelled:
        return OutgoingDlnPaymentStatus.cancelled(tx!);
    }
  }
}

extension on Blockchain {
  BlockchainDto toDto() => switch (this) {
        Blockchain.solana => BlockchainDto.solana,
        Blockchain.arbitrum => BlockchainDto.arbitrum,
      };
}

extension on BlockchainDto {
  Blockchain toModel() => switch (this) {
        BlockchainDto.solana => Blockchain.solana,
        BlockchainDto.arbitrum => Blockchain.arbitrum,
      };
}

extension on OutgoingDlnPayment {
  OutgoingDlnPaymentRow toDto() => OutgoingDlnPaymentRow(
        id: id,
        created: created,
        status: status.toDto(),
        tx: status.toTx(),
        txId: status.toTxId(),
        amount: payment.inputAmount.value,
        slot: status.toSlot().toString(),
        receiverBlockchain: payment.receiverBlockchain.toDto(),
        receiverAddress: payment.receiverAddress,
        txFailureReason: status.toTxFailureReason(),
      );
}

extension on OutgoingDlnPaymentStatus {
  ODLNPaymentStatusDto toDto() => this.map(
        txCreated: always(ODLNPaymentStatusDto.txCreated),
        txSent: always(ODLNPaymentStatusDto.txSent),
        success: always(ODLNPaymentStatusDto.success),
        txFailure: always(ODLNPaymentStatusDto.txFailure),
        fulfilled: always(ODLNPaymentStatusDto.fulfilled),
        cancelled: always(ODLNPaymentStatusDto.cancelled),
      );

  String? toTx() => mapOrNull(
        txCreated: (it) => it.tx.encode(),
        txSent: (it) => it.tx.encode(),
        success: (it) => it.tx.encode(),
      );

  String? toTxId() => mapOrNull(
        txSent: (it) => it.tx.id,
        success: (it) => it.tx.id,
        txCreated: (it) => it.tx.id,
      );

  TxFailureReason? toTxFailureReason() => mapOrNull<TxFailureReason?>(
        txFailure: (it) => it.reason,
      );

  BigInt? toSlot() => mapOrNull(
        txCreated: (it) => it.slot,
        txSent: (it) => it.slot,
      );
}
