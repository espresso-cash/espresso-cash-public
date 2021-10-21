import 'dart:async';

import 'package:solana/src/dto/response.dart';
import 'package:solana/src/dto/rpc_response.dart';
import 'package:solana/src/json_rpc_client/json_rpc_client.dart';
import 'package:solana/src/rpc_client/rpc_types.dart';

/// Solana rpc api client
class RPCClient {
  /// Build an rpc api client to communicate with the solana node [rpcUrl].
  RPCClient(String rpcUrl) : _client = JsonRpcClient(rpcUrl);

  final JsonRpcClient _client;

  /// Returns all information associated with the account of
  /// provided [pubKey].
  ///
  /// Optionally you can pass an [options] parameter to configure
  /// the result and query
  Future<Account?> getAccountInfo({
    required String pubKey,
    GetAccountInfoOptions? options,
  }) async {
    final data = await _client.request(
      'getAccountInfo',
      params: <dynamic>[pubKey, options],
    );

    final response = Response<RpcResponse<Account?>>.fromJson(
      data,
      (Object? data) => RpcResponse<Account?>.fromJson(
        data as Map<String, dynamic>,
        (Object? data) {
          if (data == null) {
            return null;
          } else {
            return Account.fromJson(data as Map<String, dynamic>);
          }
        },
      ),
    );
    final rpcResponse = response.result;

    return rpcResponse.value;
  }

  /// Returns the balance of the account of provided [pubKey] optionally
  /// providing the [commitment] parameter.
  ///
  /// For the [commitment] parameter see [Commitment](https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment);
  /// "processed" is not supported. If parameter not provided, the default is "finalized".
  Future<int> getBalance({
    required String pubKey,
    CommitmentObject? commitment,
  }) async {
    final data = await _client.request(
      'getBalance',
      params: <dynamic>[pubKey, commitment],
    );

    final response = Response<RpcResponse<int>>.fromJson(
      data,
      (Object? data) => RpcResponse<int>.fromJson(
        data as Map<String, dynamic>,
        (Object? data) => data as int,
      ),
    );
    final rpcResponse = response.result;

    return rpcResponse.value;
  }

  /// Returns identity and transaction information about a
  /// confirmed block in the ledger at [slot]
  ///
  /// Optionally you can pass an [options] parameter to configure
  /// the result and query
  Future<Block?> getBlock({
    required int slot,
    GetBlockOptions? options,
  }) async {
    final data = await _client.request(
      'getBlock',
      params: <dynamic>[slot, options],
    );

    final response = Response<Block?>.fromJson(
      data,
      (Object? data) {
        if (data == null) {
          return null;
        } else {
          return Block.fromJson(data as Map<String, dynamic>);
        }
      },
    );

    return response.result;
  }

  /// Returns the current block height of the node
  ///
  /// For the [commitment] parameter see [Commitment](https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment);
  /// "processed" is not supported. If parameter not provided, the default is "finalized".
  Future<int> getBlockHeight({CommitmentObject? commitment}) async {
    final data = await _client.request(
      'getBlockHeight',
      params: <dynamic>[commitment],
    );

    final response = Response<int>.fromJson(
      data,
      (Object? data) => data as int,
    );

    return response.result;
  }

  /// Returns recent block production information from the
  /// current or previous epoch.
  ///
  /// Optionally you can pass an [options] parameter to configure
  /// the result and query
  Future<BlockProduction> getBlockProduction({
    GetBlockProductionOptions? options,
  }) async {
    final data = await _client.request(
      'getBlockProduction',
      params: <dynamic>[options],
    );

    final response = Response<RpcResponse<BlockProduction>>.fromJson(
      data,
      (Object? data) => RpcResponse<BlockProduction>.fromJson(
        data as Map<String, dynamic>,
        (Object? data) =>
            BlockProduction.fromJson(data as Map<String, dynamic>),
      ),
    );
    final rpcResponse = response.result;

    return rpcResponse.value;
  }

  /// Returns commitment for particular [block]
  Future<BlockCommitment?> getBlockCommitment({required int block}) async {
    final data = await _client.request(
      'getBlockCommitment',
      params: <dynamic>[block],
    );

    final response = Response<BlockCommitment?>.fromJson(
      data,
      (Object? data) {
        if (data == null) {
          return null;
        } else {
          return BlockCommitment.fromJson(data as Map<String, dynamic>);
        }
      },
    );

    return response.result;
  }

