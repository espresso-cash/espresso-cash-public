import 'dart:async';

import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/gen/annotations.dart';
import 'package:solana/src/rpc/dto/dto.dart';
import 'package:solana/src/rpc_client/json_rpc_client.dart';

part 'client.g.dart';
part 'client.rpc.dart';

@SolanaRpcClient()
abstract class RpcClient {
  factory RpcClient(String url) => _RpcClient(url);

  /// Returns all information associated with the account of provided Pubkey
  @contexted
  Future<Account> getAccountInfo(
    String pubKey, {
    required Commitment commitment,
    required Encoding encoding,
    required DataSlice dataSlice,
  });

  /// Returns the balance of the account of provided Pubkey
  @contexted
  Future<int> getBalance(
    String pubKey, {
    Commitment? commitment,
  });

  /// Returns identity and transaction information about a confirmed block in the ledger
  Future<Block> getBlock(
    int slot, {
    required Encoding encoding,
    required TransactionDetailLevel transactionDetails,
    required bool rewards,
    required Commitment commitment,
  });

  /// Returns the current block height of the node
  Future<int> getBlockHeight({
    Commitment? commitment,
  });

  /// Returns recent block production information from the current or previous epoch.
  @contexted
  Future<BlockProduction> getBlockProduction({
    required Commitment commitment,
    required Range range,
    required String identity,
  });

  /// Returns commitment for particular block
  Future<BlockCommitment> getBlockCommitment(int block);

  /// Returns a list of confirmed blocks between two slots
  Future<List<int>> getBlocks(
    int startSlot,
    int endSlot, {
    Commitment? commitment,
  });

  /// Returns a list of confirmed blocks starting at the given slot
  Future<List<int>> getBlocksWithLimit(
    int startSlot,
    int limit, {
    Commitment? commitment,
  });

  /// Returns the estimated production time of a block.
  Future<int> getBlockTime(int block);

  /// Returns information about all the nodes participating in the cluster
  Future<List<ClusterNode>> getClusterNodes();

  /// Returns information about the current epoch
  Future<EpochInfo> getEpochInfo({
    Commitment? commitment,
  });

  /// Returns epoch schedule information from this cluster's genesis config
  Future<EpochSchedule> getEpochSchedule();

  /// Returns the fee calculator associated with the query blockhash, or null if the blockhash has expired
  @contexted
  Future<FeeCalculatorForBlockhash> getFeeCalculatorForBlockhash(
    String blockhash, {
    Commitment? commitment,
  });

  /// Returns the fee rate governor information from the root bank
  Future<FeeRateGovernor> getFeeRateGovernor();

  /// Returns a recent block hash from the ledger, a fee schedule that can be used to compute the cost of submitting a transaction using it, and the last slot in which the blockhash will be valid.
  @contexted
  Future<Fees> getFees({
    Commitment? commitment,
  });

  /// Returns the slot of the lowest confirmed block that has not been purged from the ledger
  Future<int> getFirstAvailableBlock();

  /// Returns the genesis hash
  Future<String> getGenesisHash();

  /// Returns the current health of the node.
  ///
  /// If one or more --known-validator arguments are provided to solana-validator, "ok" is returned when the node has within HEALTH_CHECK_SLOT_DISTANCE slots of the highest known validator, otherwise an error is returned. "ok" is always returned if no known validators are provided.
  Future<String> getHealth();

  /// Returns the identity pubkey for the current node
  Future<Identity> getIdentity();

  /// Returns the current inflation governor
  Future<InflationGovernor> getInflationGovernor({
    Commitment? commitment,
  });

  /// Returns the specific inflation values for the current epoch
  Future<InflationRate> getInflationRate();

  /// Returns the inflation reward for a list of addresses for an epoch
  Future<List<InflationReward>> getInflationReward(String addresses);

  /// Returns the 20 largest accounts, by lamport balance (results may be cached up to two hours)
  @contexted
  Future<List<LargeAccount>> getLargestAccounts({
    required Commitment commitment,
    required CirculationStatus filter,
  });

