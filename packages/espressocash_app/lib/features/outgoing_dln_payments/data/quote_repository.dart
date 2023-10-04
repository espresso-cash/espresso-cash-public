import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/amount.dart';
import '../../../../core/currency.dart';
import '../../../core/blockchain.dart';
import '../models/dln_payment.dart';
import '../models/payment_quote.dart';

@injectable
class QuoteRepository {
  QuoteRepository({
    required CryptopleaseClient cryptopleaseClient,
  }) : _cpClient = cryptopleaseClient;

  final CryptopleaseClient _cpClient;

  Future<PaymentQuote> getQuote({
    required CryptoAmount amount,
    required String receiverAddress,
    required Blockchain receiverBlockchain,
    required String userPublicKey,
  }) async {
    final quote = await _cpClient.getDlnQuote(
      PaymentQuoteRequestDto(
        amount: amount.value.toString(),
        senderAddress: userPublicKey,
        receiverAddress: receiverAddress,
        receiverBlockchain: receiverBlockchain.value,
      ),
    );

    return PaymentQuote(
      payment: DlnPayment(
        amount: amount,
        receiverAddress: receiverAddress,
        receiverBlockchain: receiverBlockchain,
      ),
      // outAmount: int.parse(quote.outAmount),
      outAmount: 1, //TODO
      fee: CryptoAmount(cryptoCurrency: Currency.usdc, value: quote.feeInUsdc),
      encodedTx: quote.encodedTx,
      slot: quote.slot,
    );
  }
}
