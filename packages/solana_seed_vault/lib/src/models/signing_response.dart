import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'signing_response.freezed.dart';

@freezed
class SigningResponse with _$SigningResponse {
  const factory SigningResponse({
    required List<Uint8List> signatures,
    required List<Uri> resolvedDerivationPaths,
  }) = _SigningResponse;
}
