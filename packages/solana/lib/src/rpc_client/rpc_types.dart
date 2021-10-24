///
/// Generated file, please do not modify
///
/// All types needed for the RPC api are defined in this file, they were
/// generated from a specification file in json format.
///

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/src/dto/account_data.dart';
import 'package:solana/src/dto/by_identity_value.dart';

part 'rpc_types.freezed.dart';
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
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class GetConfirmedTransactionOptions with _$GetConfirmedTransactionOptions {
  /// - [encoding] @help/encoding
  /// - [commitment] @help/commitment
  const factory GetConfirmedTransactionOptions({
    Encoding? encoding,
    Commitment? commitment,
  }) = _GetConfirmedTransactionOptions;

  factory GetConfirmedTransactionOptions.fromJson(Map<String, dynamic> data) =>
      _$GetConfirmedTransactionOptionsFromJson(data);
}

/// Accounts for a transaction simulation
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class SimulateTransactionAccounts with _$SimulateTransactionAccounts {
  /// - [accountEncoding] @help/encoding
  /// - [addresses] An array of accounts to return, as base-58
  /// encoded strings
  const factory SimulateTransactionAccounts({
    Encoding? accountEncoding,
    List<String>? addresses,
  }) = _SimulateTransactionAccounts;

  factory SimulateTransactionAccounts.fromJson(Map<String, dynamic> data) =>
      _$SimulateTransactionAccountsFromJson(data);
}

/// Configuration object for [RPCClient.simulateTransaction()]
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class SimulateTransactionOptions with _$SimulateTransactionOptions {
  /// - [sigVerify] If true the transaction signatures will be
  /// verified (default: false, conflicts with
  /// [SimulateTransactionOptions.replaceRecentBlockhash])
  /// - [encoding] Only [Encoding.base64] is acceptable
  /// - [commitment] @help/commitment
  /// - [replaceRecentBlockhash] if true the transaction recent
  /// blockhash will be replaced with the most recent blockhash.
  /// (default: false, conflicts with sigVerify)
  /// - [accounts] Accounts configuration object containing the
  /// following fields:
  const factory SimulateTransactionOptions({
    bool? sigVerify,
    Commitment? commitment,
    bool? replaceRecentBlockhash,
    SimulateTransactionAccounts? accounts,
  }) = _SimulateTransactionOptions;

  factory SimulateTransactionOptions.fromJson(Map<String, dynamic> data) =>
      _$SimulateTransactionOptionsFromJson(data);

  const SimulateTransactionOptions._();

  String get encoding => 'base64';
}

/// Configuration object for [RPCClient.sendTransaction()]
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class SendTransactionOptions with _$SendTransactionOptions {
  /// - [encoding] Only [Encoding.base64] is acceptable
  /// - [commitment] @help/commitment
  /// - [skipPreflight] If true, skip the preflight transaction
  /// checks (default: false).
  /// - [maxRetries] Maximum number of times for the RPC node to
  /// retry sending the transaction to the leader. If this
  /// parameter not provided, the RPC node will retry the
  /// transaction until it is finalized or until the blockhash
  /// expires.
  const factory SendTransactionOptions({
    Commitment? commitment,
    bool? skipPreflight,
    int? maxRetries,
  }) = _SendTransactionOptions;

  factory SendTransactionOptions.fromJson(Map<String, dynamic> data) =>
      _$SendTransactionOptionsFromJson(data);

  const SendTransactionOptions._();

  String get encoding => 'base64';
}

/// Configuration object for [RPCClient.getVoteAccounts()]
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class GetVoteAccountsOptions with _$GetVoteAccountsOptions {
  /// - [commitment] @help/commitment
  /// - [votePubKey] Only return results for this validator vote
  /// address (base-58 encoded)
  /// - [keepUnstakedDelinquents] Do not filter out delinquent
  /// validators with no stake
  /// - [delinquentSlotDistance] Specify the number of slots
  /// behind the tip that a validator must fall to be considered
  /// delinquent. NOTE: For the sake of consistency between
  /// ecosystem products, it is not recommended that this
  /// argument be specified.
  const factory GetVoteAccountsOptions({
    Commitment? commitment,
    String? votePubKey,
    bool? keepUnstakedDelinquents,
    int? delinquentSlotDistance,
  }) = _GetVoteAccountsOptions;

  factory GetVoteAccountsOptions.fromJson(Map<String, dynamic> data) =>
      _$GetVoteAccountsOptionsFromJson(data);
}

/// Configuration object for [RPCClient.getVoteAccounts()]
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class GetTransactionOptions with _$GetTransactionOptions {
  /// - [encoding] @help/encoding
  /// - [commitment] @help/commitment
  const factory GetTransactionOptions({
    Encoding? encoding,
    Commitment? commitment,
  }) = _GetTransactionOptions;

  factory GetTransactionOptions.fromJson(Map<String, dynamic> data) =>
      _$GetTransactionOptionsFromJson(data);
}

