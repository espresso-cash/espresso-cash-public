import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/solana.dart';
import 'package:solana/solana_pay.dart';

import '../../../data/db/db.dart';
import '../../../data/db/mixins.dart';
import '../../authenticated/auth_scope.dart';
import '../models/payment_request.dart';

@Singleton(scope: authScope)
class PaymentRequestRepository implements Disposable {
  const PaymentRequestRepository(this._db);

  final MyDatabase _db;

  Stream<PaymentRequest> watchById(String id) {
    final query = _db.select(_db.paymentRequestRows)
      ..where((p) => p.id.equals(id));

    return query.watchSingle().map((row) => row.toPaymentRequest());
  }

  Future<void> save(PaymentRequest payment) =>
      _db.into(_db.paymentRequestRows).insertOnConflictUpdate(payment.toRow());

  Future<void> delete(String id) =>
      (_db.delete(_db.paymentRequestRows)..where((tbl) => tbl.id.equals(id)))
          .go();

  Future<IList<PaymentRequest>> getAllPending() async {
    final query = _db.select(_db.paymentRequestRows)
      ..where((p) => p.state.equalsValue(PaymentRequestStateDto.initial));

    final rows = await query.get();

    return rows.map((row) => row.toPaymentRequest()).toIList();
  }

  @override
  Future<void> onDispose() => _db.delete(_db.paymentRequestRows).go();
}

enum PaymentRequestStateDto { initial, completed, error }

class PaymentRequestRows extends Table with EntityMixin {
  const PaymentRequestRows();

  TextColumn get dynamicLink => text()();
  IntColumn get state => intEnum<PaymentRequestStateDto>()();
  TextColumn get transactionId => text().nullable()();

  // SolanaPayRequest columns
  TextColumn get recipient => text()();
  TextColumn get amount => text().nullable()();
  TextColumn get spltToken => text().nullable()();
  TextColumn get reference => text().nullable()();
  TextColumn get message => text().nullable()();
  TextColumn get memo => text().nullable()();
}

extension on PaymentRequestRow {
  PaymentRequest toPaymentRequest() => PaymentRequest(
        id: id,
        created: created,
        payRequest: SolanaPayRequest(
          amount: amount?.let(Decimal.parse),
          recipient: Ed25519HDPublicKey.fromBase58(recipient),
          splToken: spltToken?.let(Ed25519HDPublicKey.fromBase58),
          reference: reference?.let(
            (it) => it.split(',').map(Ed25519HDPublicKey.fromBase58).toIList(),
          ),
          message: message,
          memo: memo,
        ),
        dynamicLink: dynamicLink,
        state: state.toPaymentRequestState(transactionId),
      );
}

extension on PaymentRequest {
  PaymentRequestRow toRow() => PaymentRequestRow(
        id: id,
        created: created,
        dynamicLink: dynamicLink,
        state: state.toPaymentRequestStateDto(),
        transactionId: state.transactionIdOrNull,
        recipient: payRequest.recipient.toBase58(),
        amount: payRequest.amount?.toString(),
        memo: payRequest.memo,
        message: payRequest.message,
        reference: payRequest.reference?.map((it) => it.toBase58()).join(','),
        spltToken: payRequest.splToken?.toBase58(),
      );
}

extension on PaymentRequestStateDto {
  PaymentRequestState toPaymentRequestState(String? transactionId) {
    switch (this) {
      case PaymentRequestStateDto.initial:
        return const PaymentRequestState.initial();
      case PaymentRequestStateDto.completed:
        return PaymentRequestState.completed(
          transactionId: transactionId ?? '',
        );
      case PaymentRequestStateDto.error:
        return const PaymentRequestState.failure();
    }
  }
}

extension on PaymentRequestState {
  PaymentRequestStateDto toPaymentRequestStateDto() => when(
        initial: always(PaymentRequestStateDto.initial),
        completed: always(PaymentRequestStateDto.completed),
        failure: always(PaymentRequestStateDto.error),
      );

  String? get transactionIdOrNull => maybeWhen(
        completed: identity,
        orElse: always(null),
      );
}
