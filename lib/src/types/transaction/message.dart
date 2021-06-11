import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/types/transaction/account_key.dart';
import 'package:solana/src/types/transaction/instruction.dart';
import 'package:solana/src/types/transaction/message_header.dart';

part 'message.g.dart';

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
  final List<TxInstruction> instructions;
}
