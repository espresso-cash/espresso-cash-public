import 'package:injectable/injectable.dart';
import 'package:solana/encoder.dart';
import 'package:uuid/uuid.dart';

import '../../accounts/models/ec_wallet.dart';
import '../../transactions/models/tx_sender.dart';
import '../../transactions/services/resign_tx.dart';
import '../data/quote_repository.dart';
import '../data/repository.dart';
import '../models/dln_payment.dart';
import '../models/outgoing_payment.dart';
import '../models/payment_quote.dart';

@injectable
class OutgoingDlnPaymentService {
  const OutgoingDlnPaymentService(this._repository, this._quoteRepository);

  final OutgoingDlnPaymentRepository _repository;
  final QuoteRepository _quoteRepository;

  Future<OutgoingDlnPayment> create({
    required PaymentQuote quote,
    required ECWallet account,
  }) async {
    final status = await _createTx(quote: quote, account: account);

    final id = const Uuid().v4();
    final payment = OutgoingDlnPayment(
      id: id,
      created: DateTime.now(),
      status: status,
      payment: quote.payment,
    );

    await _repository.save(payment);

    return payment;
  }

  Future<OutgoingDlnPayment> retry(
    OutgoingDlnPayment payment, {
    required ECWallet account,
  }) async {
    final status =
        await _reCreateTx(payment: payment.payment, account: account);

    final newOrder = payment.copyWith(status: status);

    await _repository.save(newOrder);

    return newOrder;
  }

  Future<OutgoingDlnPaymentStatus> _reCreateTx({
    required DlnPayment payment,
    required ECWallet account,
  }) async {
    try {
      final quote = await _quoteRepository.getQuote(
        amount: payment.inputAmount,
        receiverAddress: payment.receiverAddress,
        receiverBlockchain: payment.receiverBlockchain,
        userPublicKey: account.address,
      );

      return await _createTx(quote: quote, account: account);
    } on Exception {
      return const OutgoingDlnPaymentStatus.txFailure(
        reason: TxFailureReason.creatingFailure,
      );
    }
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