  /// Returns a list of confirmed blocks between two slots [startSlot] and
  /// [endSlot]. If [endSlot] is not provided then last block in the result is
  /// the latest confirmed block unless, there are more than 500,000 blocks
  /// after [startSlot].
  ///
  /// For the [commitment] parameter see [Commitment](https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment);
  /// "processed" is not supported. If parameter not provided, the default is "finalized".
  Future<List<int>> getBlocks({
    required int startSlot,
    int? endSlot,
    Commitment? commitment,
  }) async {
    final data = await _client.request(
      'getBlocks',
      params: <dynamic>[
        startSlot,
        if (endSlot != null) endSlot,
        if (commitment != null) commitment.value,
      ],
    );

    final response = Response<List<int>>.fromJson(
      data,
      (Object? data) => data as List<int>,
    );

    return response.result;
  }

  /// Returns a list of confirmed blocks starting at the given
  /// slot [startSlot] for up to [limit] blocks, inclusive.
  ///
  /// For the [commitment] parameter see [Commitment](https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment);
  /// "processed" is not supported. If parameter not provided, the default is "finalized".
  Future<List<int>> getBlocksWithLimit({
    required int startSlot,
    required int limit,
    Commitment? commitment,
  }) async {
    final data = await _client.request(
      'getBlocksWithLimit',
      params: <dynamic>[
        startSlot,
        limit,
        if (commitment != null) commitment.value,
      ],
    );

    final response = Response<List<int>>.fromJson(
      data,
      (Object? data) => data as List<int>,
    );

    return response.result;
  }

  /// Returns the estimated production time of a [block].
  Future<int?> getBlockTime({required int block}) async {
    final data = await _client.request(
      'getBlockTime',
      params: <dynamic>[block],
    );

    final response = Response<int?>.fromJson(
      data,
      (Object? data) {
        if (data == null) {
          return null;
        } else {
          return data as int?;
        }
      },
    );

    return response.result;
  }

  /// Returns information about all the nodes participating in
  /// the cluster
  Future<List<ClusterNode>> getClusterNodes() async {
    final data = await _client.request(
      'getClusterNodes',
    );

    final response = Response<List<ClusterNode>>.fromJson(
      data,
      (Object? data) => (data as List<dynamic>)
          .map((dynamic data) =>
              ClusterNode.fromJson(data as Map<String, dynamic>))
          .toList(growable: false),
    );

    return response.result;
  }

  /// Returns information about the current epoch
  ///
  /// For the [commitment] parameter see [Commitment](https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment);
  /// "processed" is not supported. If parameter not provided, the default is "finalized".
  Future<EpochInfo> getEpochInfo({CommitmentObject? commitment}) async {
    final data = await _client.request(
      'getEpochInfo',
      params: <dynamic>[commitment],
    );

    final response = Response<EpochInfo>.fromJson(
      data,
      (Object? data) => EpochInfo.fromJson(data as Map<String, dynamic>),
    );

    return response.result;
  }

  /// Returns epoch schedule information from this cluster's
  /// genesis config
  Future<EpochSchedule> getEpochSchedule() async {
    final data = await _client.request(
      'getEpochSchedule',
    );

    final response = Response<EpochSchedule>.fromJson(
      data,
      (Object? data) => EpochSchedule.fromJson(data as Map<String, dynamic>),
    );

    return response.result;
  }

  /// Returns the fee calculator associated with the query
  /// [blockhash], or null if the blockhash has expired
  ///
  /// For the [commitment] parameter see [Commitment](https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment);
  /// "processed" is not supported. If parameter not provided, the default is "finalized".
  Future<FeeCalculator?> getFeeCalculatorForBlockhash({
    required String blockhash,
    CommitmentObject? commitment,
  }) async {
    final data = await _client.request(
      'getFeeCalculatorForBlockhash',
      params: <dynamic>[blockhash, commitment],
    );

    final response = Response<FeeCalculator?>.fromJson(
      data,
      (Object? data) {
        if (data == null) {
          return null;
        } else {
          return FeeCalculator.fromJson(data as Map<String, dynamic>);
        }
      },
    );

    return response.result;
  }

  /// Returns the fee rate governor information from the root bank
  Future<FeeRateGovernor> getFeeRateGovernor() async {
    final data = await _client.request(
      'getFeeRateGovernor',
    );

    final response = Response<FeeRateGovernor>.fromJson(
      data,
      (Object? data) => FeeRateGovernor.fromJson(data as Map<String, dynamic>),
    );

    return response.result;
  }

