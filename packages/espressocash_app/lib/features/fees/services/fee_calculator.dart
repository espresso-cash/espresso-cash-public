import 'package:ec_client_dart/ec_client_dart.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/solana.dart';

import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../tokens/token.dart';
import '../models/fee_type.dart';

@injectable
class FeeCalculator {
  const FeeCalculator(this._ecClient);

  final EspressoCashClient _ecClient;

  Future<CryptoAmount> call(FeeType type) {
    final fee = switch (type) {
      FeeTypeDirect(:final address, :final token) => _getDirectPaymentFee(
        address: address,
        token: token,
      ),
      FeeTypeLink() => _getLinkPaymentFee(),
      FeeTypeWithdraw(:final address) => _getWithdrawFee(address),
    };

    return fee.then((value) => CryptoAmount(value: value, cryptoCurrency: Currency.usdc));
  }

  Future<int> _getDirectPaymentFee({required Ed25519HDPublicKey address, required Token token}) =>
      token.isSolana
          ? Future.value(0)
          : _ecClient
              .getDirectPaymentQuote(
                DirectPaymentQuoteRequestDto(
                  receiverAccount: address.toBase58(),
                  amount: 0,
                  mintAddress: token.address,
                ),
              )
              .then((quote) => quote.fee);

  Future<int> _getLinkPaymentFee() =>
      _ecClient.getOutgoingEscrowPaymentQuote().then((quote) => quote.fee);

  Future<int> _getWithdrawFee(Ed25519HDPublicKey? address) =>
      address == null ? Future.value(0) : _getDirectPaymentFee(address: address, token: Token.usdc);
}
