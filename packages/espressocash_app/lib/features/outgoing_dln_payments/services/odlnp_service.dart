import 'package:injectable/injectable.dart';
import 'package:solana/encoder.dart';
import 'package:uuid/uuid.dart';

import '../../../core/amount.dart';
import '../../accounts/models/ec_wallet.dart';
import '../../transactions/models/tx_results.dart';
import '../../transactions/services/resign_tx.dart';
import '../data/repository.dart';
import '../models/outgoing_payment.dart';
import '../models/payment_quote.dart';

@injectable
class OutgoingDlnPaymentService {
  const OutgoingDlnPaymentService(this._repository);

  final OutgoingDlnPaymentRepository _repository;

  Future<OutgoingDlnPayment> create({
    required PaymentQuote quote,
    required ECWallet account,
  }) async {
    final status = await _createTx(quote: quote, account: account);
    final totalAmount = (quote.payment.inputAmount + quote.fee) as CryptoAmount;

    final id = const Uuid().v4();
    final payment = OutgoingDlnPayment(
      id: id,
      created: DateTime.now(),
      status: status,
      payment: quote.payment,
      amount: totalAmount,
    );

    await _repository.save(payment);

    return payment;
  }

  Future<OutgoingDlnPaymentStatus> _createTx({
    required PaymentQuote quote,
    required ECWallet account,
  }) async {
    try {
      return OutgoingDlnPaymentStatus.txCreated(
        await SignedTx.decode(quote.encodedTx).resign(account),
        slot: quote.slot,
      );
    } on Exception {
      return const OutgoingDlnPaymentStatus.txFailure(
        reason: TxFailureReason.creatingFailure,
      );
    }
  }
}
