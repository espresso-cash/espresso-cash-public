import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/src/dto/account_data.dart';
import 'package:solana/src/parsed_message/parsed_message.dart';

export 'rpc_types_extension.dart';

part 'rpc_types.freezed.dart';
part 'rpc_types.g.dart';

enum TransactionDetailLevel {
  full,
  signatures,
  none,
}

enum CirculationStatus {
  circulating,
  nonCirculating,
}

/// Encoding used by methods to send their response
/// either "base58" (slow), "base64",  "base64+zstd", or "jsonParsed".
/// "base58" is limited to Account data of
/// less than 129 bytes. "base64" will return base64 encoded data for
/// Account data of any size. "base64+zstd" compresses the Account data
/// using Zstandard and base64-encodes the result. "jsonParsed" encoding
/// attempts to use program-specific state parsers to return more
/// human-readable and explicit account state data. If "jsonParsed" is
/// requested but a parser cannot be found, the field falls back to "base64"
/// encoding, detectable when the
///
/// Currently we are not supporting compressed encodings or base58. The latter
/// is deprecated
enum Encoding {
  base64,
  jsonParsed,
}

/// For preflight checks and transaction processing, Solana nodes choose
/// which bank state to query based on a commitment requirement set by the
/// client. The commitment describes how finalized a block is at that point in
/// time. When querying the ledger state, it's recommended to use
/// lower levels of commitment to report progress and higher levels to
/// ensure the state will not be rolled back.
///
/// In descending order of commitment (most finalized to least finalized),
/// clients may specify:
///
/// For processing many dependent transactions in series, it's recommended to
/// use "confirmed" commitment, which balances speed with rollback safety. For
/// total safety, it's recommended to use [Commitment.finalized] commitment.
enum Commitment {
  /// The node will query its most recent block. Note
  /// that the block may not be complete.
  processed,

  /// The node will query the most recent block that has been voted
  /// on by supermajority of the cluster.
  ///
  /// - It incorporates votes from gossip and replay.
  /// - It does not count votes on descendants of a block, only direct votes on
  /// that block.
  ///
  /// This confirmation level also upholds "optimistic confirmation" guarantees
  /// in release 1.3 and onwards.
  confirmed,

  /// The node will query the most recent block confirmed by
  /// supermajority of the cluster as having reached maximum lockout, meaning
  /// the cluster has recognized this block as finalized
  finalized,
}

/// Type of reward
enum RewardType {
  fee,
  rent,
  voting,
  staking,
}

/// The stake account's activation state
enum StakeActivationState {
  active,
  inactive,
  activating,
  deactivating,
}

/// A convenience type that is more semantic in some cases
///
/// It is more natural sometimes to say "status" but otherwise
/// the values are identical to those of [Commitment]
typedef TxStatus = Commitment;

/// Configuration object for [RPCClient.getConfirmedTransaction()].
@freezed
class GetConfirmedTransactionOptions with _$GetConfirmedTransactionOptions {
  /// [encoding] Encoding for the returned transactions
  ///
  /// For the [commitment] parameter see [Commitment][commitment link];
  /// [Commitment.processed] is not supported. If parameter not provided,
  /// the default is [Commitment.finalized].
  ///
  /// [commitment link]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  const factory GetConfirmedTransactionOptions({
    @JsonKey(includeIfNull: false) Encoding? encoding,
    @JsonKey(includeIfNull: false) Commitment? commitment,
  }) = _GetConfirmedTransactionOptions;

  factory GetConfirmedTransactionOptions.fromJson(Map<String, dynamic> data) =>
      _$GetConfirmedTransactionOptionsFromJson(data);
}

@freezed
class SimulateTransactionAccounts with _$SimulateTransactionAccounts {
  const factory SimulateTransactionAccounts({
    @JsonKey(includeIfNull: false) Encoding? accountEncoding,
    @JsonKey(includeIfNull: false) List<String>? addresses,
  }) = _SimulateTransactionAccounts;

  factory SimulateTransactionAccounts.fromJson(Map<String, dynamic> data) =>
      _$SimulateTransactionAccountsFromJson(data);
}

