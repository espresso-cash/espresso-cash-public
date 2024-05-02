import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:solana/encoder.dart';
import 'package:uuid/uuid.dart';

import '../../../data/db/db.dart';
import '../../accounts/auth_scope.dart';
import '../../accounts/models/ec_wallet.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../tokens/token.dart';
import '../../transactions/models/tx_results.dart';
import '../../transactions/services/resign_tx.dart';
import '../../transactions/services/tx_sender.dart';
import '../models/transaction_request.dart';

@Singleton(scope: authScope)
class TRService {
  TRService(this._account, this._db, this._txSender);

  final ECWallet _account;
  final MyDatabase _db;
  final TxSender _txSender;

  final Map<String, StreamSubscription<void>> _subscriptions = {};

  Stream<TransactionRequestPayment> watch(String paymentId) {
    final query = _db.select(_db.transactionRequestRows)
      ..where((tbl) => tbl.id.equals(paymentId));

    return query.watchSingle().map((row) => row.toModel());
  }

  Stream<IList<TransactionRequestPayment>> watchPending() {
    final query = _db.select(_db.transactionRequestRows)
      ..where((tbl) => tbl.status.equalsValue(TRStatusDto.success).not());

    return query.watch().map(
          (rows) => rows.map((r) => r.toModel()).toIList(),
        );
  }

  Future<String> create({
    required SignedTx tx,
    required CryptoAmount amount,
    required BigInt slot,
    required String label,
  }) async {
    final id = const Uuid().v4();

    final signed = await tx.let((it) => it.resign(_account));

    final row = TransactionRequestRow(
      id: id,
      created: DateTime.now(),
      amount: amount.value,
      slot: slot,
      transaction: signed.encode(),
      status: TRStatusDto.created,
      token: Token.usdc.address,
      label: label,
    );

    await _db.into(_db.transactionRequestRows).insert(row);
    _subscribe(id);

    return id;
  }

  Future<void> cancel(String paymentId) async {
    final query = _db.select(_db.transactionRequestRows)
      ..where((tbl) => tbl.id.equals(paymentId));

    final payment = await query.getSingle();

    if (payment.status == TRStatusDto.success) return;

    await (_db.delete(_db.transactionRequestRows)
          ..where((p) => p.id.equals(paymentId)))
        .go();
  }

  Future<void> retry(String paymentId) async {
    final query = _db.select(_db.transactionRequestRows)
      ..where((tbl) => tbl.id.equals(paymentId));
    final payment = await query.getSingle();

    if (payment.status != TRStatusDto.failure) return;

    final updateQuery = _db.update(_db.transactionRequestRows)
      ..where((tbl) => tbl.id.equals(paymentId));

    await updateQuery.write(
      const TransactionRequestRowsCompanion(
        status: Value(TRStatusDto.created),
      ),
    );

    _subscribe(paymentId);
  }

  void _subscribe(String paymentId) {
    _subscriptions[paymentId] = (_db.select(_db.transactionRequestRows)
          ..where((tbl) => tbl.id.equals(paymentId)))
        .watchSingle()
        .asyncExpand<TransactionRequestRowsCompanion?>((payment) {
          switch (payment.status) {
            case TRStatusDto.created:
              final tx = SignedTx.decode(payment.transaction)
                  .let((it) => (it, payment.slot));

              return Stream.fromFuture(_send(tx));
            case TRStatusDto.sent:
              final tx = SignedTx.decode(payment.transaction)
                  .let((it) => (it, payment.slot));

              return Stream.fromFuture(_wait(tx));
            case TRStatusDto.success:
            case TRStatusDto.failure:
              _subscriptions.remove(paymentId)?.cancel();

              return null;
          }
        })
        .whereNotNull()
        .listen(
          (event) => (_db.update(_db.transactionRequestRows)
                ..where((tbl) => tbl.id.equals(paymentId)))
              .write(event),
        );
  }

  Future<TransactionRequestRowsCompanion?> _send((SignedTx, BigInt) tx) async {
    final sent = await _txSender.send(tx.$1, minContextSlot: tx.$2);

    return switch (sent) {
      TxSendSent() => const TransactionRequestRowsCompanion(
          status: Value(TRStatusDto.sent),
        ),
      TxSendInvalidBlockhash() ||
      TxSendFailure() =>
        const TransactionRequestRowsCompanion(
          status: Value(
            TRStatusDto.failure,
          ),
        ),
      TxSendNetworkError() => null,
    };
  }

  Future<TransactionRequestRowsCompanion?> _wait((SignedTx, BigInt) tx) async {
    final confirmed = await _txSender.wait(
      tx.$1,
      minContextSlot: tx.$2,
      txType: 'TransactionRequest',
    );

    return switch (confirmed) {
      TxWaitSuccess() => const TransactionRequestRowsCompanion(
          status: Value(TRStatusDto.success),
        ),
      TxWaitFailure() => const TransactionRequestRowsCompanion(
          status: Value(TRStatusDto.failure),
        ),
      TxWaitNetworkError() => null,
    };
  }
}

extension TransactionRequestRowExt on TransactionRequestRow {
  TransactionRequestPayment toModel() => TransactionRequestPayment(
        id: id,
        created: created,
        status: toStatusModel,
        amount: CryptoAmount(
          value: amount,
          cryptoCurrency: const CryptoCurrency(token: Token.usdc),
        ),
        label: label,
        txId: SignedTx.decode(transaction).id,
      );

  TRStatus get toStatusModel => switch (status) {
        TRStatusDto.created => TRStatus.created,
        TRStatusDto.sent => TRStatus.sent,
        TRStatusDto.success => TRStatus.success,
        TRStatusDto.failure => TRStatus.failure,
      };
}
