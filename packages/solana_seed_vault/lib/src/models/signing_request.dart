import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'signing_request.freezed.dart';

@freezed
class SigningRequest with _$SigningRequest {
  const factory SigningRequest({
    required Uint8List payload,
    required List<Uri> requestedSignatures,
  }) = _SigningRequest;
}