/// Configuration object for [RPCClient.getVoteAccounts()]
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class GetSupplyOptions with _$GetSupplyOptions {
  /// - [commitment] @help/commitment
  /// - [excludeNonCirculatingAccountsList] exclude non
  /// circulating accounts list from response
  const factory GetSupplyOptions({
    Commitment? commitment,
    bool? excludeNonCirculatingAccountsList,
  }) = _GetSupplyOptions;

  factory GetSupplyOptions.fromJson(Map<String, dynamic> data) =>
      _$GetSupplyOptionsFromJson(data);
}

/// Configuration object for [RPCClient.getStakeActivation()]
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class GetStakeActivationOptions with _$GetStakeActivationOptions {
  /// - [commitment] @help/commitment
  /// - [epoch] epoch for which to calculate activation details.
  /// If parameter not provided, defaults to current epoch.
  const factory GetStakeActivationOptions({
    Commitment? commitment,
    int? epoch,
  }) = _GetStakeActivationOptions;

  factory GetStakeActivationOptions.fromJson(Map<String, dynamic> data) =>
      _$GetStakeActivationOptionsFromJson(data);
}

/// Configuration object for [RPCClient.getStakeActivation()]
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class GetSignatureStatusesOptions with _$GetSignatureStatusesOptions {
  /// - [searchTransactionHistory] If true, a Solana node will
  /// search its ledger cache for any signatures not found in the
  /// recent status cache
  const factory GetSignatureStatusesOptions({
    bool? searchTransactionHistory,
  }) = _GetSignatureStatusesOptions;

  factory GetSignatureStatusesOptions.fromJson(Map<String, dynamic> data) =>
      _$GetSignatureStatusesOptionsFromJson(data);
}

/// Configuration object for
/// [RPCClient.getSignaturesForAddress()]
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class GetSignaturesForAddressOptions with _$GetSignaturesForAddressOptions {
  /// - [limit] Maximum transaction signatures to return (between
  /// 1 and 1,000, default: 1,000).
  /// - [before] Start searching backwards from this transaction
  /// signature. If not provided the search starts from the top
  /// of the highest max confirmed block.
  /// - [until] Search until this transaction signature, if found
  /// before limit reached.
  /// - [commitment] @help/commitment
  const factory GetSignaturesForAddressOptions({
    int? limit,
    String? before,
    String? until,
    Commitment? commitment,
  }) = _GetSignaturesForAddressOptions;

  factory GetSignaturesForAddressOptions.fromJson(Map<String, dynamic> data) =>
      _$GetSignaturesForAddressOptionsFromJson(data);
}

/// Configuration object for [RPCClient.getProgramAccounts()]
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class GetProgramAccountsOptions with _$GetProgramAccountsOptions {
  /// - [commitment] @help/commitment
  /// - [encoding] @help/encoding
  /// - [dataSlice] Limit the returned account data using the
  /// provided offset: <usize> and length: <usize> fields; only
  /// available for "base58""base64" or "base64+zstd" encodings.
  /// - [filter] Filter results using various filter objects;
  /// account must meet all filter criteria to be included in
  /// results
  const factory GetProgramAccountsOptions({
    Commitment? commitment,
    Encoding? encoding,
    DataSlice? dataSlice,
    List<Filter>? filter,
  }) = _GetProgramAccountsOptions;

  factory GetProgramAccountsOptions.fromJson(Map<String, dynamic> data) =>
      _$GetProgramAccountsOptionsFromJson(data);
}

/// Configuration object for [RPCClient.getLeaderSchedule()]
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class GetLeaderScheduleOptions with _$GetLeaderScheduleOptions {
  /// - [commitment] @help/commitment
  /// - [identity] Only return results for this validator
  /// identity (base-58 encoded)
  const factory GetLeaderScheduleOptions({
    Commitment? commitment,
    String? identity,
  }) = _GetLeaderScheduleOptions;

  factory GetLeaderScheduleOptions.fromJson(Map<String, dynamic> data) =>
      _$GetLeaderScheduleOptionsFromJson(data);
}

/// Configuration object for [RPCClient.getLargestAccounts()]
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class GetLargestAccountsOptions with _$GetLargestAccountsOptions {
  /// - [commitment] @help/commitment
  /// - [filter] filter results by account type; currently
  /// supported: circulating|nonCirculating
  const factory GetLargestAccountsOptions({
    Commitment? commitment,
    CirculationStatus? filter,
  }) = _GetLargestAccountsOptions;

  factory GetLargestAccountsOptions.fromJson(Map<String, dynamic> data) =>
      _$GetLargestAccountsOptionsFromJson(data);
}

/// Configuration object for [RPCClient.getBlockProduction()]
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class GetBlockProductionOptions with _$GetBlockProductionOptions {
  /// - [commitment] @help/commitment
  /// - [range] Slot range to return block production for. If
  /// parameter not provided, defaults to current epoch.
  /// - [identity] Only return results for this validator
  /// identity (base-58 encoded)
  const factory GetBlockProductionOptions({
    Commitment? commitment,
    Range? range,
    String? identity,
  }) = _GetBlockProductionOptions;

  factory GetBlockProductionOptions.fromJson(Map<String, dynamic> data) =>
      _$GetBlockProductionOptionsFromJson(data);
}

