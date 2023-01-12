import 'package:freezed_annotation/freezed_annotation.dart';

part 'implementation_limits.freezed.dart';

@freezed
class ImplementationLimits with _$ImplementationLimits {
  const factory ImplementationLimits({
    required int maxBip32PathDepth,
    required int maxSigningRequests,
    required int maxRequestedSignatures,
    required int maxRequestedPublicKeys,
  }) = _ImplementationLimits;
}
