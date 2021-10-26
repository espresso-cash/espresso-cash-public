///
/// Generated file, please do not modify
///
/// All types needed for the RPC api are defined in this file, they were
/// generated from a specification file in json format.
///

import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/dto/account_data.dart';
import 'package:solana/src/dto/by_identity_value.dart';
import 'package:solana/src/dto/epoch_credits.dart';
import 'package:solana/src/parsed_message/parsed_message.dart';

part 'rpc_types.g.dart';

enum RewardType {
  /// Fee reward
  fee,

  /// Rent reward
  rent,

  /// Staking reward
  staking,

  /// Voting reward
  voting,
}

enum StakeActivationState {
  /// Stake is activating
  activating,

  /// Stake is active
  active,

  /// Stake is deactivating
  deactivating,

  /// Stake is inactive
  inactive,
}

enum CirculationStatus {
  /// Currently circulating
  circulating,

  /// Not currently circulating
  nonCirculating,
}

enum Encoding {
  /// Binary data encoded as base64
  base64,

  /// Attempts to use program-specific state parsers to return
  /// more human-readable and explicit account state data. If
  /// [Encoding.jsonParsed] is requested but a parser cannot be
  /// found, the field falls back to [Encoding.base64] encoding,
  /// detectable when the data field type is [string]
  jsonParsed,

  /// Binary data encoded as base58.
  ///
  /// Base58 is limited to [AccountData] data of less than 129
  /// bytes.
  base58,
}

enum Commitment {
  /// The node will query its most recent block. Note that the
  /// block may not be complete.
  processed,

  /// The node will query the most recent block that has been
  /// voted on by supermajority of the cluster.
  /// -It incorporates votes from gossip and replay.
  /// -It does not count votes on descendants of a block, only
  /// direct votes on that block.
  /// -This confirmation level also upholds "optimistic
  /// confirmation" guarantees in release 1.3 and onwards.
  confirmed,

  /// The node will query the most recent block confirmed by
  /// supermajority of the cluster as having reached maximum
  /// lockout, meaning the cluster has recognized this block as
  /// finalized.
  finalized,
}

enum TransactionDetailLevel {
  /// No details
  none,

  /// Complete transaction details
  full,

  /// Signatures only
  signatures,
}

/// A convenient alias for the confirmation status. Values are
/// the same as [Commitment] but semantically it's a different
/// type.
typedef ConfirmationStatus = Commitment;

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

/// Accounts for a transaction simulation
@JsonSerializable(createFactory: true, includeIfNull: false)
class SimulateTransactionAccounts {
  const SimulateTransactionAccounts({
    this.accountEncoding,
    this.addresses,
  });

  factory SimulateTransactionAccounts.fromJson(Map<String, dynamic> json) =>
      _$SimulateTransactionAccountsFromJson(json);

  Map<String, dynamic> toJson() => _$SimulateTransactionAccountsToJson(this);

  final Encoding? accountEncoding;

  /// An array of accounts to return, as base-58 encoded strings
  final List<String>? addresses;
}

/// Configuration object for [RPCClient.simulateTransaction()]
@JsonSerializable(createFactory: false, includeIfNull: false)
class SimulateTransactionOptions {
  const SimulateTransactionOptions({
    this.sigVerify,
    this.commitment,
    this.replaceRecentBlockhash,
    this.accounts,
  });

  Map<String, dynamic> toJson() => _$SimulateTransactionOptionsToJson(this);

  String get encoding => 'base64';

  /// If true the transaction signatures will be verified
  /// (default: false, conflicts with
  /// [SimulateTransactionOptions.replaceRecentBlockhash])
  final bool? sigVerify;

  final Commitment? commitment;

  /// if true the transaction recent blockhash will be replaced
  /// with the most recent blockhash. (default: false, conflicts
  /// with sigVerify)
  final bool? replaceRecentBlockhash;

  /// Accounts configuration object containing the following
  /// fields:
  final SimulateTransactionAccounts? accounts;
}

/// Configuration object for [RPCClient.sendTransaction()]
@JsonSerializable(createFactory: false, includeIfNull: false)
class SendTransactionOptions {
  const SendTransactionOptions({
    this.commitment,
    this.skipPreflight,
    this.maxRetries,
  });

  Map<String, dynamic> toJson() => _$SendTransactionOptionsToJson(this);

  String get encoding => 'base64';

  final Commitment? commitment;

  /// If true, skip the preflight transaction checks (default:
  /// false).
  final bool? skipPreflight;

  /// Maximum number of times for the RPC node to retry sending
  /// the transaction to the leader. If this parameter not
  /// provided, the RPC node will retry the transaction until it
  /// is finalized or until the blockhash expires.
  final int? maxRetries;
}

/// Configuration object for [RPCClient.getVoteAccounts()]
@JsonSerializable(createFactory: true, includeIfNull: false)
class GetVoteAccountsOptions {
  const GetVoteAccountsOptions({
    this.commitment,
    this.votePubKey,
    this.keepUnstakedDelinquents,
    this.delinquentSlotDistance,
  });

  factory GetVoteAccountsOptions.fromJson(Map<String, dynamic> json) =>
      _$GetVoteAccountsOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$GetVoteAccountsOptionsToJson(this);

