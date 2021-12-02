import 'package:json_annotation/json_annotation.dart';

part 'data_slice.g.dart';

/// Data slice to limit the account data in a response
@JsonSerializable(includeIfNull: false)
class DataSlice {
  const DataSlice({
    this.offset,
    this.length,
  });

  factory DataSlice.fromJson(Map<String, dynamic> json) =>
      _$DataSliceFromJson(json);

  Map<String, dynamic> toJson() => _$DataSliceToJson(this);

  /// Start index for the data slice
  final int? offset;

  /// Length of the data slice
  final int? length;
}