/// Configuration object for [RPCClient.getBlock()]
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class GetBlockOptions with _$GetBlockOptions {
  /// - [encoding] @help/encoding
  /// - [transactionDetails] Level of transaction detail to
  /// return.
  /// - [rewards] Whether to populate the rewards array. If
  /// parameter not provided, the default includes rewards.
  /// - [commitment] @help/commitment
  const factory GetBlockOptions({
    Encoding? encoding,
    TransactionDetailLevel? transactionDetails,
    bool? rewards,
    Commitment? commitment,
  }) = _GetBlockOptions;

  factory GetBlockOptions.fromJson(Map<String, dynamic> data) =>
      _$GetBlockOptionsFromJson(data);
}

/// Configuration object for getting account information
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class GetAccountInfoOptions with _$GetAccountInfoOptions {
  /// - [commitment] @help/commitment
  /// - [encoding] @help/encoding
  /// - [dataSlice] Limit the returned account data using the
  /// provided offset: <usize> and length: <usize> fields; only
  /// available for "base58""base64" or "base64+zstd" encodings.
  const factory GetAccountInfoOptions({
    Commitment? commitment,
    Encoding? encoding,
    DataSlice? dataSlice,
  }) = _GetAccountInfoOptions;

  factory GetAccountInfoOptions.fromJson(Map<String, dynamic> data) =>
      _$GetAccountInfoOptionsFromJson(data);
}

/// Either a mint or a program id
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class MintOrProgramId with _$MintOrProgramId {
  /// - [mint] Pubkey of the specific token Mint to limit
  /// accounts to, as base-58 encoded string; or
  /// - [programId] Pubkey of the Token program ID that owns the
  /// accounts, as base-58 encoded string
  const factory MintOrProgramId({
    String? mint,
    String? programId,
  }) = _MintOrProgramId;

  factory MintOrProgramId.fromJson(Map<String, dynamic> data) =>
      _$MintOrProgramIdFromJson(data);
}

/// Data slice to limit the account data in a response
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class DataSlice with _$DataSlice {
  /// - [offset] Start index for the data slice
  /// - [length] Length of the data slice
  const factory DataSlice({
    int? offset,
    int? length,
  }) = _DataSlice;

  factory DataSlice.fromJson(Map<String, dynamic> data) =>
      _$DataSliceFromJson(data);
}

/// Configuration of the commitment for some methods
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class CommitmentObject with _$CommitmentObject {
  /// - [commitment] @help/commitment
  const factory CommitmentObject({
    required Commitment commitment,
  }) = _CommitmentObject;

  factory CommitmentObject.fromJson(Map<String, dynamic> data) =>
      _$CommitmentObjectFromJson(data);
}

/// An account
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class Account with _$Account {
  /// - [lamports] Number of lamports assigned to this account,
  /// as a u64
  /// - [owner] base-58 encoded Pubkey of the program this
  /// account has been assigned to
  /// - [data] Data associated with the account, either as
  /// encoded binary data or JSON format {<program>: <state>},
  /// depending on encoding parameter
  /// - [executable] Boolean indicating if the account contains a
  /// program (and is strictly read-only)
  /// - [rentEpoch] The epoch at which this account will next owe
  /// rent, as u64
  const factory Account({
    required int lamports,
    required String owner,
    @AccountDataConverter() required AccountData? data,
    required bool executable,
    required int rentEpoch,
  }) = _Account;

  factory Account.fromJson(Map<String, dynamic> data) =>
      _$AccountFromJson(data);
}

/// A block
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class Block with _$Block {
  /// - [blockhash] The blockhash of this block, as base-58
  /// encoded string
  /// - [previousBlockhash] The blockhash of this block's parent,
  /// as base-58 encoded string; if the parent block is not
  /// available due to ledger cleanup, this field will return
  /// "11111111111111111111111111111111"
  /// - [parentSlot] The slot index of this block's parent
  /// - [transactions] Present if [TransactionDetailLevel.full]
  /// transaction details are requested; an array of
  /// [Transaction] objects
  /// - [meta] Transaction status metadata object
  /// - [signatures] Present if
  /// [TransactionDetailLevel.signatures] are requested for
  /// transaction details; an array of signatures strings,
  /// corresponding to the transaction order in the block.
  /// - [rewards] Present if rewards are requested; an array of
  /// [Reward] objects.
  /// - [blockTime] Estimated production time, as Unix timestamp
  /// (seconds since the Unix epoch). None if not available.
  /// - [blockHeight] The number of blocks beneath this block
  const factory Block({
    required String blockhash,
    required String previousBlockhash,
    required int parentSlot,
    required List<Transaction> transactions,
    required Meta? meta,
    required List<String> signatures,
    required List<Reward> rewards,
    required int? blockTime,
    required int? blockHeight,
  }) = _Block;

  factory Block.fromJson(Map<String, dynamic> data) => _$BlockFromJson(data);
}

