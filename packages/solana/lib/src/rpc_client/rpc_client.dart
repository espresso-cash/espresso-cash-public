import 'dart:async';

import 'package:solana/src/rpc_client/helper_types/response.dart';
import 'package:solana/src/rpc_client/helper_types/rpc_response.dart';
import 'package:solana/src/rpc_client/rpc_types.dart';
import 'package:solana/src/rpc_client/json_rpc_client.dart';

class RPCClient {
  /// Constructs a SolanaClient that is capable of sending various RPCs to')
  /// [rpcUrl].
  RPCClient(String rpcUrl) : _client = JsonRpcClient(rpcUrl);

  final JsonRpcClient _client;
  Future<Account> getAccountInfo({
    required String pubKey,
    Commitment? commitment,
    required Encoding encoding,
    int? offset,
    int? length,
  }) async {
    final data = await _client.request('getAccountInfo', params: <dynamic>[
      pubKey,
      <String, dynamic>{
        'commitment': commitment,
        'encoding': encoding,
        'dataSlice': <String, dynamic>{
          'offset': offset,
          'length': length,
        },
      },
    ]);
    final response = Response<RpcResponse<Account>>.fromJson(
      data,
      (Object? data) => RpcResponse<Account>.fromJson(
        data as Map<String, dynamic>,
        (Object? data) => Account.fromJson(data as Map<String, dynamic>),
      ),
    );
    final rpcResponse = response.result;

    return rpcResponse.value;
  }

