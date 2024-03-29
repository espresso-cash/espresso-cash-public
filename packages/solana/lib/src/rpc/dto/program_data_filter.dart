import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/base58/encode.dart';

part 'program_data_filter.g.dart';

abstract class ProgramDataFilter {
  factory ProgramDataFilter.memcmp({
    required int offset,
    required List<int> bytes,
  }) =>
      _MemcmpProgramDataFilter(
        memcmp: _Memcmp(
          offset: offset,
          bytes: base58encode(bytes),
        ),
      );

  factory ProgramDataFilter.memcmpBase58({
    required int offset,
    required String bytes,
  }) =>
      _MemcmpProgramDataFilter(
        memcmp: _Memcmp(
          offset: offset,
          bytes: bytes,
        ),
      );

  const factory ProgramDataFilter.dataSize(int dataSize) =
      _DataSizeProgramDataFilter;

  Map<String, dynamic> toJson();
}

@JsonSerializable(createFactory: false)
class _DataSizeProgramDataFilter implements ProgramDataFilter {
  const _DataSizeProgramDataFilter(this.dataSize);

  @override
  Map<String, dynamic> toJson() => _$DataSizeProgramDataFilterToJson(this);

  final int dataSize;
}

@JsonSerializable(createFactory: false)
class _MemcmpProgramDataFilter implements ProgramDataFilter {
  const _MemcmpProgramDataFilter({
    required this.memcmp,
  });

  @override
  Map<String, dynamic> toJson() => _$MemcmpProgramDataFilterToJson(this);

  final _Memcmp memcmp;
}

@JsonSerializable(createFactory: false)
class _Memcmp implements ProgramDataFilter {
  const _Memcmp({
    required this.offset,
    required this.bytes,
  });

  @override
  Map<String, dynamic> toJson() => _$MemcmpToJson(this);

  final int offset;
  final String bytes;
}