  final Commitment? commitment;

  /// Only return results for this validator vote address
  /// (base-58 encoded)
  final String? votePubKey;

  /// Do not filter out delinquent validators with no stake
  final bool? keepUnstakedDelinquents;

  /// Specify the number of slots behind the tip that a validator
  /// must fall to be considered delinquent. NOTE: For the sake
  /// of consistency between ecosystem products, it is not
  /// recommended that this argument be specified.
  final int? delinquentSlotDistance;
}

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

/// Configuration object for [RPCClient.getVoteAccounts()]
@JsonSerializable(createFactory: true, includeIfNull: false)
class GetSupplyOptions {
  const GetSupplyOptions({
    required this.commitment,
    this.excludeNonCirculatingAccountsList,
  });

  factory GetSupplyOptions.fromJson(Map<String, dynamic> json) =>
      _$GetSupplyOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$GetSupplyOptionsToJson(this);

  final Commitment commitment;

  /// exclude non circulating accounts list from response
  final bool? excludeNonCirculatingAccountsList;
}

/// Configuration object for [RPCClient.getStakeActivation()]
@JsonSerializable(createFactory: true, includeIfNull: false)
class GetStakeActivationOptions {
  const GetStakeActivationOptions({
    this.commitment,
    this.epoch,
  });

  factory GetStakeActivationOptions.fromJson(Map<String, dynamic> json) =>
      _$GetStakeActivationOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$GetStakeActivationOptionsToJson(this);

  final Commitment? commitment;

  /// epoch for which to calculate activation details. If
  /// parameter not provided, defaults to current epoch.
  final int? epoch;
}

/// Configuration object for [RPCClient.getStakeActivation()]
@JsonSerializable(createFactory: true, includeIfNull: false)
class GetSignatureStatusesOptions {
  const GetSignatureStatusesOptions({
    this.searchTransactionHistory,
  });

  factory GetSignatureStatusesOptions.fromJson(Map<String, dynamic> json) =>
      _$GetSignatureStatusesOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$GetSignatureStatusesOptionsToJson(this);

  /// If true, a Solana node will search its ledger cache for any
  /// signatures not found in the recent status cache
  final bool? searchTransactionHistory;
}

/// Configuration object for
/// [RPCClient.getSignaturesForAddress()]
@JsonSerializable(createFactory: true, includeIfNull: false)
class GetSignaturesForAddressOptions {
  const GetSignaturesForAddressOptions({
    this.limit,
    this.before,
    this.until,
    this.commitment,
  });

  factory GetSignaturesForAddressOptions.fromJson(Map<String, dynamic> json) =>
      _$GetSignaturesForAddressOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$GetSignaturesForAddressOptionsToJson(this);

  /// Maximum transaction signatures to return (between 1 and
  /// 1,000, default: 1,000).
  final int? limit;

  /// Start searching backwards from this transaction signature.
  /// If not provided the search starts from the top of the
  /// highest max confirmed block.
  final String? before;

  /// Search until this transaction signature, if found before
  /// limit reached.
  final String? until;

  final Commitment? commitment;
}

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

/// Configuration object for [RPCClient.getLeaderSchedule()]
@JsonSerializable(createFactory: true, includeIfNull: false)
class GetLeaderScheduleOptions {
  const GetLeaderScheduleOptions({
    this.commitment,
    this.identity,
  });

  factory GetLeaderScheduleOptions.fromJson(Map<String, dynamic> json) =>
      _$GetLeaderScheduleOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$GetLeaderScheduleOptionsToJson(this);

  final Commitment? commitment;

  /// Only return results for this validator identity (base-58
  /// encoded)
  final String? identity;
}

/// Configuration object for [RPCClient.getLargestAccounts()]
@JsonSerializable(createFactory: true, includeIfNull: false)
class GetLargestAccountsOptions {
  const GetLargestAccountsOptions({
    this.commitment,
    this.filter,
  });

  factory GetLargestAccountsOptions.fromJson(Map<String, dynamic> json) =>
      _$GetLargestAccountsOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$GetLargestAccountsOptionsToJson(this);

  final Commitment? commitment;

  /// filter results by account type; currently supported:
  /// circulating|nonCirculating
  final CirculationStatus? filter;
}

/// Configuration object for [RPCClient.getBlockProduction()]
@JsonSerializable(createFactory: true, includeIfNull: false)
class GetBlockProductionOptions {
  const GetBlockProductionOptions({
    this.commitment,
    this.range,
    this.identity,
  });

  factory GetBlockProductionOptions.fromJson(Map<String, dynamic> json) =>
      _$GetBlockProductionOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$GetBlockProductionOptionsToJson(this);

  final Commitment? commitment;

  /// Slot range to return block production for. If parameter not
  /// provided, defaults to current epoch.
  final Range? range;

  /// Only return results for this validator identity (base-58
  /// encoded)
  final String? identity;
}

/// Configuration object for [RPCClient.getBlock()]
@JsonSerializable(createFactory: true, includeIfNull: false)
class GetBlockOptions {
  const GetBlockOptions({
    this.encoding,
    this.transactionDetails,
    this.rewards,
    this.commitment,
  });