/// Configuration object for [RPCClient.simulateTransaction()].
@freezed
class SimulateTransactionOptions with _$SimulateTransactionOptions {
  /// [sigVerify] if true the transaction signatures will be verified
  /// (default: false, conflicts with [replaceRecentBlockhash])
  /// [replaceRecentBlockhash] if true the transaction recent blockhash will
  /// be replaced with the most recent blockhash.
  /// (default: false, conflicts with [sigVerify])
  /// [accounts] Accounts configuration object, see [SimulateTransactionAccounts]
  ///
  /// For the [commitment] parameter see [Commitment][commitment link];
  /// [Commitment.processed] is not supported. If parameter not provided,
  /// the default is [Commitment.finalized].
  ///
  /// [commitment link]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  const factory SimulateTransactionOptions({
    @JsonKey(includeIfNull: false) bool? sigVerify,
    @JsonKey(includeIfNull: false) Commitment? commitment,
    @JsonKey(includeIfNull: false) bool? replaceRecentBlockhash,
    @JsonKey(includeIfNull: false) SimulateTransactionAccounts? accounts,
  }) = _SimulateTransactionOptions;

  factory SimulateTransactionOptions.fromJson(Map<String, dynamic> data) =>
      _$SimulateTransactionOptionsFromJson(data);
}

/// Configuration object for [RPCClient.sendTransaction()].
@freezed
class SendTransactionOptions with _$SendTransactionOptions {
  /// [skipPreflight] if true, skip the preflight transaction checks (default: false)
  /// [maxRetries] Maximum number of times for the RPC node to retry sending the
  /// transaction to the leader. If this parameter not provided, the RPC node will
  /// retry the transaction until it is finalized or until the blockhash expires.
  /// [preflightCommitment] commitment level to use for preflight (default: [Commitment.finalized])
  ///
  /// For the [commitment] parameter see [Commitment][commitment link];
  /// [Commitment.processed] is not supported. If parameter not provided,
  /// the default is [Commitment.finalized].
  ///
  /// [commitment link]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  const factory SendTransactionOptions({
    @JsonKey(includeIfNull: false) Commitment? commitment,
    @JsonKey(includeIfNull: false) Commitment? preflightCommitment,
    @JsonKey(includeIfNull: false) bool? skipPreflight,
    @JsonKey(includeIfNull: false) int? maxRetries,
  }) = _SendTransactionOptions;

  factory SendTransactionOptions.fromJson(Map<String, dynamic> data) =>
      _$SendTransactionOptionsFromJson(data);
}

/// Configuration object for [RPCClient.getVoteAccounts()].
@freezed
class GetVoteAccountsOptions with _$GetVoteAccountsOptions {
  /// [votePubKey] Only return results for this validator vote address (base-58 encoded)
  /// [keepUnstakedDelinquents] Do not filter out delinquent validators with no stake
  /// [delinquentSlotDistance] Specify the number of slots behind the tip that a
  /// validator must fall to be considered delinquent.
  /// **NOTE**: For the sake of consistency between ecosystem products, it is not
  /// recommended that this argument be specified.
  ///
  /// For the [commitment] parameter see [Commitment][commitment link];
  /// [Commitment.processed] is not supported. If parameter not provided,
  /// the default is [Commitment.finalized].
  ///
  /// [commitment link]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  const factory GetVoteAccountsOptions({
    @JsonKey(includeIfNull: false) Commitment? commitment,
    @JsonKey(includeIfNull: false) String? votePubKey,
    @JsonKey(includeIfNull: false) bool? keepUnstakedDelinquents,
    @JsonKey(includeIfNull: false) int? delinquentSlotDistance,
  }) = _GetVoteAccountsOptions;

  factory GetVoteAccountsOptions.fromJson(Map<String, dynamic> data) =>
      _$GetVoteAccountsOptionsFromJson(data);
}

/// Configuration object for [RPCClient.getTransaction()].
///
/// NEW: This method is only available in solana-core v1.7 or newer. Please use
/// [RPCClient.getConfirmedTransaction()] for solana-core v1.6
@freezed
class GetTransactionOptions with _$GetTransactionOptions {
  /// [encoding] [Encoding] for each transaction
  ///
  /// For the [commitment] parameter see [Commitment][commitment link];
  /// [Commitment.processed] is not supported. If parameter not provided,
  /// the default is [Commitment.finalized].
  ///
  /// [commitment link]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  const factory GetTransactionOptions({
    @JsonKey(includeIfNull: false) Encoding? encoding,
    @JsonKey(includeIfNull: false) Commitment? commitment,
  }) = _GetTransactionOptions;

  factory GetTransactionOptions.fromJson(Map<String, dynamic> data) =>
      _$GetTransactionOptionsFromJson(data);
}