  /// Returns the leader schedule for an epoch
  Future<Map<String, List<int>>> getLeaderSchedule(
    int slot, {
    required Commitment commitment,
    required String identity,
  });

  /// Get the max slot seen from retransmit stage.
  Future<int> getMaxRetransmitSlot();

  /// Get the max slot seen from after shred insert.
  Future<int> getMaxShredInsertSlot();

  /// Returns minimum balance required to make account rent exempt.
  Future<int> getMinimumBalanceForRentExemption(
    int accountDataLength, {
    Commitment? commitment,
  });

  /// Returns the account information for a list of Public keys
  @contexted
  Future<List<Account>> getMultipleAccounts(
    String pubKeys, {
    required Commitment commitment,
    required Encoding encoding,
    required DataSlice dataSlice,
  });

  /// Returns all accounts owned by the provided program Pubkey
  ///
  ///
  Future<List<ProgramAccount>> getProgramAccounts(
    String pubKey, {
    required Commitment commitment,
    required Encoding encoding,
    required DataSlice dataSlice,
    required Filter filter,
  });

  /// Returns a recent block hash from the ledger, and a fee schedule that can be used to compute the cost of submitting a transaction using it.
  @contexted
  Future<RecentBlockhash> getRecentBlockhash({
    Commitment? commitment,
  });

  /// Returns a list of recent performance samples, in reverse slot order. Performance samples are taken every 60 seconds and include the number of transactions and slots that occur in a given time window.
  Future<List<PerfSample>> getRecentPerformanceSamples(int limit);

  /// Returns the highest slot that the node has a snapshot for
  Future<int> getSnapshotSlot();

  /// Returns confirmed signatures for transactions involving an address backwards in time from the provided signature or most recent confirmed block
  Future<List<TransactionSignatureInformation>> getSignaturesForAddress(
    String pubKey, {
    required int limit,
    required String before,
    required String until,
    required Commitment commitment,
  });

  /// Returns the statuses of a list of signatures. Unless the searchTransactionHistory configuration parameter is included, this method only searches the recent status cache of signatures, which retains statuses for all active slots plus MAX_RECENT_BLOCKHASHES rooted slots.
  @contexted
  Future<List<SignatureStatus?>> getSignatureStatuses(
    String signatures, {
    required bool searchTransactionHistory,
  });

  /// Returns the slot that has reached the given or default commitment level
  Future<int> getSlot({
    Commitment? commitment,
  });

  /// Returns the current slot leader
  Future<String> getSlotLeader({
    Commitment? commitment,
  });

  /// Returns the slot leaders for a given slot range
  Future<List<String>> getSlotLeaders(int startSlot, int limit);

  /// Returns epoch activation information for a stake account
  Future<StakeActivation> getStakeActivation(
    String pubKey, {
    required Commitment commitment,
    required int epoch,
  });

  /// Returns information about the current supply.
  @contexted
  Future<Supply> getSupply({
    required Commitment commitment,
    required bool excludeNonCirculatingAccountsList,
  });

  /// Returns the token balance of an SPL Token account.
  @contexted
  Future<TokenAmount> getTokenAccountBalance(
    String pubKey, {
    Commitment? commitment,
  });

  /// Returns all SPL Token accounts by approved Delegate.
  @contexted
  Future<List<ProgramAccount>> getTokenAccountsByDelegate(
    String pubKey,
    TokenAccountsFilter filter, {
    required Commitment commitment,
    required Encoding encoding,
    required DataSlice dataSlice,
  });

  /// Returns all SPL Token accounts by token owner.
  @contexted
  Future<List<ProgramAccount>> getTokenAccountsByOwner(
    String pubKey,
    TokenAccountsFilter filter, {
    required Commitment commitment,
    required Encoding encoding,
    required DataSlice dataSlice,
  });

