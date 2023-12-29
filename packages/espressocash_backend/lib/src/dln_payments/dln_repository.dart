import 'package:espressocash_api/espressocash_api.dart';
import 'package:espressocash_backend/src/constants.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dln_repository.freezed.dart';

@freezed
class QuoteInfo with _$QuoteInfo {
  const factory QuoteInfo({
    required String tx,
    required String inputAmount,
    required String senderDeductAmount,
    required String receiverAmount,
    required num totalFees,
  }) = _RouteInfo;
}

class DlnRepository {
  final _client = DlnApiClient();

  Future<QuoteInfo> getQuoteAndTransaction({
    required String amount,
    required String receiverAddress,
    required String senderAddress,
    required DlnChains receiverChain,
    required String platformFeeAddress,
  }) async {
    final quote = await _client.getQuote(
      DlnQuoteRequestDto(
        srcChainId: DlnChains.solana.chainId,
        srcChainTokenIn: mainnetUsdc.toBase58(),
        srcChainTokenInAmount: amount,
        dstChainId: receiverChain.chainId,
        dstChainTokenOut: receiverChain.usdcAddress,
        prependOperatingExpenses: true,
        affiliateFeePercent: _affiliateFeePercent,
      ),
    );

    final estimation = quote.estimation;

    final tx = await _client
        .createTx(
          CreateTxRequestDto(
            srcChainId: DlnChains.solana.chainId,
            srcChainTokenIn: mainnetUsdc.toBase58(),
            srcChainTokenInAmount: estimation.srcChainTokenIn.amount,
            dstChainId: receiverChain.chainId,
            dstChainTokenOut: receiverChain.usdcAddress,
            dstChainTokenOutAmount:
                estimation.dstChainTokenOut.recommendedAmount,
            dstChainTokenOutRecipient: receiverAddress,
            srcChainOrderAuthorityAddress: senderAddress,
            dstChainOrderAuthorityAddress: receiverAddress,
            affiliateFeePercent: _affiliateFeePercent,
            affiliateFeeRecipient: platformFeeAddress,
          ),
        )
        .then((resp) => resp.tx.data);

    final totalFees =
        int.parse(estimation.srcChainTokenIn.amount) - int.parse(amount);

    return QuoteInfo(
      tx: tx,
      inputAmount: amount,
      senderDeductAmount: estimation.srcChainTokenIn.amount,
      receiverAmount: estimation.dstChainTokenOut.recommendedAmount,
      totalFees: totalFees,
    );
  }
}

const _affiliateFeePercent = 1.0;

extension DlnChainsExt on DlnChains {
  String get usdcAddress => switch (this) {
        DlnChains.arbitrum => '0xaf88d065e77c8cC2239327C5EDb3A432268e5831',
        DlnChains.avalanche => '0xB97EF9Ef8734C71904D8002F8b6Bc66Dd9c48a6E',
        DlnChains.bnb => '0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d',
        DlnChains.ethereum => '0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48',
        DlnChains.polygon => '0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174',
        DlnChains.solana => 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v',
        DlnChains.linea => '0x176211869ca2b568f2a7d4ee941e073a821ee1ff',
        DlnChains.base => '0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913',
        DlnChains.optimism => '0x0b2C639c533813f4Aa9D7837CAf62653d097Ff85',
      };
}
