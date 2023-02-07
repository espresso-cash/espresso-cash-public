import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_details.freezed.dart';

@freezed
class TokenDetails with _$TokenDetails {
  const factory TokenDetails({
    required String name,
    required String description,
    double? marketPrice,
    int? marketCapRank,
  }) = _TokenDetails;
}
