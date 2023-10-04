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
  const OutgoingDlnPaymentService(this._repository, this._routeRepository);

  final OutgoingDlnPaymentRepository _repository;
  final QuoteRepository _routeRepository;

  Future<OutgoingDlnPayment> create({
    required PaymentQuote route,
    required ECWallet account,
  }) async {
    final status = await _createTx(route: route, account: account);

    final id = const Uuid().v4();
    final payment = OutgoingDlnPayment(
      id: id,
      created: DateTime.now(),
      status: status,
      payment: route.payment,
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
      final route = await _routeRepository.getQuote(
        amount: payment.amount,
        receiverAddress: payment.receiverAddress,
        receiverBlockchain: payment.receiverBlockchain,
        userPublicKey: account.address,
      );

      return await _createTx(route: route, account: account);
    } on Exception {
      return const OutgoingDlnPaymentStatus.txFailure(
        reason: TxFailureReason.creatingFailure,
      );
    }
  }

  Future<OutgoingDlnPaymentStatus> _createTx({
    required PaymentQuote route,
    required ECWallet account,
  }) async {
    try {
      return OutgoingDlnPaymentStatus.txCreated(
        await SignedTx.decode(route.encodedTx).resign(account),
        slot: route.slot,
      );
    } on Exception {
      return const OutgoingDlnPaymentStatus.txFailure(
        reason: TxFailureReason.creatingFailure,
      );
    }
  }
}