/// Transaction state metadata
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class Meta with _$Meta {
  /// - [err] @help/errors
  /// - [fee] Fee this transaction was charged, as u64 integer.
  /// - [preBalances] Array of u64 account balances from before
  /// the transaction was processed.
  /// - [postBalances] Array of u64 account balances after the
  /// transaction was processed.
  /// - [innerInstructions] List of inner instructions or omitted
  /// if inner instruction recording was not yet enabled during
  /// this transaction.
  /// - [preTokenBalances] List of token balances from before the
  /// transaction was processed or omitted if token balance
  /// recording was not yet enabled during this transaction.
  /// - [postTokenBalances] List of token balances from after the
  /// transaction was processed or omitted if token balance
  /// recording was not yet enabled during this transaction.
  /// - [logMessages] Array of string log messages or omitted if
  /// log message recording was not yet enabled during this
  /// transaction.
  const factory Meta({
    required Map<String, dynamic>? err,
    required int fee,
    required List<int> preBalances,
    required List<int> postBalances,
    required List<InnerInstruction> innerInstructions,
    required List<TokenBalance> preTokenBalances,
    required List<TokenBalance> postTokenBalances,
    required List<String> logMessages,
  }) = _Meta;

  factory Meta.fromJson(Map<String, dynamic> data) => _$MetaFromJson(data);
}

/// A reward
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class Reward with _$Reward {
  /// - [pubkey] The public key, as base-58 encoded string, of
  /// the account that received the reward.
  /// - [lamports] Number of reward lamports credited or debited
  /// by the account, as a i64.
  /// - [postBalance] Account balance in lamports after the
  /// reward was applied.
  /// - [rewardType] Type of reward
  /// - [commission] vote account commission when the reward was
  /// credited, only present for voting and staking rewards
  const factory Reward({
    required String pubkey,
    required int lamports,
    required int postBalance,
    required RewardType rewardType,
    required int commission,
  }) = _Reward;

  factory Reward.fromJson(Map<String, dynamic> data) => _$RewardFromJson(data);
}

/// The header of a transaction message
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class TransactionMessageHeader with _$TransactionMessageHeader {
  /// - [numRequiredSignatures] The total number of signatures
  /// required to make the transaction valid. The signatures must
  /// match the first numRequiredSignatures of
  /// message.account_keys.
  /// - [numReadonlySignedAccounts] The last
  /// numReadonlySignedAccounts of the signed keys are read-only
  /// accounts. Programs may process multiple transactions that
  /// load read-only accounts within a single PoH entry, but are
  /// not permitted to credit or debit lamports or modify account
  /// data. Transactions targeting the same read-write account
  /// are evaluated sequentially.
  /// - [numReadonlyUnsignedAccounts] The last
  /// numReadonlyUnsignedAccounts of the unsigned keys are
  /// read-only accounts.
  const factory TransactionMessageHeader({
    required int numRequiredSignatures,
    required int numReadonlySignedAccounts,
    required int numReadonlyUnsignedAccounts,
  }) = _TransactionMessageHeader;

  factory TransactionMessageHeader.fromJson(Map<String, dynamic> data) =>
      _$TransactionMessageHeaderFromJson(data);
}

/// A transaction message
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class TransactionMessage with _$TransactionMessage {
  /// - [accountKeys] List of base-58 encoded public keys used by
  /// the transaction, including by the instructions and for
  /// signatures. The first message.header.numRequiredSignatures
  /// public keys must sign the transaction.
  /// - [header] Details the account types and signatures
  /// required by the transaction.
  /// - [recentBlockhash] A base-58 encoded hash of a recent
  /// block in the ledger used to prevent transaction duplication
  /// and to give transactions lifetimes.
  /// - [instructions] List of program instructions that will be
  /// executed in sequence and committed in one atomic
  /// transaction if all succeed.
  const factory TransactionMessage({
    required List<String> accountKeys,
    required TransactionMessageHeader header,
    required String recentBlockhash,
    required List<Instruction> instructions,
  }) = _TransactionMessage;

  factory TransactionMessage.fromJson(Map<String, dynamic> data) =>
      _$TransactionMessageFromJson(data);
}

/// A transaction
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class Transaction with _$Transaction {
  /// - [signatures] A list of base-58 encoded signatures applied
  /// to the transaction. The list is always of length
  /// message.header.numRequiredSignatures and not empty. The
  /// signature at index i corresponds to the public key at index
  /// i in message.account_keys. The first one is used as the
  /// transaction id.
  /// - [message] Defines the content of the transaction.
  const factory Transaction({
    required List<String> signatures,
    required TransactionMessage message,
  }) = _Transaction;

  factory Transaction.fromJson(Map<String, dynamic> data) =>
      _$TransactionFromJson(data);
}

