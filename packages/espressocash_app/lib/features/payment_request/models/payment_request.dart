import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana_pay.dart';

import '../../../config.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../tokens/token.dart';

part 'payment_request.freezed.dart';

enum PaymentRequestState { initial, completed, error }

@freezed
class PaymentRequest with _$PaymentRequest {
  const factory PaymentRequest({
    required String id,
    required DateTime created,
    required SolanaPayRequest payRequest,
    required String dynamicLink,
    required String? shortLink,
    required PaymentRequestState state,
    required String? transactionId,
    required DateTime? resolvedAt,
  }) = _PaymentRequest;
}

extension SolanaPayRequestExt on SolanaPayRequest {
  Uri toUniversalLink() {
    final link = Uri.parse(toUrl());

    return link.replace(
      scheme: 'https',
      path: '/',
      host: espressoCashLinkDomain,
      queryParameters: {'t': 'espressopay', 'recipient': link.path, ...link.queryParameters},
    );
  }

  Future<CryptoAmount?> cryptoAmount(Future<Token?> Function(String address) getToken) async {
    final amount = this.amount;
    if (amount == null) return null;

    final splToken = this.splToken;
    final token = splToken == null ? Token.sol : await getToken(splToken.toBase58());

    if (token == null) return null;

    final currency = CryptoCurrency(token: token);

    return CryptoAmount(cryptoCurrency: currency, value: currency.decimalToInt(amount));
  }

  String? get invoice => reference?.firstOrNull?.toBase58();
}