/// Union type to specify either [mint] or [programId]
@freezed
class MintOrProgramId with _$MintOrProgramId {
  const factory MintOrProgramId({
    @JsonKey(includeIfNull: false) String? mint,
    @JsonKey(includeIfNull: false) String? programId,
  }) = _MintOrProgramId;

  factory MintOrProgramId.fromJson(Map<String, dynamic> data) =>
      _$MintOrProgramIdFromJson(data);
}

/// Configuration object for [RPCClient.getSupply()].
@freezed
class GetSupplyOptions with _$GetSupplyOptions {
  /// [excludeNonCirculatingAccountsList] exclude non circulating accounts list from response
  ///
  /// For the [commitment] parameter see [Commitment][commitment link];
  /// [Commitment.processed] is not supported. If parameter not provided,
  /// the default is [Commitment.finalized].
  ///
  /// [commitment link]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  const factory GetSupplyOptions({
    @JsonKey(includeIfNull: false) Commitment? commitment,
    @JsonKey(includeIfNull: false) bool? excludeNonCirculatingAccountsList,
  }) = _GetSupplyOptions;

  factory GetSupplyOptions.fromJson(Map<String, dynamic> data) =>
      _$GetSupplyOptionsFromJson(data);
}

/// Configuration object for [RPCClient.getStakeActivation()].
@freezed
class GetStakeActivationOptions with _$GetStakeActivationOptions {
  /// [epoch] epoch for which to calculate activation details. If parameter not
  /// provided, defaults to current epoch.
  ///
  /// For the [commitment] parameter see [Commitment][commitment link];
  /// [Commitment.processed] is not supported. If parameter not provided,
  /// the default is [Commitment.finalized].
  ///
  /// [commitment link]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  const factory GetStakeActivationOptions({
    @JsonKey(includeIfNull: false) Commitment? commitment,
    @JsonKey(includeIfNull: false) int? epoch,
  }) = _GetStakeActivationOptions;

  factory GetStakeActivationOptions.fromJson(Map<String, dynamic> data) =>
      _$GetStakeActivationOptionsFromJson(data);
}

/// Configuration object for [RPCClient.getStakeActivation()].
@freezed
class GetSignatureStatusesOptions with _$GetSignatureStatusesOptions {
  /// [searchTransactionHistory] if true, a Solana node will search its ledger
  /// cache for any signatures not found in the recent status cache
  const factory GetSignatureStatusesOptions({
    @JsonKey(includeIfNull: false) bool? searchTransactionHistory,
  }) = _GetSignatureStatusesOptions;

  factory GetSignatureStatusesOptions.fromJson(Map<String, dynamic> data) =>
      _$GetSignatureStatusesOptionsFromJson(data);
}

/// Configuration object for [RPCClient.getSignaturesForAddress()].
///
/// NEW: This method is only available in solana-core v1.7 or newer. Please use
/// [RPCClient.getConfirmedSignaturesForAddress2()] for solana-core v1.6
@freezed
class GetSignaturesForAddressOptions with _$GetSignaturesForAddressOptions {
  /// [limit] maximum transaction signatures to return (between 1 and 1,000, default: 1,000).
  /// [before] start searching backwards from this transaction signature.
  /// If not provided the search starts from the top of the highest max
  /// confirmed block.
  /// [until] search until this transaction signature, if found before limit
  /// reached.
  ///
  /// For the [commitment] parameter see [Commitment][commitment link];
  /// [Commitment.processed] is not supported. If parameter not provided,
  /// the default is [Commitment.finalized].
  ///
  /// [commitment link]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  const factory GetSignaturesForAddressOptions({
    @JsonKey(includeIfNull: false) int? limit,
    @JsonKey(includeIfNull: false) String? before,
    @JsonKey(includeIfNull: false) String? until,
    @JsonKey(includeIfNull: false) Commitment? commitment,
  }) = _GetSignaturesForAddressOptions;

  factory GetSignaturesForAddressOptions.fromJson(Map<String, dynamic> data) =>
      _$GetSignaturesForAddressOptionsFromJson(data);
}

