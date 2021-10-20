import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/src/dto/account_data.dart';
import 'package:solana/src/parsed_message/parsed_message.dart';

part 'rpc_types.freezed.dart';
part 'rpc_types.g.dart';

enum TransactionDetailLevel {
  full,
  signatures,
  none,
}

@freezed
class GetConfirmedTransactionOptions with _$GetConfirmedTransactionOptions {
  const factory GetConfirmedTransactionOptions({
    @Default(Encoding.jsonParsed) Encoding? encoding,
    @Default(Commitment.finalized) Commitment? commitment,
  }) = _GetConfirmedTransactionOptions;

  factory GetConfirmedTransactionOptions.fromJson(Map<String, dynamic> data) =>
      _$GetConfirmedTransactionOptionsFromJson(data);
}

@freezed
class SimulateTransactionAccounts with _$SimulateTransactionAccounts {
  const factory SimulateTransactionAccounts({
    Encoding? accountEncoding,
    List<String>? addresses,
  }) = _SimulateTransactionAccounts;

  factory SimulateTransactionAccounts.fromJson(Map<String, dynamic> data) =>
      _$SimulateTransactionAccountsFromJson(data);
}

@freezed
class SimulateTransactionOptions with _$SimulateTransactionOptions {
  const factory SimulateTransactionOptions({
    bool? sigVerify,
    Encoding? encoding,
    Commitment? commitment,
    bool? replaceRecentBlockhash,
    SimulateTransactionAccounts? accounts,
  }) = _SimulateTransactionOptions;

  factory SimulateTransactionOptions.fromJson(Map<String, dynamic> data) =>
      _$SimulateTransactionOptionsFromJson(data);
}

@freezed
class SendTransactionOptions with _$SendTransactionOptions {
  const factory SendTransactionOptions({
    Encoding? encoding,
    Commitment? commitment,
    bool? skipPreflight,
    int? maxRetries,
  }) = _SendTransactionOptions;

  factory SendTransactionOptions.fromJson(Map<String, dynamic> data) =>
      _$SendTransactionOptionsFromJson(data);
}

@freezed
class GetVoteAccountsOptions with _$GetVoteAccountsOptions {
  const factory GetVoteAccountsOptions({
    Commitment? commitment,
    String? votePubKey,
    bool? keepUnstakedDelinquents,
    int? delinquentSlotDistance,
  }) = _GetVoteAccountsOptions;

  factory GetVoteAccountsOptions.fromJson(Map<String, dynamic> data) =>
      _$GetVoteAccountsOptionsFromJson(data);
}

@freezed
class GetTransactionOptions with _$GetTransactionOptions {
  const factory GetTransactionOptions({
    Encoding? encoding,
    Commitment? commitment,
  }) = _GetTransactionOptions;

  factory GetTransactionOptions.fromJson(Map<String, dynamic> data) =>
      _$GetTransactionOptionsFromJson(data);
}

@freezed
class MintOrProgramId with _$MintOrProgramId {
  const factory MintOrProgramId({
    @JsonKey(includeIfNull: false) String? mint,
    @JsonKey(includeIfNull: false) String? programId,
  }) = _MintOrProgramId;

  factory MintOrProgramId.fromJson(Map<String, dynamic> data) =>
      _$MintOrProgramIdFromJson(data);
}

@freezed
class GetSupplyOptions with _$GetSupplyOptions {
  const factory GetSupplyOptions({
    Commitment? commitment,
    bool? excludeNonCirculatingAccountsList,
  }) = _GetSupplyOptions;

  factory GetSupplyOptions.fromJson(Map<String, dynamic> data) =>
      _$GetSupplyOptionsFromJson(data);
}

@freezed
class GetStakeActivationOptions with _$GetStakeActivationOptions {
  const factory GetStakeActivationOptions({
    Commitment? commitment,
    int? epoch,
  }) = _GetStakeActivationOptions;

  factory GetStakeActivationOptions.fromJson(Map<String, dynamic> data) =>
      _$GetStakeActivationOptionsFromJson(data);
}

@freezed
class GetSignatureStatusesOptions with _$GetSignatureStatusesOptions {
  const factory GetSignatureStatusesOptions({
    bool? searchTransactionHistory,
  }) = _GetSignatureStatusesOptions;

  factory GetSignatureStatusesOptions.fromJson(Map<String, dynamic> data) =>
      _$GetSignatureStatusesOptionsFromJson(data);
}

