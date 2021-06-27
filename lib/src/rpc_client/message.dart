part of 'rpc_client.dart';

/// A message as it's returned within a [Transaction] when
/// calling the `getTransaction` RPC method.
@JsonSerializable(createToJson: false)
class TxMessage {
  TxMessage({
    this.header,
    required this.accountKeys,
    required this.recentBlockhash,
    required this.instructions,
  });

  factory TxMessage.fromJson(Map<String, dynamic> json) =>
      _$TxMessageFromJson(json);

  final List<AccountKey> accountKeys;
  final TxMessageHeader? header;
  final String recentBlockhash;
  final List<ParsedInstruction> instructions;
}