  factory GetBlockOptions.fromJson(Map<String, dynamic> json) =>
      _$GetBlockOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$GetBlockOptionsToJson(this);

  final Encoding? encoding;

  /// Level of transaction detail to return.
  final TransactionDetailLevel? transactionDetails;

  /// Whether to populate the rewards array. If parameter not
  /// provided, the default includes rewards.
  final bool? rewards;

  final Commitment? commitment;
}

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

/// Either a mint or a program id
@JsonSerializable(createFactory: true, includeIfNull: false)
class TokenAccountsFilter {
  const TokenAccountsFilter({
    this.mint,
    this.programId,
  });

  factory TokenAccountsFilter.fromJson(Map<String, dynamic> json) =>
      _$TokenAccountsFilterFromJson(json);

  Map<String, dynamic> toJson() => _$TokenAccountsFilterToJson(this);

  /// Pubkey of the specific token Mint to limit accounts to, as
  /// base-58 encoded string; or
  final String? mint;

  /// Pubkey of the Token program ID that owns the accounts, as
  /// base-58 encoded string
  final String? programId;
}

/// Data slice to limit the account data in a response
@JsonSerializable(createFactory: true, includeIfNull: false)
class DataSlice {
  const DataSlice({
    this.offset,
    this.length,
  });

  factory DataSlice.fromJson(Map<String, dynamic> json) =>
      _$DataSliceFromJson(json);

  Map<String, dynamic> toJson() => _$DataSliceToJson(this);

  /// Start index for the data slice
  final int? offset;

  /// Length of the data slice
  final int? length;
}

/// Configuration of the commitment for some methods
@JsonSerializable(createFactory: true, includeIfNull: false)
class CommitmentConfig {
  const CommitmentConfig({
    required this.commitment,
  });

  factory CommitmentConfig.fromJson(Map<String, dynamic> json) =>
      _$CommitmentConfigFromJson(json);

  Map<String, dynamic> toJson() => _$CommitmentConfigToJson(this);

  final Commitment? commitment;
}

/// An account
@JsonSerializable(createFactory: true, includeIfNull: false)
class Account {
  const Account({
    required this.lamports,
    required this.owner,
    required this.data,
    required this.executable,
    required this.rentEpoch,
  });

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);

  /// Number of lamports assigned to this account, as a u64
  final int lamports;

  /// base-58 encoded Pubkey of the program this account has been
  /// assigned to
  final String owner;

  /// Data associated with the account, either as encoded binary
  /// data or JSON format {<program>: <state>}, depending on
  /// encoding parameter
  final AccountData? data;

  /// Boolean indicating if the account contains a program (and
  /// is strictly read-only)
  final bool executable;

  /// The epoch at which this account will next owe rent, as u64
  final int rentEpoch;
}

/// A block
@JsonSerializable(createFactory: true, includeIfNull: false)
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

  Map<String, dynamic> toJson() => _$BlockToJson(this);

  /// The blockhash of this block, as base-58 encoded string
  final String blockhash;

  /// The blockhash of this block's parent, as base-58 encoded
  /// string; if the parent block is not available due to ledger
  /// cleanup, this field will return
  /// "11111111111111111111111111111111"
  final String previousBlockhash;

  /// The slot index of this block's parent
  final int parentSlot;

  /// Present if [TransactionDetailLevel.full] transaction
  /// details are requested; an array of [Transaction] objects
  final List<Transaction> transactions;

  /// Transaction status metadata object
  final Meta? meta;

  /// Present if [TransactionDetailLevel.signatures] are
  /// requested for transaction details; an array of signatures
  /// strings, corresponding to the transaction order in the
  /// block.
  final List<String> signatures;

  /// Present if rewards are requested; an array of [Reward]
  /// objects.
  final List<Reward> rewards;

  /// Estimated production time, as Unix timestamp (seconds since
  /// the Unix epoch). None if not available.
  final int? blockTime;

  /// The number of blocks beneath this block
  final int? blockHeight;
}

/// Transaction state metadata
@JsonSerializable(createFactory: true, includeIfNull: false)
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
  });

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

  Map<String, dynamic> toJson() => _$MetaToJson(this);

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
  final List<InnerInstruction> innerInstructions;

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
  final List<String> logMessages;
}

/// A reward
@JsonSerializable(createFactory: true, includeIfNull: false)
class Reward {
  const Reward({
    required this.pubkey,
    required this.lamports,
    required this.postBalance,
    required this.rewardType,
    required this.commission,
  });

  factory Reward.fromJson(Map<String, dynamic> json) => _$RewardFromJson(json);

  Map<String, dynamic> toJson() => _$RewardToJson(this);

  /// The public key, as base-58 encoded string, of the account
  /// that received the reward.
  final String pubkey;

  /// Number of reward lamports credited or debited by the
  /// account, as a i64.
  final int lamports;

  /// Account balance in lamports after the reward was applied.
  final int postBalance;

  /// Type of reward
  final RewardType rewardType;

  /// vote account commission when the reward was credited, only
  /// present for voting and staking rewards
  final int commission;
}

