import 'package:cryptoplease/bl/amount.dart';
import 'package:cryptoplease/bl/currency.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/bl/tokens/token_list.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana_pay.dart';

part 'payment_request.freezed.dart';

@freezed
class PaymentRequest with _$PaymentRequest {
  const factory PaymentRequest({
    required String id,
    required DateTime created,
    required String payerName,
    required SolanaPayRequest payRequest,
    required String dynamicLink,
    required PaymentRequestState state,
  }) = _PaymentRequest;
}

enum PaymentRequestState { initial, completed, error }

extension SolanaPayRequestExt on SolanaPayRequest {
  Uri toUniversalLink() => Uri.parse(toUrl()).replace(
        scheme: 'https',
        host: 'sol.cryptoplease.link',
      );

  CryptoAmount? cryptoAmount(TokenList tokenList) {
    final amount = this.amount;
    if (amount == null) return null;

    final splToken = this.splToken;
    final token = splToken == null
        ? Token.sol
        : tokenList.findTokenByMint(splToken.toBase58());

    if (token == null) return null;

    final currency = CryptoCurrency(token: token);

    return CryptoAmount(
      currency: currency,
      value: currency.decimalToInt(amount),
    );
  }
}