/// Details of a transaction
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class TransactionDetails with _$TransactionDetails {
  /// - [slot] the slot this transaction was processed in
  /// - [transaction] Transaction object, either in JSON format
  /// or encoded binary data, depending on encoding parameter
  /// - [blockTime]
  /// - [meta] transaction status metadata
  const factory TransactionDetails({
    required int slot,
    required Transaction transaction,
    required int? blockTime,
    required Meta meta,
  }) = _TransactionDetails;

  factory TransactionDetails.fromJson(Map<String, dynamic> data) =>
      _$TransactionDetailsFromJson(data);
}

/// List of inner instructions or omitted if inner instruction
/// recording was not yet enabled during this transaction
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class InnerInstruction with _$InnerInstruction {
  /// - [index] Index of the transaction instruction from which
  /// the inner instruction(s) originated
  /// - [instruction] Ordered list of inner program instructions
  /// that were invoked during a single transaction instruction.
  const factory InnerInstruction({
    required int index,
    required List<Instruction> instruction,
  }) = _InnerInstruction;

  factory InnerInstruction.fromJson(Map<String, dynamic> data) =>
      _$InnerInstructionFromJson(data);
}

/// An instruction in a transaction
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class Instruction with _$Instruction {
  /// - [programIdIndex] Index into the message.accountKeys array
  /// indicating the program account that executes this
  /// instruction.
  /// - [accounts] List of ordered indices into the
  /// message.accountKeys array indicating which accounts to pass
  /// to the program.
  /// - [data] The program input data encoded in a base-58 string.
  const factory Instruction({
    required int programIdIndex,
    required List<int> accounts,
    required String data,
  }) = _Instruction;

  factory Instruction.fromJson(Map<String, dynamic> data) =>
      _$InstructionFromJson(data);
}

/// The amount of a SPL token
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class TokenAmount with _$TokenAmount {
  /// - [amount] Raw amount of tokens as a string, ignoring
  /// decimals.
  /// - [decimals] Number of decimals configured for token's mint.
  /// - [uiAmountString] Token amount as a string, accounting for
  /// decimals.
  const factory TokenAmount({
    required String amount,
    required int decimals,
    required String? uiAmountString,
  }) = _TokenAmount;

  factory TokenAmount.fromJson(Map<String, dynamic> data) =>
      _$TokenAmountFromJson(data);
}

/// The balance of a SPL token account
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class TokenBalance with _$TokenBalance {
  /// - [accountIndex] Index of the account in which the token
  /// balance is provided for.
  /// - [mint] Pubkey of the token's mint.
  /// - [uiTokenAmount] Token balance
  const factory TokenBalance({
    required int accountIndex,
    required String mint,
    required TokenAmount uiTokenAmount,
  }) = _TokenBalance;

  factory TokenBalance.fromJson(Map<String, dynamic> data) =>
      _$TokenBalanceFromJson(data);
}

/// A node of a cluster
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class ClusterNode with _$ClusterNode {
  /// - [pubkey] Node public key, as base-58 encoded string
  /// - [gossip] Gossip network address for the node
  /// - [tpu] TPU network address for the node
  /// - [rpc] JSON RPC network address for the node, or null if
  /// the JSON RPC service is not enabled
  /// - [version] The software version of the node, or null if
  /// the version information is not available
  /// - [featureSet] The unique identifier of the node's feature
  /// set
  /// - [shredVersion] The shred version the node has been
  /// configured to use
  const factory ClusterNode({
    required String pubkey,
    required String gossip,
    required String tpu,
    required String? rpc,
    required String? version,
    required int? featureSet,
    required int? shredVersion,
  }) = _ClusterNode;

  factory ClusterNode.fromJson(Map<String, dynamic> data) =>
      _$ClusterNodeFromJson(data);
}

/// Information about an epoch
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class EpochInfo with _$EpochInfo {
  /// - [absoluteSlot] The current slot
  /// - [blockHeight] The current block height
  /// - [epoch] The current epoch
  /// - [slotIndex] The current slot relative to the start of the
  /// current epoch
  /// - [slotsInEpoch] The number of slots in this epoch
  const factory EpochInfo({
    required int absoluteSlot,
    required int blockHeight,
    required int epoch,
    required int slotIndex,
    required int slotsInEpoch,
  }) = _EpochInfo;

  factory EpochInfo.fromJson(Map<String, dynamic> data) =>
      _$EpochInfoFromJson(data);
}

/// A fee calculator
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class FeeCalculator with _$FeeCalculator {
  /// - [lamportsPerSignature] number of lamports per signature
  /// in a transaction
  const factory FeeCalculator({
    required int lamportsPerSignature,
  }) = _FeeCalculator;

  factory FeeCalculator.fromJson(Map<String, dynamic> data) =>
      _$FeeCalculatorFromJson(data);
}

