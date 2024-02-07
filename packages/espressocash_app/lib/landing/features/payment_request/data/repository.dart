import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/amount.dart';
import '../../../../core/currency.dart';
import '../../../../features/blockchain/models/blockchain.dart';
import '../../../di.dart';
import '../models/incoming_quote.dart';

@LazySingleton(scope: landingScope)
class IncomingQuoteRepository {
  IncomingQuoteRepository({
    required CryptopleaseClient cryptopleaseClient,
  }) : _client = cryptopleaseClient;

  final CryptopleaseClient _client;

  Future<IncomingPaymentQuote> getQuote({
    required CryptoAmount amount,
    required String receiverAddress,
    required Blockchain senderBlockchain,
    required String senderAddress,
    required String? solanaReferenceAddress,
  }) async {
    final quote = await _client.getIncomingDlnQuote(
      IncomingQuoteRequestDto(
        amount: amount.value,
        senderAddress: senderAddress,
        senderBlockchain: senderBlockchain.name,
        receiverAddress: receiverAddress,
        solanaReferenceAddress: solanaReferenceAddress,
      ),
    );

    return IncomingPaymentQuote(
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
      to: quote.to,
      data: quote.data,
      value: quote.value,
    );
  }
}
