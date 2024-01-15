import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/dto/instruction.dart';
import 'package:solana/src/rpc/dto/transaction_message_header.dart';

part 'transaction_message.g.dart';

/// A transaction message
@JsonSerializable()
class TransactionMessage {
  const TransactionMessage({
    required this.accountKeys,
    required this.header,
    required this.recentBlockhash,
    required this.instructions,
  });

  factory TransactionMessage.fromJson(Map<String, dynamic> json) =>
      _$TransactionMessageFromJson(json);

  /// List of base-58 encoded public keys used by the
  /// transaction, including by the instructions and for
  /// signatures. The first message.header.numRequiredSignatures
  /// public keys must sign the transaction.
  final List<String> accountKeys;

  /// Details the account types and signatures required by the
  /// transaction.
  final TransactionMessageHeader header;

  /// A base-58 encoded hash of a recent block in the ledger used
  /// to prevent transaction duplication and to give transactions
  /// lifetimes.
  final String recentBlockhash;

  /// List of program instructions that will be executed in
  /// sequence and committed in one atomic transaction if all
  /// succeed.
  final List<Instruction> instructions;

  Map<String, dynamic> toJson() => _$TransactionMessageToJson(this);
}