/// A range of bytes
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class Range with _$Range {
  /// - [firstSlot] first slot of the block production
  /// information (inclusive)
  /// - [lastSlot] last slot of block production information
  /// (inclusive)
  const factory Range({
    required int firstSlot,
    required int lastSlot,
  }) = _Range;

  factory Range.fromJson(Map<String, dynamic> data) => _$RangeFromJson(data);
}

/// A block production
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class BlockProduction with _$BlockProduction {
  /// - [byIdentity] A dictionary of validator identities, as
  /// base-58 encoded strings. Value is a two element array
  /// containing the number of leader slots and the number of
  /// blocks produced.
  /// - [range] Block production slot range
  const factory BlockProduction({
    required Map<String, ByIdentityValue> byIdentity,
    required Range range,
  }) = _BlockProduction;

  factory BlockProduction.fromJson(Map<String, dynamic> data) =>
      _$BlockProductionFromJson(data);
}

/// The commitment of a bloc
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class BlockCommitment with _$BlockCommitment {
  /// - [commitment] Commitment, array of u64 integers logging
  /// the amount of cluster stake in lamports that has voted on
  /// the block at each depth from 0 to MAX_LOCKOUT_HISTORY + 1.
  /// - [totalStake] Total active stake, in lamports, of the
  /// current epoch.
  const factory BlockCommitment({
    required List<int>? commitment,
    required int totalStake,
  }) = _BlockCommitment;

  factory BlockCommitment.fromJson(Map<String, dynamic> data) =>
      _$BlockCommitmentFromJson(data);
}

/// An epoch schedule
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class EpochSchedule with _$EpochSchedule {
  /// - [slotsPerEpoch] The maximum number of slots in each epoch.
  /// - [leaderScheduleSlotOffset] The number of slots before
  /// beginning of an epoch to calculate a leader schedule for
  /// that epoch.
  /// - [warmup] Whether epochs start short and grow.
  /// - [firstNormalEpoch] First normal-length epoch,
  /// log2(slotsPerEpoch) - log2(MINIMUM_SLOTS_PER_EPOCH).
  /// - [firstNormalSlot] MINIMUM_SLOTS_PER_EPOCH *
  /// (2.pow(firstNormalEpoch) - 1).
  const factory EpochSchedule({
    required int slotsPerEpoch,
    required int leaderScheduleSlotOffset,
    required bool warmup,
    required int firstNormalEpoch,
    required int firstNormalSlot,
  }) = _EpochSchedule;

  factory EpochSchedule.fromJson(Map<String, dynamic> data) =>
      _$EpochScheduleFromJson(data);
}

/// The value of a fee rate governor
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class FeeRateGovernorValue with _$FeeRateGovernorValue {
  /// - [burnPercent] Percentage of fees collected to be
  /// destroyed.
  /// - [maxLamportsPerSignature] Largest value
  /// lamportsPerSignature can attain for the next slot.
  /// - [minLamportsPerSignature] Smallest value
  /// lamportsPerSignature can attain for the next slot.
  /// - [targetLamportsPerSignature] Desired fee rate for the
  /// cluster.
  /// - [targetSignaturesPerSlot] Desired signature rate for the
  /// cluster.
  const factory FeeRateGovernorValue({
    required int burnPercent,
    required int maxLamportsPerSignature,
    required int minLamportsPerSignature,
    required int targetLamportsPerSignature,
    required int targetSignaturesPerSlot,
  }) = _FeeRateGovernorValue;

  factory FeeRateGovernorValue.fromJson(Map<String, dynamic> data) =>
      _$FeeRateGovernorValueFromJson(data);
}

/// A fee rate governor
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class FeeRateGovernor with _$FeeRateGovernor {
  /// - [feeRateGovernor] Fee rate governor
  const factory FeeRateGovernor({
    required FeeRateGovernorValue feeRateGovernor,
  }) = _FeeRateGovernor;

  factory FeeRateGovernor.fromJson(Map<String, dynamic> data) =>
      _$FeeRateGovernorFromJson(data);
}

/// A fee description object
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class Fees with _$Fees {
  /// - [blockhash] Hash as base-58 encoded string
  /// - [feeCalculator] [FeeCalculator] object, the fee schedule
  /// for this block hash
  /// - [lastValidBlockHeight] Last block height at which a
  /// [blockhash] will be valid
  const factory Fees({
    required String blockhash,
    required FeeCalculator feeCalculator,
    required int lastValidBlockHeight,
  }) = _Fees;

  factory Fees.fromJson(Map<String, dynamic> data) => _$FeesFromJson(data);
}

/// An identity (or a public key)
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class Identity with _$Identity {
  /// - [identity] the identity pubkey of the current node (as a
  /// base-58 encoded string)
  const factory Identity({
    required String identity,
  }) = _Identity;

  factory Identity.fromJson(Map<String, dynamic> data) =>
      _$IdentityFromJson(data);
}

