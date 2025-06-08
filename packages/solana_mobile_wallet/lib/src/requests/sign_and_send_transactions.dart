import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_and_send_transactions.freezed.dart';

@freezed
sealed class SignAndSendTransactionsRequest with _$SignAndSendTransactionsRequest {
  const factory SignAndSendTransactionsRequest({
    required String? identityName,
    required Uri? identityUri,
    required Uri? iconRelativeUri,
    required String cluster,
    required Uint8List authorizationScope,
    required List<Uint8List> transactions,
    required int? minContextSlot,
  }) = _SignAndSendTransactionsRequest;
}

@freezed
sealed class SignaturesResult with _$SignaturesResult {
  const factory SignaturesResult({required List<Uint8List> signatures}) = SignaturesResultSigned;

  const factory SignaturesResult.requestDeclined() = SignaturesResultRequestDeclined;

  const factory SignaturesResult.invalidPayloads({required List<bool> valid}) =
      SignaturesResultInvalidPayloads;

  const factory SignaturesResult.tooManyPayloads() = SignaturesResultTooManyPayloads;

  const factory SignaturesResult.authorizationNotValid() = SignaturesResultAuthorizationNotValid;

  const factory SignaturesResult.notSubmitted({required List<Uint8List> signatures}) =
      SignaturesResultNotSubmitted;

  const SignaturesResult._();

  int get numResults => switch (this) {
    final SignaturesResultSigned it => it.signatures.length,
    _ => 0,
  };
}