  /// Returns a recent block hash from the ledger, a fee schedule
  /// that can be used to compute the cost of submitting a
  /// a transaction using it, and the last slot in which the
  /// blockhash will be valid.
  ///
  /// For the [commitment] parameter see [Commitment](https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment);
  /// "processed" is not supported. If parameter not provided, the default is "finalized".
  Future<Fees> getFees({CommitmentObject? commitment}) async {
    final data = await _client.request(
      'getFees',
      params: <dynamic>[commitment],
    );

    final response = Response<RpcResponse<Fees>>.fromJson(
      data,
      (Object? data) => RpcResponse<Fees>.fromJson(
        data as Map<String, dynamic>,
        (Object? data) => Fees.fromJson(data as Map<String, dynamic>),
      ),
    );
    final rpcResponse = response.result;

    return rpcResponse.value;
  }

  /// Returns the slot of the lowest confirmed block that has not
  /// been purged from the ledger
  Future<int> getFirstAvailableBlock() async {
    final data = await _client.request(
      'getFirstAvailableBlock',
    );

    final response = Response<int>.fromJson(
      data,
      (Object? data) => data as int,
    );

    return response.result;
  }

  /// Returns the genesis hash
  Future<String> getGenesisHash() async {
    final data = await _client.request(
      'getGenesisHash',
    );

    final response = Response<String>.fromJson(
      data,
      (Object? data) => data as String,
    );

    return response.result;
  }

  /// Returns the current health of the node.
  ///
  /// If one or more --known-validator arguments are provided to
  /// solana-validator, "ok" is returned when the node has
  /// s within HEALTH_CHECK_SLOT_DISTANCE slots of the highest
  /// known validator, otherwise an error is returned. "ok" is
  /// s always returned if no known validators are provided.
  Future<String> getHealth() async {
    final data = await _client.request(
      'getHealth',
    );

    final response = Response<String>.fromJson(
      data,
      (Object? data) => data as String,
    );

    return response.result;
  }

  /// Returns the identity pubkey for the current node
  Future<Identity> getIdentity() async {
    final data = await _client.request(
      'getIdentity',
    );

    final response = Response<Identity>.fromJson(
      data,
      (Object? data) => Identity.fromJson(data as Map<String, dynamic>),
    );

    return response.result;
  }

  /// Returns the current inflation governor
  ///
  /// For the [commitment] parameter see [Commitment](https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment);
  /// "processed" is not supported. If parameter not provided, the default is "finalized".
  Future<InflationGovernor> getInflationGovernor({
    CommitmentObject? commitment,
  }) async {
    final data = await _client.request(
      'getInflationGovernor',
      params: <dynamic>[commitment],
    );

    final response = Response<InflationGovernor>.fromJson(
      data,
      (Object? data) =>
          InflationGovernor.fromJson(data as Map<String, dynamic>),
    );

    return response.result;
  }

  /// Returns the specific inflation values for the current epoch
  Future<InflationRate> getInflationRate() async {
    final data = await _client.request(
      'getInflationRate',
    );

    final response = Response<InflationRate>.fromJson(
      data,
      (Object? data) => InflationRate.fromJson(data as Map<String, dynamic>),
    );

    return response.result;
  }

  /// Returns the inflation reward for a list of [addresses] for an
  /// epoch
  Future<List<InflationReward>> getInflationReward({
    required List<String> addresses,
  }) async {
    final data = await _client.request(
      'getInflationReward',
      params: <dynamic>[addresses],
    );

    final response = Response<List<InflationReward>>.fromJson(
      data,
      (Object? data) => (data as List<dynamic>)
          .map((dynamic data) =>
              InflationReward.fromJson(data as Map<String, dynamic>))
          .toList(growable: false),
    );

    return response.result;
  }

  /// Returns the 20 largest accounts, by lamport balance
  /// (results may be cached up to two hours)
  ///
  /// Optionally you can pass an [options] parameter to configure
  /// the result and query
  Future<List<LargeAccount>> getLargestAccounts({
    GetLargestAccountsOptions? options,
  }) async {
    final data = await _client.request(
      'getLargestAccounts',
      params: <dynamic>[options],
    );

    final response = Response<RpcResponse<List<LargeAccount>>>.fromJson(
      data,
      (Object? data) => RpcResponse<List<LargeAccount>>.fromJson(
        data as Map<String, dynamic>,
        (Object? data) => (data as List<dynamic>)
            .map((dynamic data) =>
                LargeAccount.fromJson(data as Map<String, dynamic>))
            .toList(growable: false),
      ),
    );
    final rpcResponse = response.result;

    return rpcResponse.value;
  }

