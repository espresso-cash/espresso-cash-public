import 'package:freezed_annotation/freezed_annotation.dart';

part 'solana.rpc.types.freezed.dart';
part 'solana.rpc.types.g.dart';

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
    required [string, encoding] data,
    required bool executable,
    required int rentEpoch,
  }) = _Account;

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);
}

@freezed
class Block with _$Block {
  const factory Block({
    required String blockhash,
    required String previousBlockhash,
    required int parentSlot,
    required List<Transaction> transactions,
    required Meta meta,
    required List<String> signatures,
    required List<Reward> rewards,
    required int blockTime,
    required int blockHeight,
  }) = _Block;

  factory Block.fromJson(Map<String, dynamic> json) => _$BlockFromJson(json);
}

@freezed
class Meta with _$Meta {
  const factory Meta({
    required Map<String, dynamic> err,
    required int fee,
    required List<int> preBalances,
    required List<int> postBalances,
    required List<InnerInstruction> innerInstructions,
    required List<TokenBalance> preTokenBalances,
    required List<TokenBalance> postTokenBalances,
    required List<String> logMessages,
  }) = _Meta;

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
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

  factory Reward.fromJson(Map<String, dynamic> json) => _$RewardFromJson(json);
}

@freezed
class Transaction with _$Transaction {
  const factory Transaction({
    required List<String> signatures,
    required Map<String, dynamic> message,
  }) = _Transaction;

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);
}

@freezed
class TransactionDetails with _$TransactionDetails {
  const factory TransactionDetails({
    required int slot,
    required Transaction transaction,
    required int blockTime,
    required Meta meta,
  }) = _TransactionDetails;

  factory TransactionDetails.fromJson(Map<String, dynamic> json) => _$TransactionDetailsFromJson(json);
}

@freezed
class InnerInstruction with _$InnerInstruction {
  const factory InnerInstruction({
    required int index,
    required List<Instruction> instruction,
  }) = _InnerInstruction;

  factory InnerInstruction.fromJson(Map<String, dynamic> json) => _$InnerInstructionFromJson(json);
}

@freezed
class Instruction with _$Instruction {
  const factory Instruction({
    required int programIdIndex,
    required List<int> accounts,
    required String data,
  }) = _Instruction;

  factory Instruction.fromJson(Map<String, dynamic> json) => _$InstructionFromJson(json);
}

@freezed
class TokenBalance with _$TokenBalance {
  const factory TokenBalance({
    required int accountIndex,
    required String mint,
    required Map<String, dynamic> uiTokenAmount,
  }) = _TokenBalance;

  factory TokenBalance.fromJson(Map<String, dynamic> json) => _$TokenBalanceFromJson(json);
}

@freezed
class ClusterNode with _$ClusterNode {
  const factory ClusterNode({
    required String pubkey,
    required String gossip,
    required String tpu,
    required String rpc,
    required String version,
    required int featureSet,
    required int shredVersion,
  }) = _ClusterNode;

  factory ClusterNode.fromJson(Map<String, dynamic> json) => _$ClusterNodeFromJson(json);
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

  factory EpochInfo.fromJson(Map<String, dynamic> json) => _$EpochInfoFromJson(json);
}

@freezed
class FeeCalculator with _$FeeCalculator {
  const factory FeeCalculator({
    required Map<String, dynamic> feeCalculator,
  }) = _FeeCalculator;

  factory FeeCalculator.fromJson(Map<String, dynamic> json) => _$FeeCalculatorFromJson(json);
}

@freezed
class BlockProduction with _$BlockProduction {
  const factory BlockProduction({
    required Map<String, ValidatorIdentity> byIdentity,
    required Map<String, dynamic> range,
  }) = _BlockProduction;

  factory BlockProduction.fromJson(Map<String, dynamic> json) => _$BlockProductionFromJson(json);
}

@freezed
class BlockCommitment with _$BlockCommitment {
  const factory BlockCommitment({
    required List<int> commitment,
    required int totalStake,
  }) = _BlockCommitment;

  factory BlockCommitment.fromJson(Map<String, dynamic> json) => _$BlockCommitmentFromJson(json);
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

  factory EpochSchedule.fromJson(Map<String, dynamic> json) => _$EpochScheduleFromJson(json);
}

@freezed
class FeeRateGovernor with _$FeeRateGovernor {
  const factory FeeRateGovernor({
    required Map<String, dynamic> feeRateGovernor,
  }) = _FeeRateGovernor;

  factory FeeRateGovernor.fromJson(Map<String, dynamic> json) => _$FeeRateGovernorFromJson(json);
}

@freezed
class Fees with _$Fees {
  const factory Fees({
    required String blockhash,
    required FeeCalculator feeCalculator,
    required int lastValidBlockHeight,
  }) = _Fees;

