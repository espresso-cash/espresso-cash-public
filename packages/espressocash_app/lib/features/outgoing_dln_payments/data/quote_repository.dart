import 'package:injectable/injectable.dart';

import '../../tokens/token.dart';
import '../client/client.dart';
import '../models/quote_info.dart';

@injectable
class QuoteRepository {
  const QuoteRepository({
    required DlnApiClient dlnApiClient,
  }) : _dlnApiClient = dlnApiClient;
  final DlnApiClient _dlnApiClient;

  Future<QuoteInfo> getQuoteAndTransaction({
    required int amount,
    required String receiverAddress,
    required String senderAddress,
    required DlnChains receiverChain,
  }) async {
    final response = await _dlnApiClient.createTx(
      CreateTxRequestDto(
        srcChainId: DlnChains.solana.chainId,
        srcChainTokenIn: Token.usdc.publicKey.toBase58(),
        srcChainTokenInAmount: 'auto',
        dstChainId: receiverChain.chainId,
        dstChainTokenOut: receiverChain.usdcAddress,
        dstChainTokenOutAmount: amount.toString(),
        dstChainTokenOutRecipient: receiverAddress,
        srcChainOrderAuthorityAddress: senderAddress,
        dstChainOrderAuthorityAddress: receiverAddress,
        referralCode: espressoDlnRefCode,
      ),
    );

    final tx = response.tx.data;
    final estimation = response.estimation;

    final totalFees = int.parse(estimation.srcChainTokenIn.amount) - amount;

    return QuoteInfo(
      tx: tx,
      inputAmount: amount,
      senderDeductAmount: int.parse(estimation.srcChainTokenIn.amount),
      receiverAmount: int.parse(estimation.dstChainTokenOut.recommendedAmount),
      totalFees: totalFees,
    );
  }
}

const espressoDlnRefCode = 8435;