  /// Returns the leader schedule for an epoch
  Future<LeaderSchedule?> getLeaderSchedule({
    int? slot,
    GetLeaderScheduleOptions? options,
  }) async {
    final data = await _client.request(
      'getLeaderSchedule',
      params: <dynamic>[slot, options],
    );

    final response = Response<LeaderSchedule?>.fromJson(
      data,
      (Object? data) {
        if (data == null) {
          return null;
        } else {
          return data as LeaderSchedule?;
        }
      },
    );

    return response.result;
  }

  /// Get the max slot seen from retransmit stage.
  Future<int> getMaxRetransmitSlot({required int slot}) async {
    final data = await _client.request(
      'getMaxRetransmitSlot',
      params: <dynamic>[slot],
    );

    final response = Response<int>.fromJson(
      data,
      (Object? data) => data as int,
    );

    return response.result;
  }

  /// Get the max slot seen from after shred insert.
  Future<int> getMaxShredInsertSlot() async {
    final data = await _client.request(
      'getMaxShredInsertSlot',
    );

    final response = Response<int>.fromJson(
      data,
      (Object? data) => data as int,
    );

    return response.result;
  }

  /// Returns minimum balance required to make account rent
  /// exempt.
  ///
  /// For the [commitment] parameter see [Commitment](https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment);
  /// "processed" is not supported. If parameter not provided, the default is "finalized".
  Future<int> getMinimumBalanceForRentExemption({
    required int accountDataLength,
    CommitmentObject? commitment,
  }) async {
    final data = await _client.request(
      'getMinimumBalanceForRentExemption',
      params: <dynamic>[accountDataLength, commitment],
    );

    final response = Response<int>.fromJson(
      data,
      (Object? data) => data as int,
    );

    return response.result;
  }

  /// Returns the account information for a list of Public keys
  Future<List<Account>> getMultipleAccounts({
    required List<String> pubKeys,
    GetAccountInfoOptions? options,
  }) async {
    final data = await _client.request(
      'getMultipleAccounts',
      params: <dynamic>[pubKeys, options],
    );

    final response = Response<RpcResponse<List<Account>>>.fromJson(
      data,
      (Object? data) => RpcResponse<List<Account>>.fromJson(
        data as Map<String, dynamic>,
        (Object? data) => (data as List<dynamic>)
            .map((dynamic data) =>
                Account.fromJson(data as Map<String, dynamic>))
            .toList(growable: false),
      ),
    );
    final rpcResponse = response.result;

    return rpcResponse.value;
  }

  /// Returns all accounts owned by the provided program Pubkey
  ///
  /// Optionally you can pass an [options] parameter to configure
  /// the result and query
  Future<List<ProgramAccount>> getProgramAccounts({
    required String pubKey,
    GetProgramAccountsOptions? options,
  }) async {
    final data = await _client.request(
      'getProgramAccounts',
      params: <dynamic>[pubKey, options],
    );

    final response = Response<List<ProgramAccount>>.fromJson(
      data,
      (Object? data) => (data as List<dynamic>)
          .map((dynamic data) =>
              ProgramAccount.fromJson(data as Map<String, dynamic>))
          .toList(growable: false),
    );

    return response.result;
  }

  /// Returns a recent block hash from the ledger, and a fee
  /// schedule that can be used to compute the cost of
  /// f submitting a transaction using it.
  ///
  /// For the [commitment] parameter see [Commitment](https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment);
  /// "processed" is not supported. If parameter not provided, the default is "finalized".
  Future<RecentBlockhash> getRecentBlockhash({
    CommitmentObject? commitment,
  }) async {
    final data = await _client.request(
      'getRecentBlockhash',
      params: <dynamic>[commitment],
    );

    final response = Response<RpcResponse<RecentBlockhash>>.fromJson(
      data,
      (Object? data) => RpcResponse<RecentBlockhash>.fromJson(
        data as Map<String, dynamic>,
        (Object? data) =>
            RecentBlockhash.fromJson(data as Map<String, dynamic>),
      ),
    );
    final rpcResponse = response.result;

    return rpcResponse.value;
  }

  /// Returns a list of recent performance samples, in reverse
  /// slot order. Performance samples are taken every 60 seconds
  /// s and include the number of transactions and slots that
  /// occur in a given time window.
  Future<List<PerfSample>> getRecentPerformanceSamples({
    int? limit,
  }) async {
    final data = await _client.request(
      'getRecentPerformanceSamples',
      params: <dynamic>[limit],
    );

    final response = Response<List<PerfSample>>.fromJson(
      data,
      (Object? data) => (data as List<dynamic>)
          .map((dynamic data) =>
              PerfSample.fromJson(data as Map<String, dynamic>))
          .toList(growable: false),
    );

    return response.result;
  }

