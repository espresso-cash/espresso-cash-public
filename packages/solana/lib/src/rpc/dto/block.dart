import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/dto/meta.dart';
import 'package:solana/src/rpc/dto/reward.dart';
import 'package:solana/src/rpc/dto/transaction.dart';

part 'block.g.dart';

/// A block
@JsonSerializable()
class Block {
  const Block({
    required this.blockhash,
    required this.previousBlockhash,
    required this.parentSlot,
    required this.transactions,
    required this.meta,
    required this.signatures,
    required this.rewards,
    required this.blockTime,
    required this.blockHeight,
  });

  factory Block.fromJson(Map<String, dynamic> json) => _$BlockFromJson(json);

  /// The blockhash of this block, as base-58 encoded string
  final String blockhash;

  /// The blockhash of this block's parent, as base-58 encoded
  /// string; if the parent block is not available due to ledger
  /// cleanup, this field will return
  /// "11111111111111111111111111111111"
  final String previousBlockhash;

  /// The slot index of this block's parent
  final int parentSlot;

  /// Present if `TransactionDetailLevel.full` transaction details are
  /// requested; an array of [Transaction] objects
  final List<Transaction> transactions;

  /// Transaction status metadata object
  final Meta? meta;

  /// Present if `TransactionDetailLevel.signatures` are requested for
  /// transaction details; an array of signatures strings, corresponding to the
  /// transaction order in the block.
  final List<String> signatures;

  /// Present if rewards are requested; an array of [Reward]
  /// objects.
  final List<Reward> rewards;

  /// Estimated production time, as Unix timestamp (seconds since
  /// the Unix epoch). None if not available.
  final int? blockTime;

  /// The number of blocks beneath this block
  final int? blockHeight;

  Map<String, dynamic> toJson() => _$BlockToJson(this);
}
