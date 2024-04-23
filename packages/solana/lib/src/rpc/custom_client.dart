import 'package:solana/dto.dart';
import 'package:solana/solana.dart';
import 'package:solana/src/rpc/json_rpc_client.dart';

/// RpcClient extension which enables custom client usage.
class CustomRpcClient implements RpcClient {
  CustomRpcClient(this._url, this._jsonRpcClient);

  CustomRpcClient.withCustomClient(this._jsonRpcClient)
      : _url = _jsonRpcClient.url;
  final JsonRpcClient _jsonRpcClient;
  JsonRpcClient get jsonRpcClient => _jsonRpcClient;
  final String _url;

  @override
  Future<AccountResult> getAccountInfo(
    String pubKey, {
    Commitment commitment = Commitment.finalized,
    Encoding? encoding,
    DataSlice? dataSlice,
    num? minContextSlot,
  }) async {
    final dynamic result = await _jsonRpcClient.request(
      'getAccountInfo',
      params: [
        pubKey,
        {
          'commitment': commitment.value,
          if (encoding != null) 'encoding': encoding.value,
          if (dataSlice != null) 'dataSlice': dataSlice.toJson(),
          if (minContextSlot != null) 'minContextSlot': minContextSlot,
        },
      ],
    );
    return AccountResult.fromJson(result as Map<String, dynamic>);
  }

  @override
  Future<BalanceResult> getBalance(
    String pubKey, {
    Commitment? commitment,
    num? minContextSlot,
  }) async {
    final dynamic result = await _jsonRpcClient.request(
      'getBalance',
      params: [
        pubKey,
        {
          if (commitment != null) 'commitment': commitment.value,
          if (minContextSlot != null) 'minContextSlot': minContextSlot,
        },
      ],
    );
    return BalanceResult.fromJson(result as Map<String, dynamic>);
  }

  @override
  Future<Block?> getBlock(
    int slot, {
    Encoding? encoding,
    TransactionDetailLevel? transactionDetails,
    bool? rewards = false,
    Commitment? commitment = Commitment.finalized,
    num? maxSupportedTransactionVersion = 0,
  }) async {
    final dynamic result = await _jsonRpcClient.request(
      'getBlock',
      params: [
        slot,
        {
          if (encoding != null) 'encoding': encoding.value,
          if (transactionDetails != null)
            'transactionDetails': transactionDetails,
          'rewards': rewards,
          if (commitment != null) 'commitment': commitment.value,
          'maxSupportedTransactionVersion': maxSupportedTransactionVersion,
        },
      ],
    );
    return result != null
        ? Block.fromJson(result as Map<String, dynamic>)
        : null;
  }

  @override
  Future<BlockCommitment?> getBlockCommitment(int block) async {
    final dynamic result = await _jsonRpcClient.request(
      'getBlockCommitment',
      params: [block],
    );
    return result != null
        ? BlockCommitment.fromJson(result as Map<String, dynamic>)
        : null;
  }

  @override
  Future<int> getBlockHeight({
    Commitment? commitment,
    num? minContextSlot,
  }) async {
    final dynamic result = await _jsonRpcClient.request(
      'getBlockHeight',
      params: [
        {
          if (commitment != null) 'commitment': commitment.value,
          if (minContextSlot != null) 'minContextSlot': minContextSlot,
        },
      ],
    );
    return result as int;
  }

  @override
  Future<BlockProductionResult> getBlockProduction({
    Commitment? commitment = Commitment.finalized,
    Range? range,
    String? identity,
  }) async {
    final dynamic result = await _jsonRpcClient.request(
      'getBlockProduction',
      params: [
        {
          if (commitment != null) 'commitment': commitment.value,
          if (range != null) 'range': range.toJson(),
          if (identity != null) 'identity': identity,
        },
      ],
    );
    return BlockProductionResult.fromJson(result as Map<String, dynamic>);
  }

  @override
  Future<int?> getBlockTime(int block) async {
    final dynamic result = await _jsonRpcClient.request(
      'getBlockTime',
      params: [block],
    );
    return result as int?;
  }

