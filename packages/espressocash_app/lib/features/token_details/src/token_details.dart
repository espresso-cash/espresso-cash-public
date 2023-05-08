import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_details.freezed.dart';

@freezed
class TokenDetails with _$TokenDetails {
  const factory TokenDetails({
    required String name,
    IMap<String, String>? descriptions,
    double? marketPrice,
    int? marketCapRank,
  }) = _TokenDetails;
}
