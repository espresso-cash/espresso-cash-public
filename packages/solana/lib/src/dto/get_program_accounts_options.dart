import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/dto/commitment.dart';
import 'package:solana/src/dto/data_slice.dart';
import 'package:solana/src/dto/encoding.dart';
import 'package:solana/src/dto/filter.dart';

part 'get_program_accounts_options.g.dart';

/// Configuration object for [RPCClient.getProgramAccounts()]
@JsonSerializable(createFactory: true, includeIfNull: false)
class GetProgramAccountsOptions {
  const GetProgramAccountsOptions({
    this.commitment,
    this.encoding,
    this.dataSlice,
    this.filter,
  });

  factory GetProgramAccountsOptions.fromJson(Map<String, dynamic> json) =>
      _$GetProgramAccountsOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$GetProgramAccountsOptionsToJson(this);

  final Commitment? commitment;

  final Encoding? encoding;

  /// Limit the returned account data using the provided offset:
  /// <usize> and length: <usize> fields; only available for
  /// "base58""base64" or "base64+zstd" encodings.
  final DataSlice? dataSlice;

  /// Filter results using various filter objects; account must
  /// meet all filter criteria to be included in results
  final List<Filter>? filter;
}