  /// Returns the highest slot that the node has a snapshot for
  Future<int> getSnapshotSlot() async {
    final data = await _client.request(
      'getSnapshotSlot',
    );

    final response = Response<int>.fromJson(
      data,
      (Object? data) => data as int,
    );

    return response.result;
  }

  /// Returns confirmed signatures for transactions involving an
  /// address backwards in time from the provided signature or
  /// r most recent confirmed block
  Future<List<TransactionSignatureInformation>> getSignaturesForAddress({
    required String pubKey,
    GetSignaturesForAddressOptions? options,
  }) async {
    final data = await _client.request(
      'getSignaturesForAddress',
      params: <dynamic>[pubKey, options],
    );

    final response = Response<List<TransactionSignatureInformation>>.fromJson(
      data,
      (Object? data) => (data as List<dynamic>)
          .map((dynamic data) => TransactionSignatureInformation.fromJson(
              data as Map<String, dynamic>))
          .toList(growable: false),
    );

    return response.result;
  }

  /// Returns the statuses of a list of signatures. Unless the
  /// searchTransactionHistory configuration parameter is
  /// s included, this method only searches the recent status
  /// cache of signatures, which retains statuses for all active
  /// e slots plus MAX_RECENT_BLOCKHASHES rooted slots.
  Future<List<SignatureStatus?>> getSignatureStatuses({
    required List<String> signatures,
    GetSignatureStatusesOptions? options,
  }) async {
    final data = await _client.request(
      'getSignatureStatuses',
      params: <dynamic>[signatures, options],
    );

    final response = Response<RpcResponse<List<SignatureStatus?>>>.fromJson(
      data,
      (Object? data) => RpcResponse<List<SignatureStatus?>>.fromJson(
        data as Map<String, dynamic>,
        (Object? data) => (data as List<dynamic>).map((dynamic data) {
          if (data == null) {
            return null;
          } else {
            return SignatureStatus.fromJson(data as Map<String, dynamic>);
          }
        }).toList(growable: false),
      ),
    );
    final rpcResponse = response.result;

    return rpcResponse.value;
  }

  /// Returns the slot that has reached the given or default
  /// commitment level
  ///
  /// For the [commitment] parameter see [Commitment](https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment);
  /// "processed" is not supported. If parameter not provided, the default is "finalized".
  Future<int> getSlot({CommitmentObject? commitment}) async {
    final data = await _client.request(
      'getSlot',
      params: <dynamic>[commitment],
    );

    final response = Response<int>.fromJson(
      data,
      (Object? data) => data as int,
    );

    return response.result;
  }

  /// Returns the current slot leader
  ///
  /// For the [commitment] parameter see [Commitment](https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment);
  /// "processed" is not supported. If parameter not provided, the default is "finalized".
  Future<String> getSlotLeader({CommitmentObject? commitment}) async {
    final data = await _client.request(
      'getSlotLeader',
      params: <dynamic>[commitment],
    );

    final response = Response<String>.fromJson(
      data,
      (Object? data) => data as String,
    );

    return response.result;
  }

  /// Returns the slot leaders for a given slot range
  Future<List<String>> getSlotLeaders({
    required int startSlot,
    required int limit,
  }) async {
    final data = await _client.request(
      'getSlotLeaders',
      params: <dynamic>[startSlot, limit],
    );

    final response = Response<List<String>>.fromJson(
      data,
      (Object? data) => (data as List<dynamic>)
          .map((dynamic data) => data as String)
          .toList(growable: false),
    );

    return response.result;
  }

  /// Returns epoch activation information for a stake account
  Future<StakeActivation> getStakeActivation({
    required String pubKey,
    GetStakeActivationOptions? options,
  }) async {
    final data = await _client.request(
      'getStakeActivation',
      params: <dynamic>[pubKey, options],
    );

    final response = Response<StakeActivation>.fromJson(
      data,
      (Object? data) => StakeActivation.fromJson(data as Map<String, dynamic>),
    );

    return response.result;
  }

  /// Returns information about the current supply.
  Future<Supply> getSupply({
    GetSupplyOptions? options,
  }) async {
    final data = await _client.request(
      'getSupply',
      params: <dynamic>[options],
    );

    final response = Response<Supply>.fromJson(
      data,
      (Object? data) => Supply.fromJson(data as Map<String, dynamic>),
    );

    return response.result;
  }