  /// Returns the 20 largest accounts of a particular SPL Token type.
  @contexted
  Future<List<ProgramAccount>> getTokenLargestAccounts(
    String pubKey, {
    Commitment? commitment,
  });

  /// Returns the total supply of an SPL Token type.
  @contexted
  Future<TokenAmount> getTokenSupply(
    String mint, {
    Commitment? commitment,
  });

  /// Returns transaction details for a confirmed transaction
  Future<TransactionDetails> getTransaction(
    String signature, {
    required Encoding encoding,
    required Commitment commitment,
  });

  /// Returns the current Transaction count from the ledger
  Future<int> getTransactionCount({
    Commitment? commitment,
  });

  /// Returns the current solana versions running on the node
  Future<SolanaVersion> getVersion();

  /// Returns the account info and associated stake for all the voting accounts in the current bank.
  Future<VoteAccounts> getVoteAccounts({
    required Commitment commitment,
    required String votePubKey,
    required bool keepUnstakedDelinquents,
    required int delinquentSlotDistance,
  });

  /// Returns the lowest slot that the node has information about in its ledger. This value may increase over time if the node is configured to purge older ledger data
  Future<int> minimumLedgerSlot();

  /// Requests an airdrop of lamports to a Pubkey
  Future<String> requestAirdrop(
    String pubKey,
    int lamports, {
    Commitment? commitment,
  });

  /// Submits a signed transaction to the cluster for processing.
  ///
  /// This method does not alter the transaction in any way; it relays the transaction created by clients to the node as-is.
  ///
  /// If the node's rpc service receives the transaction, this method immediately succeeds, without waiting for any confirmations. A successful response from this method does not guarantee the transaction is processed or confirmed by the cluster.
  ///
  /// While the rpc service will reasonably retry to submit it, the transaction could be rejected if transaction's recent_blockhash expires before it lands.
  ///
  /// Use [RPCClient.getSignatureStatuses()] to ensure a transaction is processed and confirmed.
  ///
  /// Before submitting, the following preflight checks are performed:
  ///
  /// - The transaction signatures are verified
  /// - The transaction is simulated against the bank slot specified by the preflight commitment. On failure an error will be returned. Preflight checks may be disabled if desired. It is recommended to specify the same commitment and preflight commitment to avoid confusing behavior.
  /// - The returned signature is the first signature in the transaction, which is used to identify the transaction (transaction id). This identifier can be easily extracted from the transaction data before submission.
  Future<String> sendTransaction(
    String transaction, {
    required Encoding encoding,
    required Commitment commitment,
    required bool skipPreflight,
    required int maxRetries,
  });

  /// Simulate sending a transaction
  @contexted
  Future<TransactionStatus> simulateTransaction(
    String transaction, {
    required bool sigVerify,
    required Encoding encoding,
    required Commitment commitment,
    required bool replaceRecentBlockhash,
    required SimulateTransactionAccounts accounts,
  });

  /// Returns identity and transaction information about a confirmed block in the ledger
  Future<Block> getConfirmedBlock(
    int slot, {
    required Encoding encoding,
    required TransactionDetailLevel transactionDetails,
    required bool rewards,
    required Commitment commitment,
  });

  /// Returns a list of confirmed blocks between two slots
  Future<List<int>> getConfirmedBlocks(
      int startSlot, int endSlot, Commitment commitment);

  /// Returns a list of confirmed blocks starting at the given slot
  Future<List<int>> getConfirmedBlocksWithLimit(
      int startSlot, int limit, Commitment commitment);

  /// Returns confirmed signatures for transactions involving an address backwards in time from the provided signature or most recent confirmed block
  ///
  ///
  Future<List<TransactionSignatureInformation>>
      getConfirmedSignaturesForAddress2(
    String pubKey, {
    required int limit,
    required String before,
    required String until,
    required Commitment commitment,
  });

  /// Returns transaction details for a confirmed transaction
  Future<TransactionDetails> getConfirmedTransaction(
    String signature, {
    required Encoding encoding,
    required Commitment commitment,
  });
}