/// Configuration object of [RPCClient.getProgramAccounts()].
@freezed
class GetProgramAccountsOptions with _$GetProgramAccountsOptions {
  /// [encoding] encoding for Account data
  /// [dataSlice] limit the returned account data; see [DataSlice]
  /// [filter] filter results using various [filter objects][filter objects link];
  /// account must meet all filter criteria to be included in results
  ///
  /// For the [commitment] parameter see [Commitment][commitment link];
  /// [Commitment.processed] is not supported. If parameter not provided,
  /// the default is [Commitment.finalized].
  ///
  /// [commitment link]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  /// [filter objects link]: https://docs.solana.com/developing/clients/jsonrpc-api#filters
  const factory GetProgramAccountsOptions({
    @JsonKey(includeIfNull: false) Commitment? commitment,
    @JsonKey(includeIfNull: false) Encoding? encoding,
    @JsonKey(includeIfNull: false) DataSlice? dataSlice,
    @JsonKey(includeIfNull: false) List<Filter>? filter,
  }) = _GetProgramAccountsOptions;

  factory GetProgramAccountsOptions.fromJson(Map<String, dynamic> data) =>
      _$GetProgramAccountsOptionsFromJson(data);
}

/// Configuration object for [RPCClient.getLeaderSchedule()].
@freezed
class GetLeaderScheduleOptions with _$GetLeaderScheduleOptions {
  /// [identity] Only return results for this validator identity (base-58 encoded)
  ///
  /// For the [commitment] parameter see [Commitment][commitment link];
  /// [Commitment.processed] is not supported. If parameter not provided,
  /// the default is [Commitment.finalized].
  ///
  /// [commitment link]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  const factory GetLeaderScheduleOptions({
    @JsonKey(includeIfNull: false) Commitment? commitment,
    @JsonKey(includeIfNull: false) String? identity,
  }) = _GetLeaderScheduleOptions;

  factory GetLeaderScheduleOptions.fromJson(Map<String, dynamic> data) =>
      _$GetLeaderScheduleOptionsFromJson(data);
}

/// Configuration object for [RPCClient.getLargestAccounts()].
@freezed
class GetLargestAccountsOptions with _$GetLargestAccountsOptions {
  /// [filter] results by account type; currently supported:
  /// - [CirculationStatus.circulating]
  /// - [CirculationStatus.nonCirculating]
  ///
  /// For the [commitment] parameter see [Commitment][commitment link];
  /// [Commitment.processed] is not supported. If parameter not provided,
  /// the default is [Commitment.finalized].
  ///
  /// [commitment link]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  const factory GetLargestAccountsOptions({
    @JsonKey(includeIfNull: false) Commitment? commitment,
    @JsonKey(includeIfNull: false) CirculationStatus? filter,
  }) = _GetLargestAccountsOptions;

  factory GetLargestAccountsOptions.fromJson(Map<String, dynamic> data) =>
      _$GetLargestAccountsOptionsFromJson(data);
}

/// Configuration object for [RPCClient.getConfirmedSignaturesForAddress2()]
@freezed
class GetConfirmedSignaturesForAddress2Options
    with _$GetConfirmedSignaturesForAddress2Options {
  /// [limit] maximum transaction signatures to return (between 1 and 1,000, default: 1,000).
  /// [before] start searching backwards from this transaction signature.
  /// If not provided the search starts from the top of the highest max
  /// confirmed block.
  /// [until] search until this transaction signature, if found before limit
  /// reached.
  ///
  /// For the [commitment] parameter see [Commitment][commitment link];
  /// [Commitment.processed] is not supported. If parameter not provided,
  /// the default is [Commitment.finalized].
  ///
  /// [commitment link]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  const factory GetConfirmedSignaturesForAddress2Options({
    int? limit,
    String? before,
    String? until,
    Commitment? commitment,
  }) = _GetConfirmedSignaturesForAddress2Options;

  factory GetConfirmedSignaturesForAddress2Options.fromJson(
          Map<String, dynamic> data) =>
      _$GetConfirmedSignaturesForAddress2OptionsFromJson(data);
}