/// An inflation governor
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class InflationGovernor with _$InflationGovernor {
  /// - [initial] The initial inflation percentage from time 0.
  /// - [terminal] Terminal inflation percentage.
  /// - [taper] Rate per year at which inflation is
  /// lowered.\nRate reduction is derived using the target slot
  /// time in genesis config.
  /// - [foundation] Percentage of total inflation allocated to
  /// the foundation.
  /// - [foundationTerm] Duration of foundation pool inflation in
  /// years.
  const factory InflationGovernor({
    required double initial,
    required double terminal,
    required double taper,
    required double foundation,
    required double foundationTerm,
  }) = _InflationGovernor;

  factory InflationGovernor.fromJson(Map<String, dynamic> data) =>
      _$InflationGovernorFromJson(data);
}

/// An inflation rate
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class InflationRate with _$InflationRate {
  /// - [total] Total inflation.
  /// - [validator] Inflation allocated to validators.
  /// - [foundation] Inflation allocated to the foundation.
  /// - [epoch] Epoch for which these values are valid.
  const factory InflationRate({
    required double total,
    required double validator,
    required double foundation,
    required double epoch,
  }) = _InflationRate;

  factory InflationRate.fromJson(Map<String, dynamic> data) =>
      _$InflationRateFromJson(data);
}

/// An inflation reward
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class InflationReward with _$InflationReward {
  /// - [epoch] Epoch for which reward occurred.
  /// - [effectiveSlot] The slot in which the rewards are
  /// effective.
  /// - [amount] Reward amount in lamports.
  /// - [postBalance] Post balance of the account in lamports.
  /// - [commission] Vote account commission when the reward was
  /// credited.
  const factory InflationReward({
    required int epoch,
    required int effectiveSlot,
    required int amount,
    required int postBalance,
    required int commission,
  }) = _InflationReward;

  factory InflationReward.fromJson(Map<String, dynamic> data) =>
      _$InflationRewardFromJson(data);
}

/// A large account
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class LargeAccount with _$LargeAccount {
  /// - [address] base-58 encoded address of the account
  /// - [lamports] Number of lamports in the account, as a u64
  const factory LargeAccount({
    required String address,
    required int lamports,
  }) = _LargeAccount;

  factory LargeAccount.fromJson(Map<String, dynamic> data) =>
      _$LargeAccountFromJson(data);
}

/// A parameters object for a filter of program data
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class FilterParams with _$FilterParams {
  /// - [offset] Offset into program account data to start
  /// comparison.
  /// - [bytes] Data to match, as base-58 encoded string and
  /// limited to less than 129 bytes.
  const factory FilterParams({
    required int offset,
    required String bytes,
  }) = _FilterParams;

  factory FilterParams.fromJson(Map<String, dynamic> data) =>
      _$FilterParamsFromJson(data);
}

/// A filter of program data
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class Filter with _$Filter {
  /// - [memcmp] Compares a provided series of bytes with program
  /// account data at a particular offset.
  /// - [dataSize] Compares the program account data length with
  /// the provided data size.
  const factory Filter({
    required FilterParams memcmp,
    required int dataSize,
  }) = _Filter;

  factory Filter.fromJson(Map<String, dynamic> data) => _$FilterFromJson(data);
}

/// A program account
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class ProgramAccount with _$ProgramAccount {
  /// - [account] The account information for this program
  /// account.
  /// - [pubkey] The account Pubkey as base-58 encoded string.
  const factory ProgramAccount({
    required Account account,
    required String pubkey,
  }) = _ProgramAccount;

  factory ProgramAccount.fromJson(Map<String, dynamic> data) =>
      _$ProgramAccountFromJson(data);
}

/// A recent blockhash
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class RecentBlockhash with _$RecentBlockhash {
  /// - [blockhash] Hash as base-58 encoded string
  /// - [feeCalculator] [FeeCalculator] object, the fee schedule
  /// for this block hash
  const factory RecentBlockhash({
    required String blockhash,
    required FeeCalculator feeCalculator,
  }) = _RecentBlockhash;

  factory RecentBlockhash.fromJson(Map<String, dynamic> data) =>
      _$RecentBlockhashFromJson(data);
}

/// A performance sample
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class PerfSample with _$PerfSample {
  /// - [slot] Slot in which sample was taken at.
  /// - [numTransactions] Number of transactions in sample.
  /// - [numSlots] Number of slots in sample.
  /// - [samplePeriodSec] Number of seconds in a sample window.
  const factory PerfSample({
    required int slot,
    required int numTransactions,
    required int numSlots,
    required int samplePeriodSec,
  }) = _PerfSample;

  factory PerfSample.fromJson(Map<String, dynamic> data) =>
      _$PerfSampleFromJson(data);
}

