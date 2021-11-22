import 'package:json_annotation/json_annotation.dart';

part 'filter_params.g.dart';

/// A parameters object for a filter of program data
@JsonSerializable(createFactory: true, includeIfNull: false)
class FilterParams {
  const FilterParams({
    required this.offset,
    required this.bytes,
  });

  factory FilterParams.fromJson(Map<String, dynamic> json) =>
      _$FilterParamsFromJson(json);

  Map<String, dynamic> toJson() => _$FilterParamsToJson(this);

  /// Offset into program account data to start comparison.
  final int offset;

  /// Data to match, as base-58 encoded string and limited to
  /// less than 129 bytes.
  final String bytes;
}
