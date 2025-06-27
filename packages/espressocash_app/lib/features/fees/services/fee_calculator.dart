import 'package:ec_client_dart/ec_client_dart.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/solana.dart';

import '../../../config.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../tokens/token.dart';
import '../models/fee_type.dart';

@injectable
class FeeCalculator {
  const FeeCalculator(this._ecClient);

  final EspressoCashClient _ecClient;

  Future<CryptoAmount> call(FeeType type) => switch (type) {
    FeeTypeDirect(:final address, :final token) => _getDirectPaymentFee(
      address: address,
      token: token,
    ),
    FeeTypeLink() => _getLinkPaymentFee(),
    FeeTypeWithdraw(:final address) => _getWithdrawFee(address),
  };

  Future<CryptoAmount> _getDirectPaymentFee({
    required Ed25519HDPublicKey address,
    required Token token,
  }) =>
      token.isSolana
          ? Future.value(solTransferFee)
          : _ecClient
              .getDirectPaymentQuote(
                DirectPaymentQuoteRequestDto(
                  receiverAccount: address.toBase58(),
                  amount: 0,
                  mintAddress: token.address,
                ),
              )
              .then((quote) => CryptoAmount(value: quote.fee, cryptoCurrency: Currency.usdc));

  Future<CryptoAmount> _getLinkPaymentFee() => _ecClient.getOutgoingEscrowPaymentQuote().then(
    (quote) => CryptoAmount(value: quote.fee, cryptoCurrency: Currency.usdc),
  );

  Future<CryptoAmount> _getWithdrawFee(Ed25519HDPublicKey? address) =>
      address == null
          ? Future.value(const CryptoAmount(value: 0, cryptoCurrency: Currency.usdc))
          : _getDirectPaymentFee(address: address, token: Token.usdc);
}

const solTransferFee = CryptoAmount(value: 1 * lamportsPerSignature, cryptoCurrency: Currency.sol);
