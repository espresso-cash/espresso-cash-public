import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/dto/commitment.dart';
import 'package:solana/src/dto/encoding.dart';

part 'get_transaction_options.g.dart';

/// Configuration object for [RPCClient.getVoteAccounts()]
@JsonSerializable(createFactory: true, includeIfNull: false)
class GetTransactionOptions {
  const GetTransactionOptions({
    this.encoding,
    this.commitment,
  });

  factory GetTransactionOptions.fromJson(Map<String, dynamic> json) =>
      _$GetTransactionOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$GetTransactionOptionsToJson(this);

  final Encoding? encoding;

  final Commitment? commitment;
}
