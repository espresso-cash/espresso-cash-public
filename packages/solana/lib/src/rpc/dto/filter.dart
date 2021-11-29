import 'package:json_annotation/json_annotation.dart';

part 'filter.g.dart';

abstract class Filter {
  const Filter();

  factory Filter.dataSize(int dataSize) => DataSizeFilter(dataSize);

  factory Filter.memcmp({required int offset, required String bytes}) =>
      MemcmpFilter.of(offset: offset, bytes: bytes);

  Map<String, dynamic> toJson();
}

/// Compares the program account data length with the provided
/// data size.
@JsonSerializable(createFactory: true, includeIfNull: false)
class DataSizeFilter extends Filter {
  final int dataSize;

  const DataSizeFilter(this.dataSize);

  factory DataSizeFilter.fromJson(Map<String, dynamic> json) =>
      _$DataSizeFilterFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DataSizeFilterToJson(this);
}

/// Compares the program account data length with the provided
/// data size.
@JsonSerializable(
    createFactory: true, includeIfNull: false, explicitToJson: true)
class MemcmpFilter extends Filter {
  final MemcmpFilterValue memcmp;

  const MemcmpFilter(this.memcmp);

  factory MemcmpFilter.fromJson(Map<String, dynamic> json) =>
      _$MemcmpFilterFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MemcmpFilterToJson(this);

  MemcmpFilter.of({
    required int offset,
    required String bytes,
  }) : this(MemcmpFilterValue(offset: offset, bytes: bytes));
}

@JsonSerializable(createFactory: true, includeIfNull: false)
class MemcmpFilterValue {
  const MemcmpFilterValue({
    required this.offset,
    required this.bytes,
  });

  factory MemcmpFilterValue.fromJson(Map<String, dynamic> json) =>
      _$MemcmpFilterValueFromJson(json);

  Map<String, dynamic> toJson() => _$MemcmpFilterValueToJson(this);

  /// Offset into program account data to start comparison.
  final int offset;

  /// Data to match, as base-58 encoded string and limited to
  /// less than 129 bytes.
  final String bytes;
}