  Future<int> getBalance({
    required String pubKey,
    CommitmentObject? commitment,
  }) async {
    final data = await _client.request('getBalance', params: <dynamic>[
      pubKey,
      commitment,
    ]);
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

  Future<Block> getBlock({
    required int slot,
    Encoding? encoding,
    String? transactionDetails,
    bool? rewards,
    Commitment? commitment,
  }) async {
    final data = await _client.request('getBlock', params: <dynamic>[
      slot,
      <String, dynamic>{
        'encoding': encoding,
        'transactionDetails': transactionDetails,
        'rewards': rewards,
        'commitment': commitment,
      },
    ]);
    final response = Response<Block>.fromJson(
      data,
      (Object? data) => Block.fromJson(data as Map<String, dynamic>),
    );

    return response.result;
  }

  Future<int> getBlockHeight({
    CommitmentObject? commitment,
  }) async {
    final data = await _client.request('getBlockHeight', params: <dynamic>[
      commitment,
    ]);
    final response = Response<int>.fromJson(
      data,
      (Object? data) => data as int,
    );

    return response.result;
  }

  Future<BlockProduction> getBlockProduction({
    Commitment? commitment,
    required int firstSlot,
    int? lastSlot,
    String? identity,
  }) async {
    final data = await _client.request('getBlockProduction', params: <dynamic>[
      <String, dynamic>{
        'commitment': commitment,
        'range': <String, dynamic>{
          'firstSlot': firstSlot,
          'lastSlot': lastSlot,
        },
        'identity': identity,
      },
    ]);
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

  Future<BlockCommitment> getBlockCommitment({
    required int block,
  }) async {
    final data = await _client.request('getBlockCommitment', params: <dynamic>[
      block,
    ]);
    final response = Response<BlockCommitment>.fromJson(
      data,
      (Object? data) => BlockCommitment.fromJson(data as Map<String, dynamic>),
    );

    return response.result;
  }

  Future<List<int>> getBlocks({
    required int startSlot,
    int? endSlot,
    Commitment? commitment,
  }) async {
    final data = await _client.request('getBlocks', params: <dynamic>[
      startSlot,
      endSlot,
      commitment,
    ]);
    final response = Response<List<int>>.fromJson(
      data,
      (Object? data) => data as List<int>,
    );

    return response.result;
  }

  Future<List<int>> getBlocksWithLimit({
    required int startSlot,
    required int limit,
    Commitment? commitment,
  }) async {
    final data = await _client.request('getBlocksWithLimit', params: <dynamic>[
      startSlot,
      limit,
      commitment,
    ]);
    final response = Response<List<int>>.fromJson(
      data,
      (Object? data) => data as List<int>,
    );

    return response.result;
  }

  Future<int> getBlockTime({
    required int block,
  }) async {
    final data = await _client.request('getBlockTime', params: <dynamic>[
      block,
    ]);
    final response = Response<int>.fromJson(
      data,
      (Object? data) => data as int,
    );

    return response.result;
  }

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

  Future<EpochInfo> getEpochInfo({
    CommitmentObject? commitment,
  }) async {
    final data = await _client.request('getEpochInfo', params: <dynamic>[
      commitment,
    ]);
    final response = Response<EpochInfo>.fromJson(
      data,
      (Object? data) => EpochInfo.fromJson(data as Map<String, dynamic>),
    );

    return response.result;
  }

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

  Future<FeeCalculator> getFeeCalculatorForBlockhash({
    required String blockhash,
    CommitmentObject? commitment,
  }) async {
    final data =
        await _client.request('getFeeCalculatorForBlockhash', params: <dynamic>[
      blockhash,
      commitment,
    ]);
    final response = Response<FeeCalculator>.fromJson(
      data,
      (Object? data) => FeeCalculator.fromJson(data as Map<String, dynamic>),
    );

    return response.result;
  }

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

  Future<Fees> getFees({
    CommitmentObject? commitment,
  }) async {
    final data = await _client.request('getFees', params: <dynamic>[
      commitment,
    ]);
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

  Future<InflationGovernor> getInflationGovernor({
    CommitmentObject? commitment,
  }) async {
    final data =
        await _client.request('getInflationGovernor', params: <dynamic>[
      commitment,
    ]);
    final response = Response<InflationGovernor>.fromJson(
      data,
      (Object? data) =>
          InflationGovernor.fromJson(data as Map<String, dynamic>),
    );

    return response.result;
  }

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

  Future<List<InflationReward>> getInflationReward({
    required List<String> addresses,
  }) async {
    final data = await _client.request('getInflationReward', params: <dynamic>[
      addresses,
    ]);
    final response = Response<List<InflationReward>>.fromJson(
      data,
      (Object? data) => (data as List<dynamic>)
          .map((dynamic data) =>
              InflationReward.fromJson(data as Map<String, dynamic>))
          .toList(growable: false),
    );

    return response.result;
  }

  Future<List<LargeAccount>> getLargestAccounts({
    Commitment? commitment,
    CirculationStatus? filter,
  }) async {
    final data = await _client.request('getLargestAccounts', params: <dynamic>[
      <String, dynamic>{
        'commitment': commitment,
        'filter': filter,
      },
    ]);
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

  Future<LeaderSchedule> getLeaderSchedule({
    int? slot,
    Commitment? commitment,
    String? identity,
  }) async {
    final data = await _client.request('getLeaderSchedule', params: <dynamic>[
      slot,
      <String, dynamic>{
        'commitment': commitment,
        'identity': identity,
      },
    ]);
    final response = Response<LeaderSchedule>.fromJson(
      data,
      (Object? data) => data as LeaderSchedule,
    );

    return response.result;
  }

  Future<int> getMaxRetransmitSlot({
    required int slot,
  }) async {
    final data =
        await _client.request('getMaxRetransmitSlot', params: <dynamic>[
      slot,
    ]);
    final response = Response<int>.fromJson(
      data,
      (Object? data) => data as int,
    );

    return response.result;
  }

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

  Future<int> getMinimumBalanceForRentExemption({
    required int accountDataLength,
    CommitmentObject? commitment,
  }) async {
    final data = await _client
        .request('getMinimumBalanceForRentExemption', params: <dynamic>[
      accountDataLength,
      commitment,
    ]);
    final response = Response<int>.fromJson(
      data,
      (Object? data) => data as int,
    );

    return response.result;
  }

  Future<List<Account>> getMultipleAccounts({
    required List<String> pubKey,
    Commitment? commitment,
    required Encoding encoding,
    int? offset,
    int? length,
  }) async {
    final data = await _client.request('getMultipleAccounts', params: <dynamic>[
      pubKey,
      <String, dynamic>{
        'commitment': commitment,
        'encoding': encoding,
        'dataSlice': <String, dynamic>{
          'offset': offset,
          'length': length,
        },
      },
    ]);
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

  Future<List<ProgramAccount>> getProgramAccounts({
    required String pubKey,
    Commitment? commitment,
    required Encoding encoding,
    int? offset,
    int? length,
    List<Filter>? filters,
    bool? withContext,
  }) async {
    final data = await _client.request('getProgramAccounts', params: <dynamic>[
      pubKey,
      <String, dynamic>{
        'commitment': commitment,
        'encoding': encoding,
        'dataSlice': <String, dynamic>{
          'offset': offset,
          'length': length,
        },
        'filters': filters,
        'withContext': withContext,
      },
    ]);
    final response = Response<List<ProgramAccount>>.fromJson(
      data,
      (Object? data) => (data as List<dynamic>)
          .map((dynamic data) =>
              ProgramAccount.fromJson(data as Map<String, dynamic>))
          .toList(growable: false),
    );

    return response.result;
  }

  Future<RecentBlockhash> getRecentBlockhash({
    CommitmentObject? commitment,
  }) async {
    final data = await _client.request('getRecentBlockhash', params: <dynamic>[
      commitment,
    ]);
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

  Future<List<PerfSample>> getRecentPerformanceSamples({
    int? limit,
  }) async {
    final data =
        await _client.request('getRecentPerformanceSamples', params: <dynamic>[
      limit,
    ]);
    final response = Response<List<PerfSample>>.fromJson(
      data,
      (Object? data) => (data as List<dynamic>)
          .map((dynamic data) =>
              PerfSample.fromJson(data as Map<String, dynamic>))
          .toList(growable: false),
    );

    return response.result;
  }

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

  Future<List<TransactionSignatureInformation>> getSignaturesForAddress({
    required String pubKey,
    int? limit,
    String? before,
    String? until,
    Commitment? commitment,
  }) async {
    final data =
        await _client.request('getSignaturesForAddress', params: <dynamic>[
      pubKey,
      <String, dynamic>{
        'limit': limit,
        'before': before,
        'until': until,
        'commitment': commitment,
      },
    ]);
    final response = Response<List<TransactionSignatureInformation>>.fromJson(
      data,
      (Object? data) => (data as List<dynamic>)
          .map((dynamic data) => TransactionSignatureInformation.fromJson(
              data as Map<String, dynamic>))
          .toList(growable: false),
    );

    return response.result;
  }

  Future<SignatureStatus> getSignatureStatuses({
    required List<String> signatures,
    required bool searchTransactionHistory,
  }) async {
    final data =
        await _client.request('getSignatureStatuses', params: <dynamic>[
      signatures,
      <String, dynamic>{
        'searchTransactionHistory': searchTransactionHistory,
      },
    ]);
    final response = Response<RpcResponse<SignatureStatus>>.fromJson(
      data,
      (Object? data) => RpcResponse<SignatureStatus>.fromJson(
        data as Map<String, dynamic>,
        (Object? data) =>
            SignatureStatus.fromJson(data as Map<String, dynamic>),
      ),
    );
    final rpcResponse = response.result;

    return rpcResponse.value;
  }

  Future<int> getSlot({
    CommitmentObject? commitment,
  }) async {
    final data = await _client.request('getSlot', params: <dynamic>[
      commitment,
    ]);
    final response = Response<int>.fromJson(
      data,
      (Object? data) => data as int,
    );

    return response.result;
  }

  Future<String> getSlotLeader({
    CommitmentObject? commitment,
  }) async {
    final data = await _client.request('getSlotLeader', params: <dynamic>[
      commitment,
    ]);
    final response = Response<String>.fromJson(
      data,
      (Object? data) => data as String,
    );

    return response.result;
  }

  Future<List<String>> getSlotLeaders({
    required int startSlot,
    required int limit,
  }) async {
    final data = await _client.request('getSlotLeaders', params: <dynamic>[
      startSlot,
      limit,
    ]);
    final response = Response<List<String>>.fromJson(
      data,
      (Object? data) => (data as List<dynamic>)
          .map((dynamic data) => data as String)
          .toList(growable: false),
    );

    return response.result;
  }

  Future<StakeActivation> getStakeActivation({
    required String pubKey,
    Commitment? commitment,
    int? epoch,
  }) async {
    final data = await _client.request('getStakeActivation', params: <dynamic>[
      pubKey,
      <String, dynamic>{
        'commitment': commitment,
        'epoch': epoch,
      },
    ]);
    final response = Response<StakeActivation>.fromJson(
      data,
      (Object? data) => StakeActivation.fromJson(data as Map<String, dynamic>),
    );

    return response.result;
  }

  Future<Supply> getSupply({
    Commitment? commitment,
    bool? excludeNonCirculatingAccountsList,
  }) async {
    final data = await _client.request('getSupply', params: <dynamic>[
      <String, dynamic>{
        'commitment': commitment,
        'excludeNonCirculatingAccountsList': excludeNonCirculatingAccountsList,
      },
    ]);
    final response = Response<Supply>.fromJson(
      data,
      (Object? data) => Supply.fromJson(data as Map<String, dynamic>),
    );

    return response.result;
  }

  Future<TokenAmount> getTokenAccountBalance({
    required String pubKey,
    CommitmentObject? commitment,
  }) async {
    final data =
        await _client.request('getTokenAccountBalance', params: <dynamic>[
      pubKey,
      commitment,
    ]);
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

  Future<List<ProgramAccount>> getTokenAccountsByDelegate({
    required String pubKey,
    String? mint,
    String? programId,
    Commitment? commitment,
    required Encoding encoding,
    int? offset,
    int? length,
  }) async {
    final data =
        await _client.request('getTokenAccountsByDelegate', params: <dynamic>[
      pubKey,
      <String, dynamic>{
        'mint': mint,
        'programId': programId,
      },
      <String, dynamic>{
        'commitment': commitment,
        'encoding': encoding,
        'dataSlice': <String, dynamic>{
          'offset': offset,
          'length': length,
        },
      },
    ]);
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

  Future<List<ProgramAccount>> getTokenAccountsByOwner({
    required String pubKey,
    String? mint,
    String? programId,
    Commitment? commitment,
    required Encoding encoding,
    int? offset,
    int? length,
  }) async {
    final data =
        await _client.request('getTokenAccountsByOwner', params: <dynamic>[
      pubKey,
      <String, dynamic>{
        'mint': mint,
        'programId': programId,
      },
      <String, dynamic>{
        'commitment': commitment,
        'encoding': encoding,
        'dataSlice': <String, dynamic>{
          'offset': offset,
          'length': length,
        },
      },
    ]);
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

  Future<List<ProgramAccount>> getTokenLargestAccounts({
    required String pubKey,
    CommitmentObject? commitment,
  }) async {
    final data =
        await _client.request('getTokenLargestAccounts', params: <dynamic>[
      pubKey,
      commitment,
    ]);
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

  Future<TokenAmount> getTokenSupply({
    required String pubKey,
    CommitmentObject? commitment,
  }) async {
    final data = await _client.request('getTokenSupply', params: <dynamic>[
      pubKey,
      commitment,
    ]);
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

  Future<TransactionDetails> getTransaction({
    required String signature,
    Encoding? encoding,
    Commitment? commitment,
  }) async {
    final data = await _client.request('getTransaction', params: <dynamic>[
      signature,
      <String, dynamic>{
        'encoding': encoding,
        'commitment': commitment,
      },
    ]);
    final response = Response<TransactionDetails>.fromJson(
      data,
      (Object? data) =>
          TransactionDetails.fromJson(data as Map<String, dynamic>),
    );

    return response.result;
  }

  Future<int> getTransactionCount({
    CommitmentObject? commitment,
  }) async {
    final data = await _client.request('getTransactionCount', params: <dynamic>[
      commitment,
    ]);
    final response = Response<int>.fromJson(
      data,
      (Object? data) => data as int,
    );

    return response.result;
  }

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

  Future<VoteAccounts> getVoteAccounts({
    Commitment? commitment,
    String? votePubKey,
    bool? keepUnstakedDelinquents,
    int? delinquentSlotDistance,
  }) async {
    final data = await _client.request('getVoteAccounts', params: <dynamic>[
      <String, dynamic>{
        'commitment': commitment,
        'votePubKey': votePubKey,
        'keepUnstakedDelinquents': keepUnstakedDelinquents,
        'delinquentSlotDistance': delinquentSlotDistance,
      },
    ]);
    final response = Response<VoteAccounts>.fromJson(
      data,
      (Object? data) => VoteAccounts.fromJson(data as Map<String, dynamic>),
    );

    return response.result;
  }

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

  Future<String> requestAirdrop({
    required String pubKey,
    required int lamports,
    CommitmentObject? commitment,
  }) async {
    final data = await _client.request('requestAirdrop', params: <dynamic>[
      pubKey,
      lamports,
      commitment,
    ]);
    final response = Response<String>.fromJson(
      data,
      (Object? data) => data as String,
    );

    return response.result;
  }

  Future<String> sendTransaction({
    required String transaction,
    required bool skipPreflight,
    Commitment? preflightCommitment,
    Encoding? encoding,
    int? maxRetries,
  }) async {
    final data = await _client.request('sendTransaction', params: <dynamic>[
      transaction,
      <String, dynamic>{
        'skipPreflight': skipPreflight,
        'preflightCommitment': preflightCommitment,
        'encoding': encoding,
        'maxRetries': maxRetries,
      },
    ]);
    final response = Response<String>.fromJson(
      data,
      (Object? data) => data as String,
    );

    return response.result;
  }

  Future<TransactionStatus> simulateTransaction({
    required String transaction,
    required bool sigVerify,
    Commitment? commitment,
    Encoding? encoding,
    bool? replaceRecentBlockhash,
    Encoding? accountEncoding,
    required List<String> addresses,
  }) async {
    final data = await _client.request('simulateTransaction', params: <dynamic>[
      transaction,
      <String, dynamic>{
        'sigVerify': sigVerify,
        'commitment': commitment,
        'encoding': encoding,
        'replaceRecentBlockhash': replaceRecentBlockhash,
        'accounts': <String, dynamic>{
          'accountEncoding': accountEncoding,
          'addresses': addresses,
        },
      },
    ]);
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

  Future<Block> getConfirmedBlock({
    required int slot,
    Encoding? encoding,
    String? transactionDetails,
    bool? rewards,
    Commitment? commitment,
  }) async {
    final data = await _client.request('getConfirmedBlock', params: <dynamic>[
      slot,
      <String, dynamic>{
        'encoding': encoding,
        'transactionDetails': transactionDetails,
        'rewards': rewards,
        'commitment': commitment,
      },
    ]);
    final response = Response<Block>.fromJson(
      data,
      (Object? data) => Block.fromJson(data as Map<String, dynamic>),
    );

    return response.result;
  }

  Future<List<int>> getConfirmedBlocks({
    required int startSlot,
    int? endSlot,
    Commitment? commitment,
  }) async {
    final data = await _client.request('getConfirmedBlocks', params: <dynamic>[
      startSlot,
      endSlot,
      commitment,
    ]);
    final response = Response<List<int>>.fromJson(
      data,
      (Object? data) => data as List<int>,
    );

    return response.result;
  }

  Future<List<int>> getConfirmedBlocksWithLimit({
    required int startSlot,
    required int limit,
    Commitment? commitment,
  }) async {
    final data =
        await _client.request('getConfirmedBlocksWithLimit', params: <dynamic>[
      startSlot,
      limit,
      commitment,
    ]);
    final response = Response<List<int>>.fromJson(
      data,
      (Object? data) => data as List<int>,
    );

    return response.result;
  }

  Future<List<TransactionSignatureInformation>>
      getConfirmedSignaturesForAddress2({
    required String pubKey,
    int? limit,
    String? before,
    String? until,
    Commitment? commitment,
  }) async {
    final data = await _client
        .request('getConfirmedSignaturesForAddress2', params: <dynamic>[
      pubKey,
      <String, dynamic>{
        'limit': limit,
        'before': before,
        'until': until,
        'commitment': commitment,
      },
    ]);
    final response = Response<List<TransactionSignatureInformation>>.fromJson(
      data,
      (Object? data) => (data as List<dynamic>)
          .map((dynamic data) => TransactionSignatureInformation.fromJson(
              data as Map<String, dynamic>))
          .toList(growable: false),
    );

    return response.result;
  }

  Future<TransactionDetails> getConfirmedTransaction({
    required String signature,
    Encoding? encoding,
    Commitment? commitment,
  }) async {
    final data =
        await _client.request('getConfirmedTransaction', params: <dynamic>[
      signature,
      <String, dynamic>{
        'encoding': encoding,
        'commitment': commitment,
      },
    ]);
    final response = Response<TransactionDetails>.fromJson(
      data,
      (Object? data) =>
          TransactionDetails.fromJson(data as Map<String, dynamic>),
    );

    return response.result;
  }
}