/// Configuration object for [RPCClient.getBlocProductionOptions()]
@freezed
class GetBlockProductionOptions with _$GetBlockProductionOptions {
  /// [range] Slot range to return block production for. If parameter not
  /// provided, defaults to current epoch; see [Range] for details.
  /// [identity] Only return results for this validator identity (base-58 encoded)
  ///
  /// For the [commitment] parameter see [Commitment][commitment link];
  /// [Commitment.processed] is not supported. If parameter not provided,
  /// the default is [Commitment.finalized].
  ///
  /// [commitment link]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  const factory GetBlockProductionOptions({
    @JsonKey(includeIfNull: false) Commitment? commitment,
    @JsonKey(includeIfNull: false) Range? range,
    @JsonKey(includeIfNull: false) String? identity,
  }) = _GetBlockProductionOptions;

  factory GetBlockProductionOptions.fromJson(Map<String, dynamic> data) =>
      _$GetBlockProductionOptionsFromJson(data);
}

/// Configuration object for [RPCClient.getBlock()]
@freezed
class GetBlockOptions with _$GetBlockOptions {
  /// [encoding] for each return transaction
  /// [transactionDetails]  level of transaction detail to return, either "full",
  /// "signatures", or "none". If parameter not provided, the default detail level is "full".
  /// [rewards] whether to populate the rewards array. If parameter not provided,
  /// the default includes rewards.
  const factory GetBlockOptions({
    @JsonKey(includeIfNull: false) Encoding? encoding,
    @JsonKey(includeIfNull: false) TransactionDetailLevel? transactionDetails,
    @JsonKey(includeIfNull: false) bool? rewards,
    @JsonKey(includeIfNull: false) Commitment? commitment,
  }) = _GetBlockOptions;

  factory GetBlockOptions.fromJson(Map<String, dynamic> data) =>
      _$GetBlockOptionsFromJson(data);
}

/// Configuration object used to retrieve account information.
///
/// This object is used in different methods
@freezed
class GetAccountInfoOptions with _$GetAccountInfoOptions {
  /// [encoding] encoding for Account data
  /// [dataSlice] limit the returned account data; See [DataSlice].
  /// only available for "base58", "base64" or "base64+zstd" encodings.
  const factory GetAccountInfoOptions({
    @JsonKey(includeIfNull: false) Commitment? commitment,
    @JsonKey(includeIfNull: false) Encoding? encoding,
    @JsonKey(includeIfNull: false) DataSlice? dataSlice,
  }) = _GetAccountOptions;

  factory GetAccountInfoOptions.fromJson(Map<String, dynamic> data) =>
      _$GetAccountInfoOptionsFromJson(data);
}

/// Limit the returned account data
///
/// **NOTE**: used with [GetAccountInfoOptions]
@freezed
class DataSlice with _$DataSlice {
  const factory DataSlice({
    @JsonKey(includeIfNull: false) int? offset,
    @JsonKey(includeIfNull: false) int? length,
  }) = _DataSlice;

  factory DataSlice.fromJson(Map<String, dynamic> data) =>
      _$DataSliceFromJson(data);
}

/// An object that is used to set the commitment value in some RPC methods
@freezed
class CommitmentObject with _$CommitmentObject {
  /// For the [commitment] parameter see [Commitment][commitment link];
  /// [Commitment.processed] is not supported. If parameter not provided,
  /// the default is [Commitment.finalized].
  ///
  /// [commitment link]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  const factory CommitmentObject({
    @JsonKey(includeIfNull: false) Commitment? commitment,
  }) = _CommitmentObject;

  factory CommitmentObject.fromJson(Map<String, dynamic> data) =>
      _$CommitmentObjectFromJson(data);
}

