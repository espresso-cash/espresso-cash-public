import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc_client/meta.dart';
import 'package:solana/src/rpc_client/transaction.dart';

part 'transaction_response.g.dart';

/// Response of the [`getTransaction`][get transaction] rpc method.
///
/// [get transaction]: https://docs.solana.com/developing/clients/jsonrpc-api#gettransaction
@JsonSerializable(createToJson: false)
class TransactionResponse {
  TransactionResponse({
    this.meta,
    required this.slot,
    required this.blockTime,
    required this.transaction,
  });

  factory TransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$TransactionResponseFromJson(json);

  final Meta? meta;
  final int slot;
  final int blockTime;
  final Transaction transaction;
}