@freezed
class GetSignaturesForAddressOptions with _$GetSignaturesForAddressOptions {
  const factory GetSignaturesForAddressOptions({
    int? limit,
    String? before,
    String? until,
    Commitment? commitment,
  }) = _GetSignaturesForAddressOptions;

  factory GetSignaturesForAddressOptions.fromJson(Map<String, dynamic> data) =>
      _$GetSignaturesForAddressOptionsFromJson(data);
}

@freezed
class GetProgramAccountsOptions with _$GetProgramAccountsOptions {
  const factory GetProgramAccountsOptions({
    Commitment? commitment,
    Encoding? encoding,
    DataSlice? dataSlice,
    List<Filter>? filter,
    bool? withContext,
  }) = _GetProgramAccountsOptions;

  factory GetProgramAccountsOptions.fromJson(Map<String, dynamic> data) =>
      _$GetProgramAccountsOptionsFromJson(data);
}

@freezed
class GetLeaderScheduleOptions with _$GetLeaderScheduleOptions {
  const factory GetLeaderScheduleOptions({
    Commitment? commitment,
    String? identity,
  }) = _GetLeaderScheduleOptions;

  factory GetLeaderScheduleOptions.fromJson(Map<String, dynamic> data) =>
      _$GetLeaderScheduleOptionsFromJson(data);
}

@freezed
class GetLargestAccountsOptions with _$GetLargestAccountsOptions {
  const factory GetLargestAccountsOptions({
    Commitment? commitment,
    CirculationStatus? filter,
  }) = _GetLargestAccountsOptions;

  factory GetLargestAccountsOptions.fromJson(Map<String, dynamic> data) =>
      _$GetLargestAccountsOptionsFromJson(data);
}

@freezed
class GetBlockProductionOptions with _$GetBlockProductionOptions {
  const factory GetBlockProductionOptions({
    @Default(Commitment.finalized) Commitment? commitment,
    @JsonKey(includeIfNull: false) Range? range,
    @JsonKey(includeIfNull: false) String? identity,
  }) = _GetBlockProductionOptions;

  factory GetBlockProductionOptions.fromJson(Map<String, dynamic> data) =>
      _$GetBlockProductionOptionsFromJson(data);
}

@freezed
class GetBlockOptions with _$GetBlockOptions {
  const factory GetBlockOptions({
    @Default(Encoding.jsonParsed) Encoding? encoding,
    @Default(TransactionDetailLevel.full)
        TransactionDetailLevel? transactionDetails,
    @Default(true) bool? rewards,
    @Default(Commitment.finalized) Commitment? commitment,
  }) = _GetBlockOptions;

  factory GetBlockOptions.fromJson(Map<String, dynamic> data) =>
      _$GetBlockOptionsFromJson(data);
}

@freezed
class GetAccountOptions with _$GetAccountOptions {
  const factory GetAccountOptions({
    @Default(Commitment.finalized) Commitment? commitment,
    @Default(Encoding.jsonParsed) Encoding? encoding,
    @JsonKey(includeIfNull: false) DataSlice? dataSlice,
  }) = _GetAccountOptions;

  factory GetAccountOptions.fromJson(Map<String, dynamic> data) =>
      _$GetAccountOptionsFromJson(data);
}

@freezed
class DataSlice with _$DataSlice {
  const factory DataSlice({
    int? offset,
    int? length,
  }) = _DataSlice;

  factory DataSlice.fromJson(Map<String, dynamic> data) =>
      _$DataSliceFromJson(data);
}

enum CirculationStatus {
  circulating,
  nonCirculating,
}

enum Encoding {
  base64,
  jsonParsed,
}

@freezed
class CommitmentObject with _$CommitmentObject {
  const factory CommitmentObject({
    @Default(Commitment.finalized) Commitment commitment,
  }) = _CommitmentObject;

  factory CommitmentObject.fromJson(Map<String, dynamic> data) =>
      _$CommitmentObjectFromJson(data);
}

enum Commitment {
  processed,
  confirmed,
  finalized,
}

typedef TxStatus = Commitment;

typedef ValidatorIdentity = List<int>;

enum RewardType {
  fee,
  rent,
  voting,
  staking,
}

enum StakeActivationState {
  active,
  inactive,
  activating,
  deactivating,
}

@freezed
class Account with _$Account {
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

@freezed
class Block with _$Block {
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

@freezed
class Meta with _$Meta {
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

@freezed
class Reward with _$Reward {
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

@freezed
class BlockProduction with _$BlockProduction {
  const factory BlockProduction({
    required Map<String, ValidatorIdentity> byIdentity,
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