/// An account
@freezed
class Account with _$Account {
  /// [lamports] the number of lamports in balance
  /// [owner] public key of the owner
  /// [data] the data stored in it
  /// [executable] whether it is executable account
  /// [rentEpoch] the epoch at which will next owe rent
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

/// A block object
@freezed
class Block with _$Block {
  /// [blockhash] the blockhash of this block, as base-58 encoded string
  /// [previousBlockhash] the blockhash of this block's parent, as base-58
  /// encoded string; if the parent block is not available due to ledger
  /// cleanup, this field will return "11111111111111111111111111111111"
  /// [parentSlot] the slot index of this block's parent
  /// [transactions] present if "full" transaction details are requested;
  /// an array of [Transaction]
  /// [signatures] present if "signatures" are requested for transaction
  /// details; an array of signatures strings, corresponding to the transaction
  /// order in the block
  /// [rewards] present if rewards are requested; an array of [Reward]
  /// [blockTime] estimated production time, as Unix timestamp
  /// (seconds since the Unix epoch). null if not available
  /// [blockHeight] the number of blocks beneath this block
  const factory Block({
    required String blockhash,
    required String previousBlockhash,
    required int parentSlot,
    required List<Transaction> transactions,
    required List<String> signatures,
    required List<Reward> rewards,
    required int? blockTime,
    required int? blockHeight,
  }) = _Block;

  factory Block.fromJson(Map<String, dynamic> data) => _$BlockFromJson(data);
}

/// Transaction status metadata
@freezed
class Meta with _$Meta {
  /// [err]  Error if transaction failed, null if transaction succeeded;
  /// See [TransactionError definitions][errors link].
  /// [fee] fee this transaction was charged.
  /// [preBalances] array of account balances before the transaction was processed
  /// [postBalances] array of account balances after the transaction was processed
  /// [innerInstructions] List of [inner instructions][inner instructions link]
  /// or omitted if inner instruction recording was not yet enabled during this
  /// transaction.
  /// [preTokenBalances] an array of [token balances][token balances link]
  /// from before the instruction was processed
  /// [postTokenBalances] an array of [token balances][token balances link]
  /// from after the instruction was processed
  /// [logMessages] array of string log messages or omitted if log message recording
  /// was not yet enabled during this transaction
  ///
  /// [errors link]: https://github.com/solana-labs/solana/blob/master/sdk/src/transaction.rs#L24
  /// [inner instructions link]: https://docs.solana.com/developing/clients/jsonrpc-api#inner-instructions-structure
  /// [token balances link]: https://docs.solana.com/developing/clients/jsonrpc-api#token-balances-structure
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
class Reward with _$Reward {
  /// [pubkey] The public key, as base-58 encoded string, of the account that
  /// received the reward
  /// [lamports] number of reward lamports credited or debited by the account
  /// [postBalance] account balance in lamports after the reward was applied
  /// [rewardType] type of reward; See [RewardType]
  /// [commission] vote account commission when the reward was credited, only
  /// present for voting and staking rewards
  const factory Reward({
    required String pubkey,
    required int lamports,
    required int postBalance,
    required RewardType rewardType,
    required int commission,
  }) = _Reward;

  factory Reward.fromJson(Map<String, dynamic> data) => _$RewardFromJson(data);
}

@freezed
class TransactionMessageHeader with _$TransactionMessageHeader {
  const factory TransactionMessageHeader({
    required int numRequiredSignatures,
    required int numReadonlySignedAccounts,
    required int numReadonlyUnsignedAccounts,
  }) = _TransactionMessageHeader;

  factory TransactionMessageHeader.fromJson(Map<String, dynamic> data) =>
      _$TransactionMessageHeaderFromJson(data);
}

@freezed
class TransactionMessage with _$TransactionMessage {
  const factory TransactionMessage({
    required List<String> accountKeys,
    required TransactionMessageHeader header,
    required String recentBlockhash,
    required List<Instruction> instructions,
  }) = _TransactionMessage;

  factory TransactionMessage.fromJson(Map<String, dynamic> data) =>
      _$TransactionMessageFromJson(data);
}

@freezed
class ParsedTransaction with _$ParsedTransaction {
  const factory ParsedTransaction({
    required ParsedMessage message,
    required List<String> signatures,
  }) = _ParsedTransaction;

  factory ParsedTransaction.fromJson(Map<String, dynamic> data) =>
      _$ParsedTransactionFromJson(data);
}

@freezed
class Transaction with _$Transaction {
  const factory Transaction({
    required List<String> signatures,
    required TransactionMessage message,
  }) = _Transaction;

  factory Transaction.fromJson(Map<String, dynamic> data) =>
      _$TransactionFromJson(data);
}

@freezed
class TransactionDetails with _$TransactionDetails {
  const factory TransactionDetails.base64({
    required int slot,
    required Transaction transaction,
    required int? blockTime,
    required Meta meta,
  }) = TransactionDetailsBase64;

