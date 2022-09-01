import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_transactions.freezed.dart';

@freezed
class SignPayloadsRequest with _$SignPayloadsRequest {
  const factory SignPayloadsRequest.transactions({
    required String? identityName,
    required Uri? identityUri,
    required Uri? iconRelativeUri,
    required String cluster,
    required Uint8List authorizationScope,
    required List<Uint8List> payloads,
  }) = SignTransactionsRequest;

  const factory SignPayloadsRequest.messages({
    required String? identityName,
    required Uri? identityUri,
    required Uri? iconRelativeUri,
    required String cluster,
    required Uint8List authorizationScope,
    required List<Uint8List> payloads,
  }) = SignMessagesRequest;
}

@freezed
class SignedPayloadResult with _$SignedPayloadResult {
  const factory SignedPayloadResult({
    required List<Uint8List> signedPayloads,
  }) = _SignedPayloadResult;

  const factory SignedPayloadResult.requestDeclined() = _RequestDeclined;

  const factory SignedPayloadResult.invalidPayloads({
    required List<bool> valid,
  }) = _InvalidPayloads;

  const factory SignedPayloadResult.tooManyPayloads() = _TooManyPayloads;

  const factory SignedPayloadResult.authorizationNotValid() =
      _AuthorizationNotValid;

  const SignedPayloadResult._();

  int get numResults => maybeWhen(
        (signedPayloads) => signedPayloads.length,
        orElse: () => 0,
      );
}
