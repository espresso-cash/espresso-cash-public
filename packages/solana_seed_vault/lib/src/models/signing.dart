import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'signing.freezed.dart';

@freezed
class SigningRequest with _$SigningRequest {
  const factory SigningRequest({
    required Uint8List payload,
    required List<Uri> requestedSignatures,
  }) = _SigningRequest;
}

@freezed
class SigningResponse with _$SigningResponse {
  const factory SigningResponse({
    required List<Uint8List> signatures,
    required List<Uri> resolvedDerivationPaths,
  }) = _SigningResponse;
}