  /// Returns the token balance of an SPL Token account.
  ///
  /// For the [commitment] parameter see [Commitment](https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment);
  /// "processed" is not supported. If parameter not provided, the default is "finalized".
  Future<TokenAmount> getTokenAccountBalance({
    required String pubKey,
    CommitmentObject? commitment,
  }) async {
    final data = await _client.request(
      'getTokenAccountBalance',
      params: <dynamic>[pubKey, commitment],
    );

    final response = Response<RpcResponse<TokenAmount>>.fromJson(
      data,
      (Object? data) => RpcResponse<TokenAmount>.fromJson(
        data as Map<String, dynamic>,
        (Object? data) => TokenAmount.fromJson(data as Map<String, dynamic>),
      ),
    );
    final rpcResponse = response.result;

    return rpcResponse.value;
  }

  /// Returns all SPL Token accounts by approved Delegate.
  ///
  /// Optionally you can pass an [options] parameter to configure
  /// the result and query
  Future<List<ProgramAccount>> getTokenAccountsByDelegate({
    required String pubKey,
    required MintOrProgramId mintOrProgramId,
    GetAccountInfoOptions? options,
  }) async {
    final data = await _client.request(
      'getTokenAccountsByDelegate',
      params: <dynamic>[pubKey, mintOrProgramId, options],
    );

    final response = Response<RpcResponse<List<ProgramAccount>>>.fromJson(
      data,
      (Object? data) => RpcResponse<List<ProgramAccount>>.fromJson(
        data as Map<String, dynamic>,
        (Object? data) => (data as List<dynamic>)
            .map((dynamic data) =>
                ProgramAccount.fromJson(data as Map<String, dynamic>))
            .toList(growable: false),
      ),
    );
    final rpcResponse = response.result;

    return rpcResponse.value;
  }

  /// Returns all SPL Token accounts by token owner.
  ///
  /// Optionally you can pass an [options] parameter to configure
  /// the result and query
  Future<List<ProgramAccount>> getTokenAccountsByOwner({
    required String pubKey,
    required MintOrProgramId mintOrProgramId,
    GetAccountInfoOptions? options,
  }) async {
    final data = await _client.request(
      'getTokenAccountsByOwner',
      params: <dynamic>[pubKey, mintOrProgramId, options],
    );

    final response = Response<RpcResponse<List<ProgramAccount>>>.fromJson(
      data,
      (Object? data) => RpcResponse<List<ProgramAccount>>.fromJson(
        data as Map<String, dynamic>,
        (Object? data) => (data as List<dynamic>)
            .map((dynamic data) =>
                ProgramAccount.fromJson(data as Map<String, dynamic>))
            .toList(growable: false),
      ),
    );
    final rpcResponse = response.result;

    return rpcResponse.value;
  }

  /// Returns the 20 largest accounts of a particular SPL Token
  /// type with mint [mint].
  ///
  /// For the [commitment] parameter see [Commitment](https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment);
  /// "processed" is not supported. If parameter not provided, the default is "finalized".
  Future<List<ProgramAccount>> getTokenLargestAccounts({
    required String mint,
    CommitmentObject? commitment,
  }) async {
    final data = await _client.request(
      'getTokenLargestAccounts',
      params: <dynamic>[mint, commitment],
    );

    final response = Response<RpcResponse<List<ProgramAccount>>>.fromJson(
      data,
      (Object? data) => RpcResponse<List<ProgramAccount>>.fromJson(
        data as Map<String, dynamic>,
        (Object? data) => (data as List<dynamic>)
            .map((dynamic data) =>
                ProgramAccount.fromJson(data as Map<String, dynamic>))
            .toList(growable: false),
      ),
    );
    final rpcResponse = response.result;

    return rpcResponse.value;
  }

  /// Returns the total supply of an SPL Token type.
  ///
  /// For the [commitment] parameter see [Commitment](https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment);
  /// "processed" is not supported. If parameter not provided, the default is "finalized".
  Future<TokenAmount> getTokenSupply({
    required String mint,
    CommitmentObject? commitment,
  }) async {
    final data = await _client.request(
      'getTokenSupply',
      params: <dynamic>[mint, commitment],
    );

    final response = Response<RpcResponse<TokenAmount>>.fromJson(
      data,
      (Object? data) => RpcResponse<TokenAmount>.fromJson(
        data as Map<String, dynamic>,
        (Object? data) => TokenAmount.fromJson(data as Map<String, dynamic>),
      ),
    );
    final rpcResponse = response.result;

    return rpcResponse.value;
  }

