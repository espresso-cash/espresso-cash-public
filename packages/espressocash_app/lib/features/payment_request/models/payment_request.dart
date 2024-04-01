import 'package:espressocash_common/espressocash_common.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana_pay.dart';

import '../../../config.dart';
import '../../tokens/token_list.dart';

part 'payment_request.freezed.dart';

@freezed
class PaymentRequest with _$PaymentRequest {
  const factory PaymentRequest({
    required String id,
    required DateTime created,
    required SolanaPayRequest payRequest,
    required String dynamicLink,
    required PaymentRequestState state,
  }) = _PaymentRequest;
}

@freezed
class PaymentRequestState with _$PaymentRequestState {
  const factory PaymentRequestState.initial() = PaymentRequestInitial;
  const factory PaymentRequestState.completed({
    required String transactionId,
  }) = PaymentRequestCompleted;
  const factory PaymentRequestState.failure() = PaymentRequestFailure;
}

extension SolanaPayRequestExt on SolanaPayRequest {
  String toUniversalLink() {
    final queryParameters = <String, dynamic>{
      't': 's',
      'r': recipient.toBase58(),
      'a': amount?.toString(),
      'p': reference?.map((r) => r.toBase58()).toList(),
      'l': label,
    };

    return Uri(
      scheme: 'https',
      path: '/',
      host: espressoCashLinkDomain,
      queryParameters: queryParameters,
    ).toString().replaceAll('+', '%20');
  }

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
      cryptoCurrency: currency,
      value: currency.decimalToInt(amount),
    );
  }
}