  @override
  Future<List<int>> getBlocks(
    int startSlot,
    int? endSlot, {
    Commitment? commitment,
  }) async {
    final dynamic result = await _jsonRpcClient.request(
      'getBlocks',
      params: [
        startSlot,
        endSlot,
        {
          if (commitment != null) 'commitment': commitment.value,
        },
      ],
    );
    return (result as List<dynamic>).cast<int>();
  }

  @override
  Future<List<int>> getBlocksWithLimit(
    int startSlot,
    int limit, {
    Commitment? commitment,
  }) async {
    final dynamic result = await _jsonRpcClient.request(
      'getBlocksWithLimit',
      params: [
        startSlot,
        limit,
        {
          if (commitment != null) 'commitment': commitment.value,
        },
      ],
    );
    return (result as List<dynamic>).cast<int>();
  }

  @override
  Future<List<ClusterNode>> getClusterNodes() async {
    final dynamic result = await _jsonRpcClient.request('getClusterNodes');
    return (result as List<dynamic>)
        .map((dynamic item) =>
            ClusterNode.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<EpochInfo> getEpochInfo({
    Commitment? commitment,
    num? minContextSlot,
  }) async {
    final dynamic result = await _jsonRpcClient.request(
      'getEpochInfo',
      params: [
        {
          if (commitment != null) 'commitment': commitment.value,
          if (minContextSlot != null) 'minContextSlot': minContextSlot,
        },
      ],
    );
    return EpochInfo.fromJson(result as Map<String, dynamic>);
  }

  @override
  Future<EpochSchedule> getEpochSchedule() async {
    final dynamic result = await _jsonRpcClient.request('getEpochSchedule');
    return EpochSchedule.fromJson(result as Map<String, dynamic>);
  }

  @override
  Future<int?> getFeeForMessage(
    String message, {
    Commitment? commitment,
    num? minContextSlot,
  }) async {
    final dynamic result = await _jsonRpcClient.request(
      'getFeeForMessage',
      params: [
        message,
        {
          if (commitment != null) 'commitment': commitment.value,
          if (minContextSlot != null) 'minContextSlot': minContextSlot,
        },
      ],
    );
    return result as int?;
  }

  @override
  Future<int> getFirstAvailableBlock() async {
    final dynamic result =
        await _jsonRpcClient.request('getFirstAvailableBlock');
    return result as int;
  }

  @override
  Future<String> getGenesisHash() async {
    final dynamic result = await _jsonRpcClient.request('getGenesisHash');
    return result as String;
  }

  @override
  Future<String> getHealth() async {
    final dynamic result = await _jsonRpcClient.request('getHealth');
    // Make sure that the result has a 'result' key.
    if (result is! Map<String, dynamic> || !result.containsKey('result')) {
      throw Exception('Unexpected response format: $result');
    }
    return result['result'] as String;
  }

  @override
  Future<HighestSnapshotSlot> getHighestSnapshotSlot() async {
    final dynamic result =
        await _jsonRpcClient.request('getHighestSnapshotSlot');
    return HighestSnapshotSlot.fromJson(result as Map<String, dynamic>);
  }

  @override
  Future<Identity> getIdentity() async {
    final dynamic result = await _jsonRpcClient.request('getIdentity');
    return Identity.fromJson(result as Map<String, dynamic>);
  }

  @override
  Future<InflationGovernor> getInflationGovernor(
      {Commitment? commitment}) async {
    final dynamic result = await _jsonRpcClient.request(
      'getInflationGovernor',
      params: [
        {
          if (commitment != null) 'commitment': commitment.value,
        },
      ],
    );
    return InflationGovernor.fromJson(result as Map<String, dynamic>);
  }

  @override
  Future<InflationRate> getInflationRate() async {
    final dynamic result = await _jsonRpcClient.request('getInflationRate');
    return InflationRate.fromJson(result as Map<String, dynamic>);
  }

  @override
  Future<List<InflationReward>> getInflationReward(
    List<String> addresses, {
    Commitment? commitment,
    int? epoch,
    num? minContextSlot,
  }) async {
    final dynamic result = await _jsonRpcClient.request(
      'getInflationReward',
      params: [
        addresses,
        {
          if (commitment != null) 'commitment': commitment.value,
          if (epoch != null) 'epoch': epoch,
          if (minContextSlot != null) 'minContextSlot': minContextSlot,
        },
      ],
    );
    return (result as List<dynamic>)
        .map((dynamic item) =>
            InflationReward.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<LargeAccountsResult> getLargestAccounts({
    Commitment? commitment = Commitment.finalized,
    CirculationStatus? filter,
  }) async {
    final dynamic result = await _jsonRpcClient.request(
      'getLargestAccounts',
      params: [
        {
          if (commitment != null) 'commitment': commitment.value,
          if (filter != null) 'filter': filter,
        },
      ],
    );
    return LargeAccountsResult.fromJson(result as Map<String, dynamic>);
  }

  @override
  Future<LatestBlockhashResult> getLatestBlockhash({
    Commitment? commitment,
    num? minContextSlot,
  }) async {
    final dynamic result = await _jsonRpcClient.request(
      'getLatestBlockhash',
      params: [
        {
          if (commitment != null) 'commitment': commitment.value,
          if (minContextSlot != null) 'minContextSlot': minContextSlot,
        },
      ],
    );
    return LatestBlockhashResult.fromJson(result as Map<String, dynamic>);
  }

  @override
  Future<Map<String, List<int>>?> getLeaderSchedule(
    int? slot, {
    Commitment? commitment = Commitment.finalized,
    String? identity,
  }) async {
    final result = await _jsonRpcClient.request(
      'getLeaderSchedule',
      params: [
        slot,
        {
          if (commitment != null) 'commitment': commitment.value,
          if (identity != null) 'identity': identity,
        },
      ],
    );

    return Map<String, List<int>>.fromEntries(result.entries.map((entry) {
      // Assuming the value is a list
      if (entry.value is List) {
        try {
          return MapEntry(entry.key, entry.value as List<int>);
        } catch (e) {
          throw FormatException(
              'Unexpected data format in leader schedule: $e');
        }
      } else {
        // Handle a non-list value
        throw const FormatException(
            'Unexpected data format in leader schedule');
      }
    }));
  }

  @override
  Future<int> getMaxRetransmitSlot() async {
    final dynamic result = await _jsonRpcClient.request('getMaxRetransmitSlot');
    return result as int;
  }

  @override
  Future<int> getMaxShredInsertSlot() async {
    final dynamic result =
        await _jsonRpcClient.request('getMaxShredInsertSlot');
    return result as int;
  }

  @override
  Future<int> getMinimumBalanceForRentExemption(
    int accountDataLength, {
    Commitment? commitment,
  }) async {
    final dynamic result = await _jsonRpcClient.request(
      'getMinimumBalanceForRentExemption',
      params: [
        accountDataLength,
        {
          if (commitment != null) 'commitment': commitment.value,
        },
      ],
    );
    return result as int;
  }

  @override
  Future<MultipleAccountsResult> getMultipleAccounts(
    List<String> pubKeys, {
    Commitment commitment = Commitment.finalized,
    Encoding? encoding,
    DataSlice? dataSlice,
    num? minContextSlot,
  }) async {
    final dynamic result = await _jsonRpcClient.request(
      'getMultipleAccounts',
      params: [
        pubKeys,
        {
          'commitment': commitment.value,
          if (encoding != null) 'encoding': encoding.value,
          if (dataSlice != null) 'dataSlice': dataSlice.toJson(),
          if (minContextSlot != null) 'minContextSlot': minContextSlot,
        },
      ],
    );
    return MultipleAccountsResult.fromJson(result as Map<String, dynamic>);
  }

  @override
  Future<List<ProgramAccount>> getProgramAccounts(
    String pubKey, {
    Commitment? commitment = Commitment.finalized,
    required Encoding encoding,
    DataSlice? dataSlice,
    List<ProgramDataFilter>? filters,
    bool? withContext,
    num? minContextSlot,
  }) async {
    final dynamic result = await _jsonRpcClient.request(
      'getProgramAccounts',
      params: [
        pubKey,
        {
          if (commitment != null) 'commitment': commitment.value,
          'encoding': encoding.value,
          if (dataSlice != null) 'dataSlice': dataSlice.toJson(),
          if (filters != null)
            'filters': filters.map((filter) => filter.toJson()).toList(),
          if (withContext != null) 'withContext': withContext,
          if (minContextSlot != null) 'minContextSlot': minContextSlot,
        },
      ],
    );
    return (result as List<dynamic>)
        .map((dynamic item) =>
            ProgramAccount.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<PerfSample>> getRecentPerformanceSamples(int? limit) async {
    final dynamic result = await _jsonRpcClient.request(
      'getRecentPerformanceSamples',
      params: [limit],
    );
    return (result as List<dynamic>)
        .map(
            (dynamic item) => PerfSample.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<TransactionSignatureInformation>> getSignaturesForAddress(
    String pubKey, {
    int? limit,
    String? before,
    String? until,
    Commitment? commitment = Commitment.finalized,
    num? minContextSlot,
  }) async {
    final dynamic result = await _jsonRpcClient.request(
      'getSignaturesForAddress',
      params: [
        pubKey,
        {
          if (limit != null) 'limit': limit,
          if (before != null) 'before': before,
          if (until != null) 'until': until,
          if (commitment != null) 'commitment': commitment.value,
          if (minContextSlot != null) 'minContextSlot': minContextSlot,
        },
      ],
    );

    if (result is List<dynamic>) {
      return result
          .map((dynamic item) => TransactionSignatureInformation.fromJson(
              item as Map<String, dynamic>))
          .toList();
    } else if (result is Map<String, dynamic>) {
      final List<dynamic> signatures = result['result'] as List<dynamic>;
      return signatures
          .map((dynamic item) => TransactionSignatureInformation.fromJson(
              item as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Unexpected response format: $result');
    }
  }

  @override
  Future<SignatureStatusesResult> getSignatureStatuses(
    List<String> signatures, {
    bool? searchTransactionHistory,
  }) async {
    final dynamic result = await _jsonRpcClient.request(
      'getSignatureStatuses',
      params: [
        signatures,
        {
          if (searchTransactionHistory != null)
            'searchTransactionHistory': searchTransactionHistory,
        },
      ],
    );
    return SignatureStatusesResult.fromJson(result as Map<String, dynamic>);
  }

  @override
  Future<int> getSlot({
    Commitment? commitment,
    num? minContextSlot,
  }) async {
    final dynamic result = await _jsonRpcClient.request(
      'getSlot',
      params: [
        {
          if (commitment != null) 'commitment': commitment.value,
          if (minContextSlot != null) 'minContextSlot': minContextSlot,
        },
      ],
    );
    // Make sure that the result has a 'result' key.
    if (result is! Map<String, dynamic> || !result.containsKey('result')) {
      throw Exception('Unexpected response format: $result');
    }
    return result['result'] as int;
  }

  @override
  Future<String> getSlotLeader({
    Commitment? commitment,
    num? minContextSlot,
  }) async {
    final dynamic result = await _jsonRpcClient.request(
      'getSlotLeader',
      params: [
        {
          if (commitment != null) 'commitment': commitment.value,
          if (minContextSlot != null) 'minContextSlot': minContextSlot,
        },
      ],
    );
    return result as String;
  }

  @override
  Future<List<String>> getSlotLeaders(
    int startSlot,
    int limit,
  ) async {
    final dynamic result = await _jsonRpcClient.request(
      'getSlotLeaders',
      params: [startSlot, limit],
    );
    return (result as List<dynamic>).cast<String>();
  }

  @override
  Future<StakeActivation> getStakeActivation(
    String pubKey, {
    Commitment? commitment = Commitment.finalized,
    int? epoch,
    num? minContextSlot,
  }) async {
    final dynamic result = await _jsonRpcClient.request(
      'getStakeActivation',
      params: [
        pubKey,
        {
          if (commitment != null) 'commitment': commitment.value,
          if (epoch != null) 'epoch': epoch,
          if (minContextSlot != null) 'minContextSlot': minContextSlot,
        },
      ],
    );
    return StakeActivation.fromJson(result as Map<String, dynamic>);
  }

  @override
  Future<StakeMinimumDelegationResult> getStakeMinimumDelegation(
      {Commitment? commitment}) async {
    final dynamic result = await _jsonRpcClient.request(
      'getStakeMinimumDelegation',
      params: [
        {
          if (commitment != null) 'commitment': commitment.value,
        },
      ],
    );
    return StakeMinimumDelegationResult.fromJson(
        result as Map<String, dynamic>);
  }

  @override
  Future<SupplyResult> getSupply({
    Commitment commitment = Commitment.finalized,
    bool? excludeNonCirculatingAccountsList,
  }) async {
    final dynamic result = await _jsonRpcClient.request(
      'getSupply',
      params: [
        {
          'commitment': commitment.value,
          if (excludeNonCirculatingAccountsList != null)
            'excludeNonCirculatingAccountsList':
                excludeNonCirculatingAccountsList,
        },
      ],
    );
    return SupplyResult.fromJson(result as Map<String, dynamic>);
  }

  @override
  Future<TokenAmountResult> getTokenAccountBalance(
    String pubKey, {
    Commitment? commitment,
  }) async {
    final dynamic result = await _jsonRpcClient.request(
      'getTokenAccountBalance',
      params: [
        pubKey,
        {
          if (commitment != null) 'commitment': commitment.value,
        },
      ],
    );
    return TokenAmountResult.fromJson(result as Map<String, dynamic>);
  }

  @override
  Future<ProgramAccountsResult> getTokenAccountsByDelegate(
    String pubKey,
    TokenAccountsFilter filter, {
    Commitment commitment = Commitment.finalized,
    Encoding? encoding,
    DataSlice? dataSlice,
    num? minContextSlot,
  }) async {
    final dynamic result = await _jsonRpcClient.request(
      'getTokenAccountsByDelegate',
      params: [
        pubKey,
        filter.toJson(),
        {
          'commitment': commitment.value,
          if (encoding != null) 'encoding': encoding.value,
          if (dataSlice != null) 'dataSlice': dataSlice.toJson(),
          if (minContextSlot != null) 'minContextSlot': minContextSlot,
        },
      ],
    );
    return ProgramAccountsResult.fromJson(result as Map<String, dynamic>);
  }

  @override
  Future<ProgramAccountsResult> getTokenAccountsByOwner(
    String pubKey,
    TokenAccountsFilter filter, {
    Commitment commitment = Commitment.finalized,
    Encoding? encoding,
    DataSlice? dataSlice,
    num? minContextSlot,
  }) async {
    final dynamic result = await _jsonRpcClient.request(
      'getTokenAccountsByOwner',
      params: [
        pubKey,
        filter.toJson(),
        {
          'commitment': commitment.value,
          if (encoding != null) 'encoding': encoding.value,
          if (dataSlice != null) 'dataSlice': dataSlice.toJson(),
          if (minContextSlot != null) 'minContextSlot': minContextSlot,
        },
      ],
    );
    return ProgramAccountsResult.fromJson(result as Map<String, dynamic>);
  }

  @override
  Future<TokenLargestAccountsResult> getTokenLargestAccounts(
    String pubKey, {
    Commitment? commitment,
  }) async {
    final dynamic result = await _jsonRpcClient.request(
      'getTokenLargestAccounts',
      params: [
        pubKey,
        {
          if (commitment != null) 'commitment': commitment.value,
        },
      ],
    );
    return TokenLargestAccountsResult.fromJson(result as Map<String, dynamic>);
  }

  @override
  Future<TokenAmountResult> getTokenSupply(
    String mint, {
    Commitment? commitment,
  }) async {
    final dynamic result = await _jsonRpcClient.request(
      'getTokenSupply',
      params: [
        mint,
        {
          if (commitment != null) 'commitment': commitment.value,
        },
      ],
    );
    return TokenAmountResult.fromJson(result as Map<String, dynamic>);
  }

  @override
  Future<TransactionDetails?> getTransaction(
    String signature, {
    Encoding? encoding,
    Commitment? commitment = Commitment.finalized,
    num? maxSupportedTransactionVersion = 0,
  }) async {
    final dynamic result = await _jsonRpcClient.request(
      'getTransaction',
      params: [
        signature,
        {
          if (encoding != null) 'encoding': encoding.value,
          if (commitment != null) 'commitment': commitment.value,
          'maxSupportedTransactionVersion': maxSupportedTransactionVersion,
        },
      ],
    );
    return result != null
        ? TransactionDetails.fromJson(result as Map<String, dynamic>)
        : null;
  }

  @override
  Future<int> getTransactionCount({
    Commitment? commitment,
    num? minContextSlot,
  }) async {
    final dynamic result = await _jsonRpcClient.request(
      'getTransactionCount',
      params: [
        {
          if (commitment != null) 'commitment': commitment.value,
          if (minContextSlot != null) 'minContextSlot': minContextSlot,
        },
      ],
    );
    return result as int;
  }

  @override
  Future<SolanaVersion> getVersion() async {
    final dynamic result = await _jsonRpcClient.request('getVersion');
    return SolanaVersion.fromJson(result as Map<String, dynamic>);
  }

  @override
  Future<VoteAccounts> getVoteAccounts({
    Commitment? commitment = Commitment.finalized,
    String? votePubKey,
    bool? keepUnstakedDelinquents,
    int? delinquentSlotDistance,
  }) async {
    final dynamic result = await _jsonRpcClient.request(
      'getVoteAccounts',
      params: [
        {
          if (commitment != null) 'commitment': commitment.value,
          if (votePubKey != null) 'votePubKey': votePubKey,
          if (keepUnstakedDelinquents != null)
            'keepUnstakedDelinquents': keepUnstakedDelinquents,
          if (delinquentSlotDistance != null)
            'delinquentSlotDistance': delinquentSlotDistance,
        },
      ],
    );
    return VoteAccounts.fromJson(result as Map<String, dynamic>);
  }

  @override
  Future<BlockhasValidResult> isBlockhashValid(
    String blockhash, {
    Commitment? commitment,
    num? minContextSlot,
  }) async {
    final dynamic result = await _jsonRpcClient.request(
      'isBlockhashValid',
      params: [
        blockhash,
        {
          if (commitment != null) 'commitment': commitment.value,
          if (minContextSlot != null) 'minContextSlot': minContextSlot,
        },
      ],
    );
    return BlockhasValidResult.fromJson(result as Map<String, dynamic>);
  }

  @override
  Future<int> minimumLedgerSlot() async {
    final dynamic result = await _jsonRpcClient.request('minimumLedgerSlot');
    return result as int;
  }

  @override
  Future<TransactionId> requestAirdrop(
    String pubKey,
    int lamports, {
    Commitment? commitment,
  }) async {
    final dynamic result = await _jsonRpcClient.request(
      'requestAirdrop',
      params: [
        pubKey,
        lamports,
        {
          if (commitment != null) 'commitment': commitment.value,
        },
      ],
    );

    return result as TransactionId;
  }

  @override
  Future<TransactionId> sendTransaction(
    String transaction, {
    Encoding encoding = Encoding.base64,
    Commitment? preflightCommitment = Commitment.finalized,
    bool? skipPreflight = false,
    int? maxRetries,
    num? minContextSlot,
  }) async {
    final dynamic result = await _jsonRpcClient.request(
      'sendTransaction',
      params: [
        transaction,
        {
          'encoding': encoding.value,
          if (preflightCommitment != null)
            'preflightCommitment': preflightCommitment.value,
          'skipPreflight': skipPreflight,
          if (maxRetries != null) 'maxRetries': maxRetries,
          if (minContextSlot != null) 'minContextSlot': minContextSlot,
        },
      ],
    );

    return result as TransactionId;
  }

  @override
  Future<TransactionStatusResult> simulateTransaction(
    String transaction, {
    bool? sigVerify,
    Encoding encoding = Encoding.base64,
    Commitment? commitment = Commitment.finalized,
    bool? replaceRecentBlockhash = false,
    SimulateTransactionAccounts? accounts,
    num? minContextSlot,
  }) async {
    final dynamic result = await _jsonRpcClient.request(
      'simulateTransaction',
      params: [
        transaction,
        {
          if (sigVerify != null) 'sigVerify': sigVerify,
          'encoding': encoding.value,
          if (commitment != null) 'commitment': commitment.value,
          if (replaceRecentBlockhash != null)
            'replaceRecentBlockhash': replaceRecentBlockhash,
          if (accounts != null) 'accounts': accounts.toJson(),
          if (minContextSlot != null) 'minContextSlot': minContextSlot,
        },
      ],
    );
    return TransactionStatusResult.fromJson(result as Map<String, dynamic>);
  }

  @override
  Future<Block> getConfirmedBlock(
    int slot, {
    Encoding? encoding,
    TransactionDetailLevel? transactionDetails,
    bool? rewards = false,
    Commitment? commitment = Commitment.finalized,
  }) async {
    final dynamic result = await _jsonRpcClient.request(
      'getConfirmedBlock',
      params: [
        slot,
        {
          if (encoding != null) 'encoding': encoding.value,
          if (transactionDetails != null)
            'transactionDetails': transactionDetails,
          'rewards': rewards,
          if (commitment != null) 'commitment': commitment.value,
        },
      ],
    );
    return Block.fromJson(result as Map<String, dynamic>);
  }

  @override
  Future<List<int>> getConfirmedBlocks(
    int startSlot,
    int? endSlot,
    Commitment? commitment,
  ) async {
    final dynamic result = await _jsonRpcClient.request(
      'getConfirmedBlocks',
      params: [
        startSlot,
        endSlot,
        {
          if (commitment != null) 'commitment': commitment.value,
        },
      ],
    );
    return (result as List<dynamic>).cast<int>();
  }

  @override
  Future<List<int>> getConfirmedBlocksWithLimit(
    int startSlot,
    int limit,
    Commitment? commitment,
  ) async {
    final dynamic result = await _jsonRpcClient.request(
      'getConfirmedBlocksWithLimit',
      params: [
        startSlot,
        limit,
        {
          if (commitment != null) 'commitment': commitment.value,
        },
      ],
    );
    return (result as List<dynamic>).cast<int>();
  }

  @override
  Future<List<TransactionSignatureInformation>>
      getConfirmedSignaturesForAddress2(
    String pubKey, {
    int? limit,
    String? before,
    String? until,
    Commitment? commitment = Commitment.finalized,
  }) async {
    final dynamic result = await _jsonRpcClient.request(
      'getConfirmedSignaturesForAddress2',
      params: [
        pubKey,
        {
          if (limit != null) 'limit': limit,
          if (before != null) 'before': before,
          if (until != null) 'until': until,
          if (commitment != null) 'commitment': commitment.value,
        },
      ],
    );
    return (result as List<dynamic>)
        .map((dynamic item) => TransactionSignatureInformation.fromJson(
            item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<TransactionDetails?> getConfirmedTransaction(
    String signature, {
    Encoding? encoding = Encoding.base64,
    Commitment? commitment = Commitment.finalized,
  }) async {
    final dynamic result = await _jsonRpcClient.request(
      'getConfirmedTransaction',
      params: [
        signature,
        {
          'encoding': encoding?.value,
          if (commitment != null) 'commitment': commitment.value,
        },
      ],
    );
    return result != null
        ? TransactionDetails.fromJson(result as Map<String, dynamic>)
        : null;
  }

  @override
  Future<FeeCalculatorForBlockhashResult> getFeeCalculatorForBlockhash(
    String blockhash, {
    Commitment? commitment,
  }) async {
    final dynamic result = await _jsonRpcClient.request(
      'getFeeCalculatorForBlockhash',
      params: [
        blockhash,
        {
          if (commitment != null) 'commitment': commitment.value,
        },
      ],
    );
    return FeeCalculatorForBlockhashResult.fromJson(
        result as Map<String, dynamic>);
  }

  @override
  Future<FeeRateGovernor> getFeeRateGovernor() async {
    final dynamic result = await _jsonRpcClient.request('getFeeRateGovernor');
    return FeeRateGovernor.fromJson(result as Map<String, dynamic>);
  }

  @override
  Future<FeesResult> getFees({Commitment? commitment}) async {
    final dynamic result = await _jsonRpcClient.request(
      'getFees',
      params: [
        {
          if (commitment != null) 'commitment': commitment.value,
        },
      ],
    );
    return FeesResult.fromJson(result as Map<String, dynamic>);
  }

  @override
  Future<RecentBlockhashResult> getRecentBlockhash(
      {Commitment? commitment}) async {
    final dynamic result = await _jsonRpcClient.request(
      'getRecentBlockhash',
      params: [
        {
          if (commitment != null) 'commitment': commitment.value,
        },
      ],
    );
    return RecentBlockhashResult.fromJson(result as Map<String, dynamic>);
  }

  @override
  Future<int> getSnapshotSlot() async {
    final dynamic result = await _jsonRpcClient.request('getSnapshotSlot');
    return result as int;
  }
}
