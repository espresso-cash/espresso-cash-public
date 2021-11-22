import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/dto/filter_params.dart';

part 'filter.g.dart';

/// A filter of program data
@JsonSerializable(createFactory: true, includeIfNull: false)
class Filter {
  const Filter({
    required this.memcmp,
    required this.dataSize,
  });

  factory Filter.fromJson(Map<String, dynamic> json) => _$FilterFromJson(json);

  Map<String, dynamic> toJson() => _$FilterToJson(this);

  /// Compares a provided series of bytes with program account
  /// data at a particular offset.
  final FilterParams memcmp;

  /// Compares the program account data length with the provided
  /// data size.
  final int dataSize;
}