/// The header of a transaction message
@JsonSerializable(createFactory: true, includeIfNull: false)
class TransactionMessageHeader {
  const TransactionMessageHeader({
    required this.numRequiredSignatures,
    required this.numReadonlySignedAccounts,
    required this.numReadonlyUnsignedAccounts,
  });

  factory TransactionMessageHeader.fromJson(Map<String, dynamic> json) =>
      _$TransactionMessageHeaderFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionMessageHeaderToJson(this);

  /// The total number of signatures required to make the
  /// transaction valid. The signatures must match the first
  /// numRequiredSignatures of message.account_keys.
  final int numRequiredSignatures;

  /// The last numReadonlySignedAccounts of the signed keys are
  /// read-only accounts. Programs may process multiple
  /// transactions that load read-only accounts within a single
  /// PoH entry, but are not permitted to credit or debit
  /// lamports or modify account data. Transactions targeting the
  /// same read-write account are evaluated sequentially.
  final int numReadonlySignedAccounts;

  /// The last numReadonlyUnsignedAccounts of the unsigned keys
  /// are read-only accounts.
  final int numReadonlyUnsignedAccounts;
}

/// A transaction message
@JsonSerializable(createFactory: true, includeIfNull: false)
class TransactionMessage {
  const TransactionMessage({
    required this.accountKeys,
    required this.header,
    required this.recentBlockhash,
    required this.instructions,
  });

  factory TransactionMessage.fromJson(Map<String, dynamic> json) =>
      _$TransactionMessageFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionMessageToJson(this);

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
}

/// A transaction
@JsonSerializable(createFactory: true, includeIfNull: false)
class Transaction {
  const Transaction({
    required this.signatures,
    required this.message,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);

  /// A list of base-58 encoded signatures applied to the
  /// transaction. The list is always of length
  /// message.header.numRequiredSignatures and not empty. The
  /// signature at index i corresponds to the public key at index
  /// i in message.account_keys. The first one is used as the
  /// transaction id.
  final List<String> signatures;

  /// Defines the content of the transaction.
  final ParsedMessage message;
}

/// Details of a transaction
@JsonSerializable(createFactory: true, includeIfNull: false)
class TransactionDetails {
  const TransactionDetails({
    required this.slot,
    required this.transaction,
    required this.blockTime,
    required this.meta,
  });

  factory TransactionDetails.fromJson(Map<String, dynamic> json) =>
      _$TransactionDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionDetailsToJson(this);

  /// the slot this transaction was processed in
  final int slot;

  /// Transaction object, either in JSON format or encoded binary
  /// data, depending on encoding parameter
  final Transaction transaction;

  ///
  final int? blockTime;

  /// transaction status metadata
  final Meta meta;
}

/// List of inner instructions or omitted if inner instruction
/// recording was not yet enabled during this transaction
@JsonSerializable(createFactory: true, includeIfNull: false)
class InnerInstruction {
  const InnerInstruction({
    required this.index,
    required this.instruction,
  });

  factory InnerInstruction.fromJson(Map<String, dynamic> json) =>
      _$InnerInstructionFromJson(json);

  Map<String, dynamic> toJson() => _$InnerInstructionToJson(this);

  /// Index of the transaction instruction from which the inner
  /// instruction(s) originated
  final int index;

  /// Ordered list of inner program instructions that were
  /// invoked during a single transaction instruction.
  final List<Instruction> instruction;
}

/// An instruction in a transaction
@JsonSerializable(createFactory: true, includeIfNull: false)
class Instruction {
  const Instruction({
    required this.programIdIndex,
    required this.accounts,
    required this.data,
  });

  factory Instruction.fromJson(Map<String, dynamic> json) =>
      _$InstructionFromJson(json);

  Map<String, dynamic> toJson() => _$InstructionToJson(this);

  /// Index into the message.accountKeys array indicating the
  /// program account that executes this instruction.
  final int programIdIndex;

  /// List of ordered indices into the message.accountKeys array
  /// indicating which accounts to pass to the program.
  final List<int> accounts;

  /// The program input data encoded in a base-58 string.
  final String data;
}

/// The amount of a SPL token
@JsonSerializable(createFactory: true, includeIfNull: false)
class TokenAmount {
  const TokenAmount({
    required this.amount,
    required this.decimals,
    required this.uiAmountString,
  });

  factory TokenAmount.fromJson(Map<String, dynamic> json) =>
      _$TokenAmountFromJson(json);

  Map<String, dynamic> toJson() => _$TokenAmountToJson(this);

  /// Raw amount of tokens as a string, ignoring decimals.
  final String amount;

  /// Number of decimals configured for token's mint.
  final int decimals;

  /// Token amount as a string, accounting for decimals.
  final String? uiAmountString;
}

/// The balance of a SPL token account
@JsonSerializable(createFactory: true, includeIfNull: false)
class TokenBalance {
  const TokenBalance({
    required this.accountIndex,
    required this.mint,
    required this.uiTokenAmount,
  });

  factory TokenBalance.fromJson(Map<String, dynamic> json) =>
      _$TokenBalanceFromJson(json);

  Map<String, dynamic> toJson() => _$TokenBalanceToJson(this);

  /// Index of the account in which the token balance is provided
  /// for.
  final int accountIndex;

