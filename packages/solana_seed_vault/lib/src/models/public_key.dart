import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'public_key.freezed.dart';

@freezed
class PublicKeyResponse with _$PublicKeyResponse {
  const factory PublicKeyResponse({
    required Uint8List? publicKey,
    required String? publicKeyEncoded,
    required Uri resolvedDerivationPath,
  }) = _PublicKeyResponse;
}
