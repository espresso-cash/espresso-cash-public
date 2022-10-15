import 'package:cryptoplease/data/db/db.dart';
import 'package:cryptoplease/features/payment_request/bl/payment_request.dart';
import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/solana.dart';
import 'package:solana/solana_pay.dart';

@injectable
class PaymentRequestRepository {
  PaymentRequestRepository(this._db);

  final MyDatabase _db;

  Stream<IList<Product2<String, DateTime>>> watchAllIds() {
    final query = _db.selectOnly(_db.paymentRequestRows)
      ..addColumns([_db.paymentRequestRows.id, _db.paymentRequestRows.created])
      ..orderBy([
        OrderingTerm(
          expression: _db.paymentRequestRows.created,
          mode: OrderingMode.desc,
        ),
      ]);

    return query.watch().map(
          (rows) => rows
              .map(
                (row) => Product2(
                  // ignore: avoid-non-null-assertion, cannot be null here
                  row.read(_db.paymentRequestRows.id)!,
                  // ignore: avoid-non-null-assertion, cannot be null here
                  row.read(_db.paymentRequestRows.created)!,
                ),
              )
              .toIList(),
        );
  }

  Stream<PaymentRequest> watchById(String id) {
    final query = _db.select(_db.paymentRequestRows)
      ..where((p) => p.id.equals(id));

    return query.watchSingle().map((row) => row.toPaymentRequest());
  }

  Future<void> save(PaymentRequest payment) =>
      _db.into(_db.paymentRequestRows).insertOnConflictUpdate(payment.toRow());

  Future<void> clear() => _db.delete(_db.paymentRequestRows).go();
}

extension on PaymentRequestRow {
  PaymentRequest toPaymentRequest() => PaymentRequest(
        id: id,
        created: created,
        payerName: payerName,
        payRequest: SolanaPayRequest(
          amount: amount?.let(Decimal.parse),
          recipient: Ed25519HDPublicKey.fromBase58(recipient),
          splToken: spltToken?.let(Ed25519HDPublicKey.fromBase58),
          reference: reference?.let(
            (it) => it.split(',').map(Ed25519HDPublicKey.fromBase58).toIList(),
          ),
          label: label,
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
        payerName: payerName,
        dynamicLink: dynamicLink,
        state: state.toPaymentRequestStateDto(),
        transactionId: state.transactionIdOrNull,
        recipient: payRequest.recipient.toBase58(),
        amount: payRequest.amount?.toString(),
        label: payRequest.label,
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
