import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_and_send_transactions.freezed.dart';

@freezed
class SignAndSendTransactionsRequest with _$SignAndSendTransactionsRequest {
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
class SignaturesResult with _$SignaturesResult {
  const factory SignaturesResult({
    required List<Uint8List> signatures,
  }) = _SignaturesResult;

  const factory SignaturesResult.requestDeclined() = _RequestDeclined;

  const factory SignaturesResult.invalidPayloads({
    required List<bool> valid,
  }) = _InvalidPayloads;

  const factory SignaturesResult.tooManyPayloads() = _TooManyPayloads;

  const factory SignaturesResult.authorizationNotValid() =
      _AuthorizationNotValid;

  const factory SignaturesResult.notSubmitted({
    required List<Uint8List> signatures,
  }) = _NotSubmitted;

  const SignaturesResult._();

  int get numResults => maybeWhen(
        (signatures) => signatures.length,
        orElse: () => 0,
      );
}
