import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/dto/commitment.dart';
import 'package:solana/src/dto/data_slice.dart';
import 'package:solana/src/dto/encoding.dart';

part 'get_account_info_options.g.dart';

/// Configuration object for getting account information
@JsonSerializable(createFactory: true, includeIfNull: false)
class GetAccountInfoOptions {
  const GetAccountInfoOptions({
    this.commitment,
    this.encoding,
    this.dataSlice,
  });

  factory GetAccountInfoOptions.fromJson(Map<String, dynamic> json) =>
      _$GetAccountInfoOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$GetAccountInfoOptionsToJson(this);

  final Commitment? commitment;

  final Encoding? encoding;

  /// Limit the returned account data using the provided offset:
  /// <usize> and length: <usize> fields; only available for
  /// "base58""base64" or "base64+zstd" encodings.
  final DataSlice? dataSlice;
}
