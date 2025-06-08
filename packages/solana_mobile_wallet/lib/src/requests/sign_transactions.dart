import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_transactions.freezed.dart';

@freezed
sealed class SignPayloadsRequest with _$SignPayloadsRequest {
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
sealed class SignedPayloadResult with _$SignedPayloadResult {
  const factory SignedPayloadResult({required List<Uint8List> signedPayloads}) =
      SignedPayloadResultSigned;

  const factory SignedPayloadResult.requestDeclined() = SignedPayloadResultRequestDeclined;

  const factory SignedPayloadResult.invalidPayloads({required List<bool> valid}) =
      SignedPayloadResultInvalidPayloads;

  const factory SignedPayloadResult.tooManyPayloads() = SignedPayloadResultTooManyPayloads;

  const factory SignedPayloadResult.authorizationNotValid() =
      SignedPayloadResultAuthorizationNotValid;

  const SignedPayloadResult._();

  int get numResults => switch (this) {
    final SignedPayloadResultSigned it => it.signedPayloads.length,
    _ => 0,
  };
}