  /// Pubkey of the token's mint.
  final String mint;

  /// Token balance
  final TokenAmount uiTokenAmount;
}

/// A node of a cluster
@JsonSerializable(createFactory: true, includeIfNull: false)
class ClusterNode {
  const ClusterNode({
    required this.pubkey,
    required this.gossip,
    required this.tpu,
    required this.rpc,
    required this.version,
    required this.featureSet,
    required this.shredVersion,
  });

  factory ClusterNode.fromJson(Map<String, dynamic> json) =>
      _$ClusterNodeFromJson(json);

  Map<String, dynamic> toJson() => _$ClusterNodeToJson(this);

  /// Node public key, as base-58 encoded string
  final String pubkey;

  /// Gossip network address for the node
  final String gossip;

  /// TPU network address for the node
  final String tpu;

  /// JSON RPC network address for the node, or null if the JSON
  /// RPC service is not enabled
  final String? rpc;

  /// The software version of the node, or null if the version
  /// information is not available
  final String? version;

  /// The unique identifier of the node's feature set
  final int? featureSet;

  /// The shred version the node has been configured to use
  final int? shredVersion;
}

/// Information about an epoch
@JsonSerializable(createFactory: true, includeIfNull: false)
class EpochInfo {
  const EpochInfo({
    required this.absoluteSlot,
    required this.blockHeight,
    required this.epoch,
    required this.slotIndex,
    required this.slotsInEpoch,
  });

  factory EpochInfo.fromJson(Map<String, dynamic> json) =>
      _$EpochInfoFromJson(json);

  Map<String, dynamic> toJson() => _$EpochInfoToJson(this);

  /// The current slot
  final int absoluteSlot;

  /// The current block height
  final int blockHeight;

  /// The current epoch
  final int epoch;

  /// The current slot relative to the start of the current epoch
  final int slotIndex;

  /// The number of slots in this epoch
  final int slotsInEpoch;
}

/// A fee calculator
@JsonSerializable(createFactory: true, includeIfNull: false)
class FeeCalculator {
  const FeeCalculator({
    required this.lamportsPerSignature,
  });

  factory FeeCalculator.fromJson(Map<String, dynamic> json) =>
      _$FeeCalculatorFromJson(json);

  Map<String, dynamic> toJson() => _$FeeCalculatorToJson(this);

  /// number of lamports per signature in a transaction
  final int lamportsPerSignature;
}

/// A range of bytes
@JsonSerializable(createFactory: true, includeIfNull: false)
class Range {
  const Range({
    required this.firstSlot,
    required this.lastSlot,
  });

  factory Range.fromJson(Map<String, dynamic> json) => _$RangeFromJson(json);

  Map<String, dynamic> toJson() => _$RangeToJson(this);

  /// first slot of the block production information (inclusive)
  final int firstSlot;

  /// last slot of block production information (inclusive)
  final int lastSlot;
}

/// A block production
@JsonSerializable(createFactory: true, includeIfNull: false)
class BlockProduction {
  const BlockProduction({
    required this.byIdentity,
    required this.range,
  });

  factory BlockProduction.fromJson(Map<String, dynamic> json) =>
      _$BlockProductionFromJson(json);

  Map<String, dynamic> toJson() => _$BlockProductionToJson(this);

  /// A dictionary of validator identities, as base-58 encoded
  /// strings. Value is a two element array containing the number
  /// of leader slots and the number of blocks produced.
  final Map<String, ByIdentityValue> byIdentity;

  /// Block production slot range
  final Range range;
}

/// The commitment of a bloc
@JsonSerializable(createFactory: true, includeIfNull: false)
class BlockCommitment {
  const BlockCommitment({
    required this.commitment,
    required this.totalStake,
  });

  factory BlockCommitment.fromJson(Map<String, dynamic> json) =>
      _$BlockCommitmentFromJson(json);

  Map<String, dynamic> toJson() => _$BlockCommitmentToJson(this);

  /// Commitment, array of u64 integers logging the amount of
  /// cluster stake in lamports that has voted on the block at
  /// each depth from 0 to MAX_LOCKOUT_HISTORY + 1.
  final List<int>? commitment;

  /// Total active stake, in lamports, of the current epoch.
  final int totalStake;
}

/// An epoch schedule
@JsonSerializable(createFactory: true, includeIfNull: false)
class EpochSchedule {
  const EpochSchedule({
    required this.slotsPerEpoch,
    required this.leaderScheduleSlotOffset,
    required this.warmup,
    required this.firstNormalEpoch,
    required this.firstNormalSlot,
  });

  factory EpochSchedule.fromJson(Map<String, dynamic> json) =>
      _$EpochScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$EpochScheduleToJson(this);

  /// The maximum number of slots in each epoch.
  final int slotsPerEpoch;

  /// The number of slots before beginning of an epoch to
  /// calculate a leader schedule for that epoch.
  final int leaderScheduleSlotOffset;

  /// Whether epochs start short and grow.
  final bool warmup;

  /// First normal-length epoch, log2(slotsPerEpoch) -
  /// log2(MINIMUM_SLOTS_PER_EPOCH).
  final int firstNormalEpoch;