  factory Fees.fromJson(Map<String, dynamic> json) => _$FeesFromJson(json);
}

@freezed
class Identity with _$Identity {
  const factory Identity({
    required String identity,
  }) = _Identity;

  factory Identity.fromJson(Map<String, dynamic> json) => _$IdentityFromJson(json);
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

  factory InflationGovernor.fromJson(Map<String, dynamic> json) => _$InflationGovernorFromJson(json);
}

@freezed
class InflationRate with _$InflationRate {
  const factory InflationRate({
    required double total,
    required double validator,
    required double foundation,
    required double epoch,
  }) = _InflationRate;

  factory InflationRate.fromJson(Map<String, dynamic> json) => _$InflationRateFromJson(json);
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

  factory InflationReward.fromJson(Map<String, dynamic> json) => _$InflationRewardFromJson(json);
}

@freezed
class LargeAccount with _$LargeAccount {
  const factory LargeAccount({
    required String address,
    required int lamports,
  }) = _LargeAccount;

  factory LargeAccount.fromJson(Map<String, dynamic> json) => _$LargeAccountFromJson(json);
}

typedef LeaderSchedule = Map<String, List<int>>;

@freezed
class Filter with _$Filter {
  const factory Filter({
    required Map<String, dynamic> memcmp,
    required int dataSize,
  }) = _Filter;

  factory Filter.fromJson(Map<String, dynamic> json) => _$FilterFromJson(json);
}

@freezed
class ProgramAccount with _$ProgramAccount {
  const factory ProgramAccount({
    required Account account,
    required String pubkey,
  }) = _ProgramAccount;

  factory ProgramAccount.fromJson(Map<String, dynamic> json) => _$ProgramAccountFromJson(json);
}

@freezed
class RecentBlockhash with _$RecentBlockhash {
  const factory RecentBlockhash({
    required String blockhash,
    required FeeCalculator feeCalculator,
  }) = _RecentBlockhash;

  factory RecentBlockhash.fromJson(Map<String, dynamic> json) => _$RecentBlockhashFromJson(json);
}

@freezed
class PerfSample with _$PerfSample {
  const factory PerfSample({
    required int slot,
    required int numTransactions,
    required int numSlots,
    required int samplePeriodSec,
  }) = _PerfSample;

  factory PerfSample.fromJson(Map<String, dynamic> json) => _$PerfSampleFromJson(json);
}

@freezed
class TransactionSignatureInformation with _$TransactionSignatureInformation {
  const factory TransactionSignatureInformation({
    required String signature,
    required int slot,
    required Map<String, dynamic> err,
    required String memo,
    required int blockTime,
  }) = _TransactionSignatureInformation;

  factory TransactionSignatureInformation.fromJson(Map<String, dynamic> json) => _$TransactionSignatureInformationFromJson(json);
}

@freezed
class SignatureStatus with _$SignatureStatus {
  const factory SignatureStatus({
    required int slot,
    required int confirmations,
    required Map<String, dynamic> err,
    required TxStatus confirmationStatus,
  }) = _SignatureStatus;

  factory SignatureStatus.fromJson(Map<String, dynamic> json) => _$SignatureStatusFromJson(json);
}

@freezed
class StakeActivation with _$StakeActivation {
  const factory StakeActivation({
    required StakeActivationState state,
    required int active,
    required int inactive,
  }) = _StakeActivation;

  factory StakeActivation.fromJson(Map<String, dynamic> json) => _$StakeActivationFromJson(json);
}

@freezed
class Supply with _$Supply {
  const factory Supply({
    required int total,
    required int circulating,
    required int nonCirculating,
    required List<String> nonCirculatingAccounts,
  }) = _Supply;

  factory Supply.fromJson(Map<String, dynamic> json) => _$SupplyFromJson(json);
}

@freezed
class SolanaVersion with _$SolanaVersion {
  const factory SolanaVersion({
    @JsonKey(name: 'solana-core') required String solanaCore,
    @JsonKey(name: 'feature-set') required int featureSet,
  }) = _SolanaVersion;

  factory SolanaVersion.fromJson(Map<String, dynamic> json) => _$SolanaVersionFromJson(json);
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

  factory VoteAccounts.fromJson(Map<String, dynamic> json) => _$VoteAccountsFromJson(json);
}

@freezed
class TransactionStatus with _$TransactionStatus {
  const factory TransactionStatus({
    required Map<String, dynamic> err,
    required List<String> logs,
    required List<Account> accounts,
  }) = _TransactionStatus;

  factory TransactionStatus.fromJson(Map<String, dynamic> json) => _$TransactionStatusFromJson(json);
}

