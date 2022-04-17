import 'package:cryptoplease/bl/payment_requests/payment_request.dart';
import 'package:cryptoplease/bl/payment_requests/repository.dart';
import 'package:cryptoplease/data/db/db.dart';
import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:solana/solana.dart';
import 'package:solana/solana_pay.dart';

class DbPaymentRequestRepository implements PaymentRequestRepository {
  DbPaymentRequestRepository(this.db);

  final MyDatabase db;

  @override
  Stream<IList<Product2<String, DateTime>>> watchAllIds() {
    final query = db.selectOnly(db.paymentRequestRows)
      ..addColumns([db.paymentRequestRows.id, db.paymentRequestRows.created])
      ..orderBy([
        OrderingTerm(
          expression: db.paymentRequestRows.created,
          mode: OrderingMode.desc,
        ),
      ]);

    return query.watch().map(
          (rows) => rows
              .map(
                (row) => Product2(
                  row.read(db.paymentRequestRows.id)!,
                  row.read(db.paymentRequestRows.created)!,
                ),
              )
              .toIList(),
        );
  }

  @override
  Stream<PaymentRequest> watchById(String id) {
    final query = db.select(db.paymentRequestRows)
      ..where((p) => p.id.equals(id));

    return query.watchSingle().map((row) => row.toPaymentRequest());
  }

  @override
  Future<void> save(PaymentRequest payment) =>
      db.into(db.paymentRequestRows).insertOnConflictUpdate(payment.toRow());

  @override
  Future<void> clear() => db.delete(db.paymentRequestRows).go();
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
        state: state,
      );
}

extension on PaymentRequest {
  PaymentRequestRow toRow() => PaymentRequestRow(
        id: id,
        created: created,
        payerName: payerName,
        dynamicLink: dynamicLink,
        state: state,
        recipient: payRequest.recipient.toBase58(),
        amount: payRequest.amount?.toString(),
        label: payRequest.label,
        memo: payRequest.memo,
        message: payRequest.message,
        reference: payRequest.reference?.map((it) => it.toBase58()).join(','),
        spltToken: payRequest.splToken?.toBase58(),
      );
}