  /// MINIMUM_SLOTS_PER_EPOCH * (2.pow(firstNormalEpoch) - 1).
  final int firstNormalSlot;
}

/// The value of a fee rate governor
@JsonSerializable(createFactory: true, includeIfNull: false)
class FeeRateGovernorValue {
  const FeeRateGovernorValue({
    required this.burnPercent,
    required this.maxLamportsPerSignature,
    required this.minLamportsPerSignature,
    required this.targetLamportsPerSignature,
    required this.targetSignaturesPerSlot,
  });

  factory FeeRateGovernorValue.fromJson(Map<String, dynamic> json) =>
      _$FeeRateGovernorValueFromJson(json);

  Map<String, dynamic> toJson() => _$FeeRateGovernorValueToJson(this);

  /// Percentage of fees collected to be destroyed.
  final int burnPercent;

  /// Largest value lamportsPerSignature can attain for the next
  /// slot.
  final int maxLamportsPerSignature;

  /// Smallest value lamportsPerSignature can attain for the next
  /// slot.
  final int minLamportsPerSignature;

  /// Desired fee rate for the cluster.
  final int targetLamportsPerSignature;

  /// Desired signature rate for the cluster.
  final int targetSignaturesPerSlot;
}

/// A fee rate governor
@JsonSerializable(createFactory: true, includeIfNull: false)
class FeeRateGovernor {
  const FeeRateGovernor({
    required this.feeRateGovernor,
  });

  factory FeeRateGovernor.fromJson(Map<String, dynamic> json) =>
      _$FeeRateGovernorFromJson(json);

  Map<String, dynamic> toJson() => _$FeeRateGovernorToJson(this);

  /// Fee rate governor
  final FeeRateGovernorValue feeRateGovernor;
}

/// A fee description object
@JsonSerializable(createFactory: true, includeIfNull: false)
class Fees {
  const Fees({
    required this.blockhash,
    required this.feeCalculator,
    required this.lastValidBlockHeight,
  });

  factory Fees.fromJson(Map<String, dynamic> json) => _$FeesFromJson(json);

  Map<String, dynamic> toJson() => _$FeesToJson(this);

  /// Hash as base-58 encoded string
  final String blockhash;

  /// [FeeCalculator] object, the fee schedule for this block hash
  final FeeCalculator feeCalculator;

  /// Last block height at which a [blockhash] will be valid
  final int lastValidBlockHeight;
}

/// An identity (or a public key)
@JsonSerializable(createFactory: true, includeIfNull: false)
class Identity {
  const Identity({
    required this.identity,
  });

  factory Identity.fromJson(Map<String, dynamic> json) =>
      _$IdentityFromJson(json);

  Map<String, dynamic> toJson() => _$IdentityToJson(this);

  /// the identity pubkey of the current node (as a base-58
  /// encoded string)
  final String identity;
}

/// An inflation governor
@JsonSerializable(createFactory: true, includeIfNull: false)
class InflationGovernor {
  const InflationGovernor({
    required this.initial,
    required this.terminal,
    required this.taper,
    required this.foundation,
    required this.foundationTerm,
  });

  factory InflationGovernor.fromJson(Map<String, dynamic> json) =>
      _$InflationGovernorFromJson(json);

  Map<String, dynamic> toJson() => _$InflationGovernorToJson(this);

  /// The initial inflation percentage from time 0.
  final double initial;

  /// Terminal inflation percentage.
  final double terminal;

  /// Rate per year at which inflation is lowered.\nRate
  /// reduction is derived using the target slot time in genesis
  /// config.
  final double taper;

  /// Percentage of total inflation allocated to the foundation.
  final double foundation;

  /// Duration of foundation pool inflation in years.
  final double foundationTerm;
}

/// An inflation rate
@JsonSerializable(createFactory: true, includeIfNull: false)
class InflationRate {
  const InflationRate({
    required this.total,
    required this.validator,
    required this.foundation,
    required this.epoch,
  });

  factory InflationRate.fromJson(Map<String, dynamic> json) =>
      _$InflationRateFromJson(json);

  Map<String, dynamic> toJson() => _$InflationRateToJson(this);

  /// Total inflation.
  final double total;

  /// Inflation allocated to validators.
  final double validator;

  /// Inflation allocated to the foundation.
  final double foundation;

  /// Epoch for which these values are valid.
  final double epoch;
}

/// An inflation reward
@JsonSerializable(createFactory: true, includeIfNull: false)
class InflationReward {
  const InflationReward({
    required this.epoch,
    required this.effectiveSlot,
    required this.amount,
    required this.postBalance,
    required this.commission,
  });

  factory InflationReward.fromJson(Map<String, dynamic> json) =>
      _$InflationRewardFromJson(json);

  Map<String, dynamic> toJson() => _$InflationRewardToJson(this);

  /// Epoch for which reward occurred.
  final int epoch;

  /// The slot in which the rewards are effective.
  final int effectiveSlot;

  /// Reward amount in lamports.
  final int amount;

  /// Post balance of the account in lamports.
  final int postBalance;

  /// Vote account commission when the reward was credited.
  final int commission;
}

/// A large account
@JsonSerializable(createFactory: true, includeIfNull: false)
class LargeAccount {
  const LargeAccount({
    required this.address,
    required this.lamports,
  });

