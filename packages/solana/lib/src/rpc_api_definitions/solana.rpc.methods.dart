import 'dart:async';

import 'package:solana/src/rpc_api_definitions/helper_types/rpc_response.dart';
import 'package:solana/src/rpc_api_definitions/solana.rpc.types.dart';

class RPCClient {
  Future<RpcResponse<Account>> getAccountInfo(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<RpcResponse<int>> getBalance(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<Block> getBlock(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<int> getBlockHeight(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<RpcResponse<BlockProduction>> getBlockProduction(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<BlockCommitment> getBlockCommitment(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<List<int>> getBlocks(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<List<int>> getBlocksWithLimit(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<int> getBlockTime(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<List<ClusterNode>> getClusterNodes(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<EpochInfo> getEpochInfo(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<EpochSchedule> getEpochSchedule(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<FeeCalculator> getFeeCalculatorForBlockhash(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<FeeRateGovernor> getFeeRateGovernor(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<RpcResponse<Fees>> getFees(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<int> getFirstAvailableBlock(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<String> getGenesisHash(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<String> getHealth(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<Identity> getIdentity(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<InflationGovernor> getInflationGovernor(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<InflationRate> getInflationRate(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<List<InflationReward>> getInflationReward(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<RpcResponse<List<LargeAccount>>> getLargestAccounts(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<LeaderSchedule> getLeaderSchedule(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<int> getMaxRetransmitSlot(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<int> getMaxShredInsertSlot(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<int> getMinimumBalanceForRentExemption(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<RpcResponse<List<Account>>> getMultipleAccounts(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<List<ProgramAccount>> getProgramAccounts(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<RpcResponse<RecentBlockhash>> getRecentBlockhash(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<List<PerfSample>> getRecentPerformanceSamples(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<int> getSnapshotSlot(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<List<TransactionSignatureInformation>> getSignaturesForAddress(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<RpcResponse<SignatureStatus>> getSignatureStatuses(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<int> getSlot(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<String> getSlotLeader(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<List<String>> getSlotLeaders(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<StakeActivation> getStakeActivation(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<Supply> getSupply(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<RpcResponse<TokenAmount>> getTokenAccountBalance(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<RpcResponse<List<ProgramAccount>>> getTokenAccountsByDelegate(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<RpcResponse<List<ProgramAccount>>> getTokenAccountsByOwner(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<RpcResponse<List<ProgramAccount>>> getTokenLargestAccounts(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<RpcResponse<TokenAmount>> getTokenSupply(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<TransactionDetails> getTransaction(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<int> getTransactionCount(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<SolanaVersion> getVersion(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<VoteAccounts> getVoteAccounts(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<int> minimumLedgerSlot(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<String> requestAirdrop(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<String> sendTransaction(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<RpcResponse<TransactionStatus>> simulateTransaction(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<Block> getConfirmedBlock(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<List<int>> getConfirmedBlocks(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<List<int>> getConfirmedBlocksWithLimit(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<List<TransactionSignatureInformation>> getConfirmedSignaturesForAddress2(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

  Future<TransactionDetails> getConfirmedTransaction(
      int parameter1,
  ) {
    throw UnimplementedError('not yet implemented');
  }

}
