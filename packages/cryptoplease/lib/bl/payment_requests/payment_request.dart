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
        host: 'solana.cryptoplease.link',
      );
}