  factory LargeAccount.fromJson(Map<String, dynamic> json) =>
      _$LargeAccountFromJson(json);

  Map<String, dynamic> toJson() => _$LargeAccountToJson(this);

  /// base-58 encoded address of the account
  final String address;

  /// Number of lamports in the account, as a u64
  final int lamports;
}

/// A parameters object for a filter of program data
@JsonSerializable(createFactory: true, includeIfNull: false)
class FilterParams {
  const FilterParams({
    required this.offset,
    required this.bytes,
  });

  factory FilterParams.fromJson(Map<String, dynamic> json) =>
      _$FilterParamsFromJson(json);

  Map<String, dynamic> toJson() => _$FilterParamsToJson(this);

  /// Offset into program account data to start comparison.
  final int offset;

  /// Data to match, as base-58 encoded string and limited to
  /// less than 129 bytes.
  final String bytes;
}

/// A filter of program data
@JsonSerializable(createFactory: true, includeIfNull: false)
class Filter {
  const Filter({
    required this.memcmp,
    required this.dataSize,
  });

  factory Filter.fromJson(Map<String, dynamic> json) => _$FilterFromJson(json);

  Map<String, dynamic> toJson() => _$FilterToJson(this);

  /// Compares a provided series of bytes with program account
  /// data at a particular offset.
  final FilterParams memcmp;

  /// Compares the program account data length with the provided
  /// data size.
  final int dataSize;
}

/// A program account
@JsonSerializable(createFactory: true, includeIfNull: false)
class ProgramAccount {
  const ProgramAccount({
    required this.account,
    required this.pubkey,
  });

  factory ProgramAccount.fromJson(Map<String, dynamic> json) =>
      _$ProgramAccountFromJson(json);

  Map<String, dynamic> toJson() => _$ProgramAccountToJson(this);

  /// The account information for this program account.
  final Account account;

  /// The account Pubkey as base-58 encoded string.
  final String pubkey;
}

/// The fee calculator for a blockhash
@JsonSerializable(createFactory: true, includeIfNull: false)
class FeeCalculatorForBlockhash {
  const FeeCalculatorForBlockhash({
    required this.feeCalculator,
  });

  factory FeeCalculatorForBlockhash.fromJson(Map<String, dynamic> json) =>
      _$FeeCalculatorForBlockhashFromJson(json);

  Map<String, dynamic> toJson() => _$FeeCalculatorForBlockhashToJson(this);

  /// [FeeCalculator] object, the fee schedule for this block hash
  final FeeCalculator feeCalculator;
}

/// A recent blockhash
@JsonSerializable(createFactory: true, includeIfNull: false)
class RecentBlockhash {
  const RecentBlockhash({
    required this.blockhash,
    required this.feeCalculator,
  });

  factory RecentBlockhash.fromJson(Map<String, dynamic> json) =>
      _$RecentBlockhashFromJson(json);

  Map<String, dynamic> toJson() => _$RecentBlockhashToJson(this);

  /// Hash as base-58 encoded string
  final String blockhash;

  /// [FeeCalculator] object, the fee schedule for this block hash
  final FeeCalculator feeCalculator;
}

/// A performance sample
@JsonSerializable(createFactory: true, includeIfNull: false)
class PerfSample {
  const PerfSample({
    required this.slot,
    required this.numTransactions,
    required this.numSlots,
    required this.samplePeriodSec,
  });

  factory PerfSample.fromJson(Map<String, dynamic> json) =>
      _$PerfSampleFromJson(json);

  Map<String, dynamic> toJson() => _$PerfSampleToJson(this);

  /// Slot in which sample was taken at.
  final int slot;

  /// Number of transactions in sample.
  final int numTransactions;

  /// Number of slots in sample.
  final int numSlots;

  /// Number of seconds in a sample window.
  final int samplePeriodSec;
}

/// The information of a transaction signature
@JsonSerializable(createFactory: true, includeIfNull: false)
class TransactionSignatureInformation {
  const TransactionSignatureInformation({
    required this.signature,
    required this.slot,
    required this.err,
    required this.memo,
    required this.blockTime,
  });

  factory TransactionSignatureInformation.fromJson(Map<String, dynamic> json) =>
      _$TransactionSignatureInformationFromJson(json);

  Map<String, dynamic> toJson() =>
      _$TransactionSignatureInformationToJson(this);

  /// Transaction signature as base-58 encoded string.
  final String signature;

  /// The slot that contains the block with the transaction.
  final int slot;

  final Map<String, dynamic>? err;

  /// Memo associated with the transaction, null if no memo is
  /// present.
  final String? memo;

  /// Estimated production time, as Unix timestamp (seconds since
  /// the Unix epoch) of when transaction was processed. null if
  /// not available.
  final int? blockTime;
}

/// The status of a signature
@JsonSerializable(createFactory: true, includeIfNull: false)
class SignatureStatus {
  const SignatureStatus({
    required this.slot,
    required this.confirmations,
    required this.err,
    required this.confirmationStatus,
  });

  factory SignatureStatus.fromJson(Map<String, dynamic> json) =>
      _$SignatureStatusFromJson(json);

