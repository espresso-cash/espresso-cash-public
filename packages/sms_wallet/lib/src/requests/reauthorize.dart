import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'reauthorize.freezed.dart';

@freezed
class ReauthorizeRequest with _$ReauthorizeRequest {
  const factory ReauthorizeRequest({
    required String? identityName,
    required Uri? identityUri,
    required Uri? iconRelativeUri,
    required String cluster,
    required Uint8List authorizationScope,
  }) = _ReauthorizeRequest;
}
