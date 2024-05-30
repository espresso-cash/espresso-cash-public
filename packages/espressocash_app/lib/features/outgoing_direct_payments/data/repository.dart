// ignore_for_file: avoid-non-null-assertion

import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../../data/db/db.dart';
import '../../../data/db/mixins.dart';
import '../../accounts/auth_scope.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../tokens/token_list.dart';
import '../../transactions/models/tx_results.dart';
import '../models/outgoing_direct_payment.dart';

@Singleton(scope: authScope)
class ODPRepository implements Disposable {
  const ODPRepository(this._db, this._tokens);

  final MyDatabase _db;
  final TokenList _tokens;

  Future<IList<String>> getNonCompletedPaymentIds() async {
    final query = _db.select(_db.oDPRows)
      ..where(
        (p) => p.status.isNotInValues([
          ODPStatusDto.success,
          ODPStatusDto.txFailure,
          ODPStatusDto.txSendFailure,
          ODPStatusDto.txWaitFailure,
        ]),
      );

    final rows = await query.get();

    return rows.map((row) => row.id).toIList();
  }

  Future<OutgoingDirectPayment?> load(String id) {
    final query = _db.select(_db.oDPRows)..where((p) => p.id.equals(id));

    return query.getSingleOrNull().then((row) => row?.toModel(_tokens));
  }

  Stream<OutgoingDirectPayment> watch(String id) {
    final query = _db.select(_db.oDPRows)..where((p) => p.id.equals(id));

    return query.watchSingle().map((row) => row.toModel(_tokens));
  }

  Future<void> save(OutgoingDirectPayment payment) async {
    await _db.into(_db.oDPRows).insertOnConflictUpdate(payment.toDto());
  }

  Future<void> delete(String id) async {
    await (_db.delete(_db.oDPRows)..where((p) => p.id.equals(id))).go();
  }

  @override
  Future<void> onDispose() => _db.delete(_db.oDPRows).go();
}

class ODPRows extends Table with AmountMixin, EntityMixin {
  const ODPRows();

  TextColumn get receiver => text()();
  TextColumn get reference => text().nullable()();
  IntColumn get status => intEnum<ODPStatusDto>()();

  // Status fields
  TextColumn get tx => text().nullable()();
  TextColumn get txId => text().nullable()();
  IntColumn get txFailureReason => intEnum<TxFailureReason>().nullable()();
  TextColumn get slot => text().nullable()();
}

enum ODPStatusDto {
  txCreated,
  txSent,
  success,
  txFailure,
  txSendFailure, // Legacy
  txWaitFailure, // Legacy
}

extension ODPRowExt on ODPRow {
  OutgoingDirectPayment toModel(TokenList tokens) => OutgoingDirectPayment(
        id: id,
        receiver: Ed25519HDPublicKey.fromBase58(receiver),
        reference: reference?.let(Ed25519HDPublicKey.fromBase58),
        amount: CryptoAmount(
          value: amount,
          cryptoCurrency: CryptoCurrency(token: tokens.findTokenByMint(token)!),
        ),
        created: created,
        status: status.toModel(this),
      );
}

extension on ODPStatusDto {
  ODPStatus toModel(ODPRow row) {
    final tx = row.tx?.let(SignedTx.decode);
    final slot = row.slot?.let(BigInt.tryParse);

    switch (this) {
      case ODPStatusDto.txCreated:
      case ODPStatusDto.txSendFailure:
        return ODPStatus.txCreated(
          tx!,
          slot: slot ?? BigInt.zero,
        );
      case ODPStatusDto.txSent:
      case ODPStatusDto.txWaitFailure:
        return ODPStatus.txSent(
          tx ?? StubSignedTx(row.txId!),
          slot: slot ?? BigInt.zero,
        );
      case ODPStatusDto.success:
        return ODPStatus.success(txId: row.txId!);
      case ODPStatusDto.txFailure:
        return ODPStatus.txFailure(reason: row.txFailureReason);
    }
  }
}

extension on OutgoingDirectPayment {
  ODPRow toDto() => ODPRow(
        id: id,
        receiver: receiver.toBase58(),
        reference: reference?.toBase58(),
        amount: amount.value,
        token: amount.cryptoCurrency.token.address,
        created: created,
        status: status.toDto(),
        tx: status.toTx(),
        txId: status.toTxId(),
        txFailureReason: status.toTxFailureReason(),
        slot: status.toSlot()?.toString(),
      );
}

extension on ODPStatus {
  ODPStatusDto toDto() => this.map(
        txCreated: always(ODPStatusDto.txCreated),
        txSent: always(ODPStatusDto.txSent),
        success: always(ODPStatusDto.success),
        txFailure: always(ODPStatusDto.txFailure),
      );

  String? toTx() => mapOrNull(
        txCreated: (it) => it.tx.encode(),
        txSent: (it) => it.tx.encode(),
      );

  String? toTxId() => mapOrNull(
        success: (it) => it.txId,
      );

  TxFailureReason? toTxFailureReason() => mapOrNull<TxFailureReason?>(
        txFailure: (it) => it.reason,
      );

  BigInt? toSlot() => mapOrNull(
        txCreated: (it) => it.slot,
        txSent: (it) => it.slot,
      );
}
