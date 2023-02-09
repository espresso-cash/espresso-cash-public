import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/dto/inner_instruction.dart';
import 'package:solana/src/rpc/dto/loaded_addresses.dart';
import 'package:solana/src/rpc/dto/return_data.dart';
import 'package:solana/src/rpc/dto/reward.dart';
import 'package:solana/src/rpc/dto/token_balance.dart';

part 'meta.g.dart';

/// Transaction state metadata
@JsonSerializable(createToJson: false)
class Meta {
  const Meta({
    required this.err,
    required this.fee,
    required this.preBalances,
    required this.postBalances,
    required this.innerInstructions,
    required this.preTokenBalances,
    required this.postTokenBalances,
    required this.logMessages,
    required this.rewards,
    required this.loadedAddresses,
    required this.returnData,
    required this.computeUnitsConsumed,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

  final Map<String, dynamic>? err;

  /// Fee this transaction was charged, as u64 integer.
  final int fee;

  /// Array of u64 account balances from before the transaction
  /// was processed.
  final List<int> preBalances;

  /// Array of u64 account balances after the transaction was
  /// processed.
  final List<int> postBalances;

  /// List of inner instructions or omitted if inner instruction
  /// recording was not yet enabled during this transaction.
  final List<InnerInstruction>? innerInstructions;

  /// List of token balances from before the transaction was
  /// processed or omitted if token balance recording was not yet
  /// enabled during this transaction.
  final List<TokenBalance> preTokenBalances;

  /// List of token balances from after the transaction was
  /// processed or omitted if token balance recording was not yet
  /// enabled during this transaction.
  final List<TokenBalance> postTokenBalances;

  /// Array of string log messages or omitted if log message
  /// recording was not yet enabled during this transaction.
  final List<String>? logMessages;

  /// Transaction-level rewards, populated if rewards are requested
  final List<Reward>? rewards;

  /// Transaction addresses loaded from address lookup tables.
  /// Undefined if maxSupportedTransactionVersion is not set in request params.
  final LoadedAddresses? loadedAddresses;

  /// The most-recent return data generated by an instruction in the transaction
  final ReturnData? returnData;

  /// Number of compute units consumed by the transaction
  final int? computeUnitsConsumed;
}
