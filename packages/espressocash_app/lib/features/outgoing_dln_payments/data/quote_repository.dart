import 'package:espressocash_api/espressocash_api.dart';
import 'package:espressocash_common/espressocash_common.dart';
import 'package:injectable/injectable.dart';

import '../../blockchain/models/blockchain.dart';
import '../models/dln_payment.dart';
import '../models/payment_quote.dart';

@injectable
class QuoteRepository {
  QuoteRepository({
    required EspressoCashClient ecClient,
  }) : _client = ecClient;

  final EspressoCashClient _client;

  Future<PaymentQuote> getQuote({
    required CryptoAmount amount,
    required String receiverAddress,
    required Blockchain receiverBlockchain,
  }) async {
    final quote = await _client.getDlnQuote(
      PaymentQuoteRequestDto(
        amount: amount.value,
        receiverAddress: receiverAddress,
        receiverBlockchain: receiverBlockchain.name,
      ),
    );

    return PaymentQuote(
      payment: DlnPayment(
        inputAmount: amount,
        receiverAddress: receiverAddress,
        receiverBlockchain: receiverBlockchain,
      ),
      receiverAmount: CryptoAmount(
        cryptoCurrency: Currency.usdc,
        value: quote.receiverAmount,
      ),
      inputAmount: CryptoAmount(
        cryptoCurrency: Currency.usdc,
        value: quote.inputAmount,
      ),
      fee: CryptoAmount(
        cryptoCurrency: Currency.usdc,
        value: quote.feeInUsdc,
      ),
      encodedTx: quote.encodedTx,
      slot: quote.slot,
    );
  }
}