  /// Returns transaction details for a confirmed transaction
  Future<TransactionDetails?> getTransaction({
    required String signature,
    GetTransactionOptions? options,
  }) async {
    final data = await _client.request(
      'getTransaction',
      params: <dynamic>[signature, options],
    );

    final response = Response<TransactionDetails?>.fromJson(
      data,
      (Object? data) {
        if (data == null) {
          return null;
        } else {
          return TransactionDetails.fromJson(data as Map<String, dynamic>);
        }
      },
    );

    return response.result;
  }

  /// Returns the current Transaction count from the ledger
  ///
  /// For the [commitment] parameter see [Commitment](https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment);
  /// "processed" is not supported. If parameter not provided, the default is "finalized".
  Future<int> getTransactionCount({CommitmentObject? commitment}) async {
    final data = await _client.request(
      'getTransactionCount',
      params: <dynamic>[commitment],
    );

    final response = Response<int>.fromJson(
      data,
      (Object? data) => data as int,
    );

    return response.result;
  }

  /// Returns the current solana versions running on the node
  Future<SolanaVersion> getVersion() async {
    final data = await _client.request(
      'getVersion',
    );

    final response = Response<SolanaVersion>.fromJson(
      data,
      (Object? data) => SolanaVersion.fromJson(data as Map<String, dynamic>),
    );

    return response.result;
  }

  /// Returns the account info and associated stake for all the
  /// voting accounts in the current bank.
  Future<VoteAccounts> getVoteAccounts({
    GetVoteAccountsOptions? options,
  }) async {
    final data = await _client.request(
      'getVoteAccounts',
      params: <dynamic>[options],
    );

    final response = Response<VoteAccounts>.fromJson(
      data,
      (Object? data) => VoteAccounts.fromJson(data as Map<String, dynamic>),
    );

    return response.result;
  }

  /// Returns the lowest slot that the node has information about
  /// in its ledger. This value may increase over time if the
  /// e node is configured to purge older ledger data
  Future<int> minimumLedgerSlot() async {
    final data = await _client.request(
      'minimumLedgerSlot',
    );

    final response = Response<int>.fromJson(
      data,
      (Object? data) => data as int,
    );

    return response.result;
  }

  /// Requests an airdrop of lamports to a Pubkey
  ///
  /// For the [commitment] parameter see [Commitment](https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment);
  /// "processed" is not supported. If parameter not provided, the default is "finalized".
  Future<String> requestAirdrop({
    required String pubKey,
    required int lamports,
    CommitmentObject? commitment,
  }) async {
    final data = await _client.request(
      'requestAirdrop',
      params: <dynamic>[pubKey, lamports, commitment],
    );

    final response = Response<String>.fromJson(
      data,
      (Object? data) => data as String,
    );

    return response.result;
  }

  /// Submits a signed transaction to the cluster for processing.
  ///
  /// This method does not alter the transaction in any way; it
  /// relays the transaction created by clients to the node
  /// as-is.
  ///
  /// If the node's rpc service receives the transaction, this
  /// method immediately succeeds, without waiting for any
  /// confirmations. A successful response from this method
  /// does not guarantee the transaction is processed or
  /// confirmed by the cluster.
  ///
  /// While the rpc service will reasonably retry to submit it,
  /// the transaction could be rejected if transaction's
  /// recent_blockhash expires before it lands.
  ///
  /// Use getSignatureStatuses to ensure a transaction is
  /// processed and confirmed.
  ///
  /// Before submitting, the following preflight checks are
  /// performed:
  ///
  /// The transaction signatures are verified
  ///
  /// The transaction is simulated against the bank slot
  /// specified by the preflight commitment. On failure an error
  /// will be returned. Preflight checks may be disabled if
  /// desired. It is recommended to specify the same commitment
  /// and preflight commitment to avoid confusing behavior.
  ///
  /// The returned signature is the first signature in the
  /// transaction, which is used to identify the transaction
  /// (transaction id). This identifier can be easily extracted
  /// from the transaction data before submission.
  ///
  /// Optionally you can pass an [options] parameter to configure
  /// the result and query
  Future<String> sendTransaction({
    required String transaction,
    SendTransactionOptions? options,
  }) async {
    final data = await _client.request(
      'sendTransaction',
      params: <dynamic>[transaction, options],
    );

    final response = Response<String>.fromJson(
      data,
      (Object? data) => data as String,
    );

    return response.result;
  }

