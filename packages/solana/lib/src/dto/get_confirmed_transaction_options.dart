import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/dto/commitment.dart';
import 'package:solana/src/dto/encoding.dart';

part 'get_confirmed_transaction_options.g.dart';

/// Configuration object for
/// [RPCClient.getConfirmedTransaction()]
@JsonSerializable(createFactory: true, includeIfNull: false)
class GetConfirmedTransactionOptions {
  const GetConfirmedTransactionOptions({
    this.encoding,
    this.commitment,
  });

  factory GetConfirmedTransactionOptions.fromJson(Map<String, dynamic> json) =>
      _$GetConfirmedTransactionOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$GetConfirmedTransactionOptionsToJson(this);

  /// This value is fixed because parsing occurs internally in
  /// the library
  final Encoding? encoding;

  final Commitment? commitment;
}