  const factory TransactionDetails.parsed({
    required int slot,
    required ParsedTransaction transaction,
    required int? blockTime,
    required Meta meta,
  }) = TransactionDetailsParsed;

  factory TransactionDetails.fromJson(Map<String, dynamic> data) =>
      _$TransactionDetailsFromJson(data);
}

@freezed
class InnerInstruction with _$InnerInstruction {
  const factory InnerInstruction({
    required int index,
    required List<Instruction> instruction,
  }) = _InnerInstruction;

  factory InnerInstruction.fromJson(Map<String, dynamic> data) =>
      _$InnerInstructionFromJson(data);
}

@freezed
class Instruction with _$Instruction {
  const factory Instruction({
    required int programIdIndex,
    required List<int> accounts,
    required String data,
  }) = _Instruction;

  factory Instruction.fromJson(Map<String, dynamic> data) =>
      _$InstructionFromJson(data);
}

@freezed
class TokenAmount with _$TokenAmount {
  const factory TokenAmount({
    required String amount,
    required int decimals,
    required String? uiAmountString,
  }) = _TokenAmount;

  factory TokenAmount.fromJson(Map<String, dynamic> data) =>
      _$TokenAmountFromJson(data);
}

@freezed
class TokenBalance with _$TokenBalance {
  const factory TokenBalance({
    required int accountIndex,
    required String mint,
    required TokenAmount uiTokenAmount,
  }) = _TokenBalance;

  factory TokenBalance.fromJson(Map<String, dynamic> data) =>
      _$TokenBalanceFromJson(data);
}

@freezed
class ClusterNode with _$ClusterNode {
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

@freezed
class EpochInfo with _$EpochInfo {
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

@freezed
class FeeCalculator with _$FeeCalculator {
  const factory FeeCalculator({
    required int lamportsPerSignature,
  }) = _FeeCalculator;

  factory FeeCalculator.fromJson(Map<String, dynamic> data) =>
      _$FeeCalculatorFromJson(data);
}

@freezed
class Range with _$Range {
  const factory Range({
    required int firstSlot,
    required int lastSlot,
  }) = _Range;

  factory Range.fromJson(Map<String, dynamic> data) => _$RangeFromJson(data);
}

class ByIdentityValue {
  const ByIdentityValue({
    required this.leaderSlots,
    required this.blocksProduced,
  });

  factory ByIdentityValue.fromJson(List<int> data) => ByIdentityValue(
        leaderSlots: data[0],
        blocksProduced: data[1],
      );

  final int leaderSlots;
  final int blocksProduced;

  Map<String, dynamic> toJson() {
    throw UnimplementedError('this is never used');
  }
}

@freezed
class BlockProduction with _$BlockProduction {
  const factory BlockProduction({
    required Map<String, ByIdentityValue> byIdentity,
    required Range range,
  }) = _BlockProduction;

  factory BlockProduction.fromJson(Map<String, dynamic> data) =>
      _$BlockProductionFromJson(data);
}

@freezed
class BlockCommitment with _$BlockCommitment {
  const factory BlockCommitment({
    required List<int>? commitment,
    required int totalStake,
  }) = _BlockCommitment;

  factory BlockCommitment.fromJson(Map<String, dynamic> data) =>
      _$BlockCommitmentFromJson(data);
}

@freezed
class EpochSchedule with _$EpochSchedule {
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

@freezed
class FeeRateGovernorValue with _$FeeRateGovernorValue {
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

@freezed
class FeeRateGovernor with _$FeeRateGovernor {
  const factory FeeRateGovernor({
    required FeeRateGovernorValue feeRateGovernor,
  }) = _FeeRateGovernor;

  factory FeeRateGovernor.fromJson(Map<String, dynamic> data) =>
      _$FeeRateGovernorFromJson(data);
}

@freezed
class Fees with _$Fees {
  const factory Fees({
    required String blockhash,
    required FeeCalculator feeCalculator,
    required int lastValidBlockHeight,
  }) = _Fees;

  factory Fees.fromJson(Map<String, dynamic> data) => _$FeesFromJson(data);
}

@freezed
class Identity with _$Identity {
  const factory Identity({
    required String identity,
  }) = _Identity;