  Map<String, dynamic> toJson() => _$SignatureStatusToJson(this);

  /// The slot the transaction was processed.
  final int slot;

  /// Number of blocks since signature confirmation, null if
  /// rooted, as well as finalized.
  final int? confirmations;

  final Map<String, dynamic>? err;

  /// The transaction's cluster confirmation status; either
  /// [Commitment.processed], [Commitment.confirmed], or
  /// [Commitment.finalized]. See
  /// [Commitment](@help/commitment/link) for more on optimistic
  /// confirmation.
  final ConfirmationStatus confirmationStatus;
}

/// A stake activation description
@JsonSerializable(createFactory: true, includeIfNull: false)
class StakeActivation {
  const StakeActivation({
    required this.state,
    required this.active,
    required this.inactive,
  });

  factory StakeActivation.fromJson(Map<String, dynamic> json) =>
      _$StakeActivationFromJson(json);

  Map<String, dynamic> toJson() => _$StakeActivationToJson(this);

  /// Stake account's activation state
  final StakeActivationState state;

  /// Stake active during the epoch.
  final int active;

  /// Stake inactive during the epoch.
  final int inactive;
}

/// The total supply of tokens
@JsonSerializable(createFactory: true, includeIfNull: false)
class Supply {
  const Supply({
    required this.total,
    required this.circulating,
    required this.nonCirculating,
    required this.nonCirculatingAccounts,
  });

  factory Supply.fromJson(Map<String, dynamic> json) => _$SupplyFromJson(json);

  Map<String, dynamic> toJson() => _$SupplyToJson(this);

  /// Total supply in lamports.
  final int total;

  /// Circulating supply in lamports.
  final int circulating;

  /// Non-circulating supply in lamports.
  final int nonCirculating;

  /// An array of account addresses of non-circulating accounts,
  /// as strings. If [excludeNonCirculatingAccountsList] is
  /// enabled, the returned array will be empty.
  final List<String> nonCirculatingAccounts;
}

/// The solana version
@JsonSerializable(createFactory: true, includeIfNull: false)
class SolanaVersion {
  const SolanaVersion({
    required this.solanaCore,
    required this.featureSet,
  });

  factory SolanaVersion.fromJson(Map<String, dynamic> json) =>
      _$SolanaVersionFromJson(json);

  Map<String, dynamic> toJson() => _$SolanaVersionToJson(this);

  /// Software version of solana-core.
  @JsonKey(name: 'solana-core')
  final String solanaCore;

  /// Unique identifier of current feature set.
  @JsonKey(name: 'feature-set')
  final int featureSet;
}

/// Result of calling [RPCClient.getVoteAccounts()]
@JsonSerializable(createFactory: true, includeIfNull: false)
class VoteAccounts {
  const VoteAccounts({
    required this.current,
    required this.delinquent,
  });

  factory VoteAccounts.fromJson(Map<String, dynamic> json) =>
      _$VoteAccountsFromJson(json);

  Map<String, dynamic> toJson() => _$VoteAccountsToJson(this);

  /// Current vote account
  final List<VoteAccount> current;

  /// Delinquent vote account
  final List<VoteAccount> delinquent;
}

/// A list of vote accounts
@JsonSerializable(createFactory: true, includeIfNull: false)
class VoteAccount {
  const VoteAccount({
    required this.votePubkey,
    required this.nodePubkey,
    required this.activatedStake,
    required this.epochVoteAccount,
    required this.commission,
    required this.lastVote,
    required this.epochCredits,
  });

  factory VoteAccount.fromJson(Map<String, dynamic> json) =>
      _$VoteAccountFromJson(json);

  Map<String, dynamic> toJson() => _$VoteAccountToJson(this);

  /// Vote account address, as base-58 encoded string.
  final String votePubkey;

  /// Validator identity, as base-58 encoded string.
  final String nodePubkey;

  /// The stake, in lamports, delegated to this vote account and
  /// active in this epoch.
  final int activatedStake;

  /// Bool, whether the vote account is staked for this epoch.
  final bool epochVoteAccount;

  /// Percentage (0-100) of rewards payout owed to the vote
  /// account.
  final int commission;

  /// Most recent slot voted on by this vote account.
  final int lastVote;

  /// History of how many credits earned by the end of each
  /// epoch, as an array of arrays containing: [epoch, credits,
  /// previousCredits].
  final List<EpochCredits> epochCredits;
}

/// The status of a transaction
@JsonSerializable(createFactory: true, includeIfNull: false)
class TransactionStatus {
  const TransactionStatus({
    required this.err,
    required this.logs,
    required this.accounts,
  });

  factory TransactionStatus.fromJson(Map<String, dynamic> json) =>
      _$TransactionStatusFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionStatusToJson(this);

  final Map<String, dynamic>? err;

  /// Array of log messages the transaction instructions output
  /// during execution, null if simulation failed before the
  /// transaction was able to execute (for example due to an
  /// invalid blockhash or signature verification failure).
  final List<String>? logs;

  /// Array of [Account]s with the same length as the
  /// [SimulateTransactionAccounts.addresses] array in the request
  final List<Account>? accounts;
}
