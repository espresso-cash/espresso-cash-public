import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'authorize.freezed.dart';

@freezed
class AuthorizeRequest with _$AuthorizeRequest {
  const factory AuthorizeRequest({
    required String? identityName,
    required Uri? identityUri,
    required Uri? iconUri,
  }) = _AuthorizeRequest;
}

@freezed
class AuthorizeResult with _$AuthorizeResult {
  const factory AuthorizeResult({
    required Uint8List publicKey,
    String? accountLabel,
    Uri? walletUriBase,
    Uint8List? scope,
  }) = _AuthorizeResult;
}