  factory Identity.fromJson(Map<String, dynamic> data) =>
      _$IdentityFromJson(data);
}

@freezed
class InflationGovernor with _$InflationGovernor {
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

@freezed
class InflationRate with _$InflationRate {
  const factory InflationRate({
    required double total,
    required double validator,
    required double foundation,
    required double epoch,
  }) = _InflationRate;

  factory InflationRate.fromJson(Map<String, dynamic> data) =>
      _$InflationRateFromJson(data);
}

@freezed
class InflationReward with _$InflationReward {
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

@freezed
class LargeAccount with _$LargeAccount {
  const factory LargeAccount({
    required String address,
    required int lamports,
  }) = _LargeAccount;

  factory LargeAccount.fromJson(Map<String, dynamic> data) =>
      _$LargeAccountFromJson(data);
}

typedef LeaderSchedule = Map<String, List<int>>;

@freezed
class FilterParams with _$FilterParams {
  const factory FilterParams({
    required int offset,
    required String bytes,
  }) = _FilterParams;

  factory FilterParams.fromJson(Map<String, dynamic> data) =>
      _$FilterParamsFromJson(data);
}

@freezed
class Filter with _$Filter {
  const factory Filter({
    required FilterParams memcmp,
    required int dataSize,
  }) = _Filter;

  factory Filter.fromJson(Map<String, dynamic> data) => _$FilterFromJson(data);
}

@freezed
class ProgramAccount with _$ProgramAccount {
  const factory ProgramAccount({
    required Account account,
    required String pubkey,
  }) = _ProgramAccount;

  factory ProgramAccount.fromJson(Map<String, dynamic> data) =>
      _$ProgramAccountFromJson(data);
}

@freezed
class RecentBlockhash with _$RecentBlockhash {
  const factory RecentBlockhash({
    required String blockhash,
    required FeeCalculator feeCalculator,
  }) = _RecentBlockhash;

  factory RecentBlockhash.fromJson(Map<String, dynamic> data) =>
      _$RecentBlockhashFromJson(data);
}

@freezed
class PerfSample with _$PerfSample {
  const factory PerfSample({
    required int slot,
    required int numTransactions,
    required int numSlots,
    required int samplePeriodSec,
  }) = _PerfSample;

  factory PerfSample.fromJson(Map<String, dynamic> data) =>
      _$PerfSampleFromJson(data);
}

@freezed
class TransactionSignatureInformation with _$TransactionSignatureInformation {
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

@freezed
class SignatureStatus with _$SignatureStatus {
  const factory SignatureStatus({
    required int slot,
    required int? confirmations,
    required Map<String, dynamic>? err,
    required TxStatus confirmationStatus,
  }) = _SignatureStatus;

  factory SignatureStatus.fromJson(Map<String, dynamic> data) =>
      _$SignatureStatusFromJson(data);
}

@freezed
class StakeActivation with _$StakeActivation {
  const factory StakeActivation({
    required StakeActivationState state,
    required int active,
    required int inactive,
  }) = _StakeActivation;

  factory StakeActivation.fromJson(Map<String, dynamic> data) =>
      _$StakeActivationFromJson(data);
}

@freezed
class Supply with _$Supply {
  const factory Supply({
    required int total,
    required int circulating,
    required int nonCirculating,
    required List<String> nonCirculatingAccounts,
  }) = _Supply;

  factory Supply.fromJson(Map<String, dynamic> data) => _$SupplyFromJson(data);
}

@freezed
class SolanaVersion with _$SolanaVersion {
  const factory SolanaVersion({
    @JsonKey(name: 'solana-core') required String solanaCore,
    @JsonKey(name: 'feature-set') required int featureSet,
  }) = _SolanaVersion;

  factory SolanaVersion.fromJson(Map<String, dynamic> data) =>
      _$SolanaVersionFromJson(data);
}

@freezed
class VoteAccounts with _$VoteAccounts {
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

@freezed
class TransactionStatus with _$TransactionStatus {
  const factory TransactionStatus({
    required Map<String, dynamic>? err,
    required List<String>? logs,
    required List<Account>? accounts,
  }) = _TransactionStatus;

  factory TransactionStatus.fromJson(Map<String, dynamic> data) =>
      _$TransactionStatusFromJson(data);
}
