import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana.dart';

import '../../../../core/amount.dart';

part 'odp_request.freezed.dart';

@freezed
class ODPRequest with _$ODPRequest {
  const factory ODPRequest({
    required String id,
    required Ed25519HDPublicKey receiver,
    required CryptoAmount amount,
    required DateTime created,
    required Ed25519HDPublicKey? reference,
    required String? label,
  }) = _ODPRequest;
}
