import 'package:freezed_annotation/freezed_annotation.dart';

part 'dto.freezed.dart';
part 'dto.g.dart';

@freezed
class GetPriorityFeeEstimateRequest with _$GetPriorityFeeEstimateRequest {
  const factory GetPriorityFeeEstimateRequest({
    String? transaction,
    List<String>? accountKeys,
    GetPriorityFeeEstimateOptions? options,
  }) = _GetPriorityFeeEstimateRequest;

  factory GetPriorityFeeEstimateRequest.fromJson(Map<String, dynamic> json) =>
      _$GetPriorityFeeEstimateRequestFromJson(json);
}

@freezed
class GetPriorityFeeEstimateOptions with _$GetPriorityFeeEstimateOptions {
  const factory GetPriorityFeeEstimateOptions({
    @Default(PriorityLevel.medium) PriorityLevel? priorityLevel,
    bool? includeAllPriorityFeeLevels,
    @Default(TransactionEncoding.base58)
    TransactionEncoding? transactionEncoding,
    int? lookbackSlots,
  }) = _GetPriorityFeeEstimateOptions;

  factory GetPriorityFeeEstimateOptions.fromJson(Map<String, dynamic> json) =>
      _$GetPriorityFeeEstimateOptionsFromJson(json);
}

@freezed
class GetPriorityFeeEstimateResponse with _$GetPriorityFeeEstimateResponse {
  const factory GetPriorityFeeEstimateResponse({
    MicroLamportPriorityFeeLevels? priorityFeeLevels,
  }) = _GetPriorityFeeEstimateResponse;

  factory GetPriorityFeeEstimateResponse.fromJson(Map<String, dynamic> json) =>
      _$GetPriorityFeeEstimateResponseFromJson(json);
}

@freezed
class MicroLamportPriorityFeeLevels with _$MicroLamportPriorityFeeLevels {
  const factory MicroLamportPriorityFeeLevels({
    double? none,
    double? low,
    double? medium,
    double? high,
    double? veryHigh,
    double? unsafeMax,
  }) = _MicroLamportPriorityFeeLevels;

  factory MicroLamportPriorityFeeLevels.fromJson(Map<String, dynamic> json) =>
      _$MicroLamportPriorityFeeLevelsFromJson(json);
}

@JsonEnum(fieldRename: FieldRename.pascal)
enum PriorityLevel {
  none,
  low,
  medium,
  high,
  veryHigh,
  unsafeMax,
  defaultLevel,
}

enum TransactionEncoding {
  binary,
  base64,
  base58,
  json,
  jsonParsed,
}