/// The information of a transaction signature
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class TransactionSignatureInformation with _$TransactionSignatureInformation {
  /// - [signature] Transaction signature as base-58 encoded
  /// string.
  /// - [slot] The slot that contains the block with the
  /// transaction.
  /// - [err] @help/errors
  /// - [memo] Memo associated with the transaction, null if no
  /// memo is present.
  /// - [blockTime] Estimated production time, as Unix timestamp
  /// (seconds since the Unix epoch) of when transaction was
  /// processed. null if not available.
  const factory TransactionSignatureInformation({
    required String signature,
    required int slot,
    required Map<String, dynamic>? err,
    required String? memo,
    required int? blockTime,
  }) = _TransactionSignatureInformation;

  factory TransactionSignatureInformation.fromJson(Map<String, dynamic> data) =>
      _$TransactionSignatureInformationFromJson(data);
}

/// The status of a signature
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class SignatureStatus with _$SignatureStatus {
  /// - [slot] The slot the transaction was processed.
  /// - [confirmations] Number of blocks since signature
  /// confirmation, null if rooted, as well as finalized.
  /// - [err] @help/errors
  /// - [confirmationStatus] The transaction's cluster
  /// confirmation status; either [Commitment.processed],
  /// [Commitment.confirmed], or [Commitment.finalized]. See
  /// [Commitment](@help/commitment/link) for more on optimistic
  /// confirmation.
  const factory SignatureStatus({
    required int slot,
    required int? confirmations,
    required Map<String, dynamic>? err,
    required ConfirmationStatus confirmationStatus,
  }) = _SignatureStatus;

  factory SignatureStatus.fromJson(Map<String, dynamic> data) =>
      _$SignatureStatusFromJson(data);
}

/// A stake activation description
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class StakeActivation with _$StakeActivation {
  /// - [state] Stake account's activation state
  /// - [active] Stake active during the epoch.
  /// - [inactive] Stake inactive during the epoch.
  const factory StakeActivation({
    required StakeActivationState state,
    required int active,
    required int inactive,
  }) = _StakeActivation;

  factory StakeActivation.fromJson(Map<String, dynamic> data) =>
      _$StakeActivationFromJson(data);
}

/// The total supply of tokens
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class Supply with _$Supply {
  /// - [total] Total supply in lamports.
  /// - [circulating] Circulating supply in lamports.
  /// - [nonCirculating] Non-circulating supply in lamports.
  /// - [nonCirculatingAccounts] An array of account addresses of
  /// non-circulating accounts, as strings. If
  /// [excludeNonCirculatingAccountsList] is enabled, the
  /// returned array will be empty.
  const factory Supply({
    required int total,
    required int circulating,
    required int nonCirculating,
    required List<String> nonCirculatingAccounts,
  }) = _Supply;

  factory Supply.fromJson(Map<String, dynamic> data) => _$SupplyFromJson(data);
}

/// The solana version
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class SolanaVersion with _$SolanaVersion {
  /// - [solanaCore] Software version of solana-core.
  /// - [featureSet] Unique identifier of current feature set.
  const factory SolanaVersion({
    @JsonKey(name: 'solana-core') required String solanaCore,
    @JsonKey(name: 'feature-set') required int featureSet,
  }) = _SolanaVersion;

  factory SolanaVersion.fromJson(Map<String, dynamic> data) =>
      _$SolanaVersionFromJson(data);
}

/// A list of vote accounts
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class VoteAccounts with _$VoteAccounts {
  /// - [votePubkey] Vote account address, as base-58 encoded
  /// string.
  /// - [nodePubkey] Validator identity, as base-58 encoded
  /// string.
  /// - [activatedStake] The stake, in lamports, delegated to
  /// this vote account and active in this epoch.
  /// - [epochVoteAccount] Bool, whether the vote account is
  /// staked for this epoch.
  /// - [commission] Percentage (0-100) of rewards payout owed to
  /// the vote account.
  /// - [lastVote] Most recent slot voted on by this vote account.
  /// - [epochCredits] History of how many credits earned by the
  /// end of each epoch, as an array of arrays containing:
  /// [epoch, credits, previousCredits].
  const factory VoteAccounts({
    required String votePubkey,
    required String nodePubkey,
    required int activatedStake,
    required bool epochVoteAccount,
    required int commission,
    required int lastVote,
    required List<int> epochCredits,
  }) = _VoteAccounts;

  factory VoteAccounts.fromJson(Map<String, dynamic> data) =>
      _$VoteAccountsFromJson(data);
}

/// The status of a transaction
@freezed
@JsonSerializable(createFactory: false, includeIfNull: false)
class TransactionStatus with _$TransactionStatus {
  /// - [err] @help/errors
  /// - [logs] Array of log messages the transaction instructions
  /// output during execution, null if simulation failed before
  /// the transaction was able to execute (for example due to an
  /// invalid blockhash or signature verification failure).
  /// - [accounts] Array of [Account]s with the same length as
  /// the [SimulateTransactionAccounts.addresses] array in the
  /// request
  const factory TransactionStatus({
    required Map<String, dynamic>? err,
    required List<String>? logs,
    required List<Account>? accounts,
  }) = _TransactionStatus;

  factory TransactionStatus.fromJson(Map<String, dynamic> data) =>
      _$TransactionStatusFromJson(data);
}