  /// Simulate sending a transaction
  ///
  /// Optionally you can pass an [options] parameter to configure
  /// the result and query
  Future<TransactionStatus> simulateTransaction({
    required String transaction,
    SimulateTransactionOptions? options,
  }) async {
    final data = await _client.request(
      'simulateTransaction',
      params: <dynamic>[transaction, options],
    );

    final response = Response<RpcResponse<TransactionStatus>>.fromJson(
      data,
      (Object? data) => RpcResponse<TransactionStatus>.fromJson(
        data as Map<String, dynamic>,
        (Object? data) =>
            TransactionStatus.fromJson(data as Map<String, dynamic>),
      ),
    );
    final rpcResponse = response.result;

    return rpcResponse.value;
  }

  /// Returns identity and transaction information about a
  /// confirmed block in the ledger
  @deprecated
  Future<Block> getConfirmedBlock({
    required int slot,
    GetBlockOptions? options,
  }) async {
    final data = await _client.request(
      'getConfirmedBlock',
      params: <dynamic>[slot, options],
    );

    final response = Response<Block>.fromJson(
      data,
      (Object? data) => Block.fromJson(data as Map<String, dynamic>),
    );

    return response.result;
  }

  /// Returns a list of confirmed blocks between two slots
  ///
  /// For the [commitment] parameter see [Commitment](https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment);
  /// "processed" is not supported. If parameter not provided, the default is "finalized".
  @deprecated
  Future<List<int>> getConfirmedBlocks({
    required int startSlot,
    int? endSlot,
    Commitment? commitment,
  }) async {
    final data = await _client.request(
      'getConfirmedBlocks',
      params: <dynamic>[
        startSlot,
        endSlot,
        if (commitment != null) commitment.value,
      ],
    );

    final response = Response<List<int>>.fromJson(
      data,
      (Object? data) => data as List<int>,
    );

    return response.result;
  }

  /// Returns a list of confirmed blocks starting at the given
  /// slot
  ///
  /// For the [commitment] parameter see [Commitment](https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment);
  /// "processed" is not supported. If parameter not provided, the default is "finalized".
  @deprecated
  Future<List<int>> getConfirmedBlocksWithLimit({
    required int startSlot,
    required int limit,
    Commitment? commitment,
  }) async {
    final data = await _client.request(
      'getConfirmedBlocksWithLimit',
      params: <dynamic>[
        startSlot,
        limit,
        if (commitment != null) commitment.value,
      ],
    );

    final response = Response<List<int>>.fromJson(
      data,
      (Object? data) => data as List<int>,
    );

    return response.result;
  }

  /// Returns confirmed signatures for transactions involving an
  /// address backwards in time from the provided signature or
  /// most recent confirmed block
  ///
  /// For the [commitment] parameter see [Commitment](https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment);
  /// "processed" is not supported. If parameter not provided, the default is "finalized".
  @deprecated
  Future<List<TransactionSignatureInformation>>
      getConfirmedSignaturesForAddress2({
    required String pubKey,
    GetConfirmedSignaturesForAddress2Options? options,
  }) async {
    final data = await _client.request(
      'getConfirmedSignaturesForAddress2',
      params: <dynamic>[pubKey, options],
    );

    final response = Response<List<TransactionSignatureInformation>>.fromJson(
      data,
      (Object? data) => (data as List<dynamic>)
          .map((dynamic data) => TransactionSignatureInformation.fromJson(
              data as Map<String, dynamic>))
          .toList(growable: false),
    );

    return response.result;
  }

  /// Returns transaction details for a confirmed transaction
  ///
  /// Optionally you can pass an [options] parameter to configure
  /// the result and query
  @deprecated
  Future<TransactionDetails?> getConfirmedTransaction({
    required String signature,
    GetConfirmedTransactionOptions? options,
  }) async {
    final data = await _client.request(
      'getConfirmedTransaction',
      params: <dynamic>[signature, options],
    );

    if (options?.encoding == Encoding.jsonParsed) {
      final response = Response<TransactionDetails?>.fromJson(
        data,
        (Object? data) {
          if (data == null) {
            return null;
          } else {
            return TransactionDetailsParsed.fromJson(
              data as Map<String, dynamic>,
            );
          }
        },
      );

      return response.result;
    } else {
      final response = Response<TransactionDetails?>.fromJson(
        data,
        (Object? data) {
          if (data == null) {
            return null;
          } else {
            return TransactionDetailsBase64.fromJson(
              data as Map<String, dynamic>,
            );
          }
        },
      );

      return response.result;
    }
  }
}
