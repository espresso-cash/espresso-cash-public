import 'package:ec_client_dart/ec_client_dart.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/solana.dart';

import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../models/fee_type.dart';

@injectable
class FeeCalculator {
  const FeeCalculator(this._ecClient);

  final EspressoCashClient _ecClient;

  Future<CryptoAmount> call(FeeType type) {
    final fee = switch (type) {
      FeeTypeDirect(:final address) => _getDirectPaymentFee(address),
      FeeTypeLink() => _getLinkPaymentFee(),
      FeeTypeWithdraw(:final address) => _getWithdrawFee(address),
    };

    return fee.then((value) => CryptoAmount(value: value, cryptoCurrency: Currency.usdc));
  }

  Future<int> _getDirectPaymentFee(Ed25519HDPublicKey address) => _ecClient
      .getDirectPaymentQuote(
        DirectPaymentQuoteRequestDto(receiverAccount: address.toBase58(), amount: 0),
      )
      .then((quote) => quote.fee);

  Future<int> _getLinkPaymentFee() =>
      _ecClient.getOutgoingEscrowPaymentQuote().then((quote) => quote.fee);

  Future<int> _getWithdrawFee(Ed25519HDPublicKey? address) =>
      address == null ? Future.value(0) : _getDirectPaymentFee(address);
}
