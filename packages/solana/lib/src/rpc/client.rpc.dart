// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// ClientGenerator
// **************************************************************************

class _RpcClient implements RpcClient {
  _RpcClient(String url) : _client = JsonRpcClient(url);

  final JsonRpcClient _client;

  @override
  Future<Account> getAccountInfo(String pubKey,
      {required Commitment commitment,
      required Encoding encoding,
      required DataSlice dataSlice}) async {
    final config = GetAccountInfoConfig(commitment, encoding, dataSlice).value;
    final data = await _client.request(
      'getAccountInfo',
      params: <dynamic>[
        pubKey,
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _unwrapAndGetResult(data);

    return Account.fromJson(value as Map<String, dynamic>);
  }

  @override
  Future<int> getBalance(String pubKey, {Commitment? commitment}) async {
    final config = GetBalanceConfig(commitment).value;
    final data = await _client.request(
      'getBalance',
      params: <dynamic>[
        pubKey,
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _unwrapAndGetResult(data);

    return value as int;
  }

  @override
  Future<Block> getBlock(int slot,
      {required Encoding encoding,
      required TransactionDetailLevel transactionDetails,
      required bool rewards,
      required Commitment commitment}) async {
    final config =
        GetBlockConfig(encoding, transactionDetails, rewards, commitment).value;
    final data = await _client.request(
      'getBlock',
      params: <dynamic>[
        slot,
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _getResult(data);

    return Block.fromJson(value as Map<String, dynamic>);
  }

  @override
  Future<int> getBlockHeight({Commitment? commitment}) async {
    final config = GetBlockHeightConfig(commitment).value;
    final data = await _client.request(
      'getBlockHeight',
      params: <dynamic>[
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _getResult(data);

    return value as int;
  }

  @override
  Future<BlockProduction> getBlockProduction(
      {required Commitment commitment,
      required Range range,
      required String identity}) async {
    final config = GetBlockProductionConfig(commitment, range, identity).value;
    final data = await _client.request(
      'getBlockProduction',
      params: <dynamic>[
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _unwrapAndGetResult(data);

    return BlockProduction.fromJson(value as Map<String, dynamic>);
  }

  @override
  Future<BlockCommitment> getBlockCommitment(int block) async {
    final config = <String, dynamic>{};
    final data = await _client.request(
      'getBlockCommitment',
      params: <dynamic>[
        block,
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _getResult(data);

    return BlockCommitment.fromJson(value as Map<String, dynamic>);
  }

  @override
  Future<List<int>> getBlocks(int startSlot, int endSlot,
      {Commitment? commitment}) async {
    final config = GetBlocksConfig(commitment).value;
    final data = await _client.request(
      'getBlocks',
      params: <dynamic>[
        startSlot,
        endSlot,
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _getResult(data);

    return _fromJsonArray(value, (dynamic v) => v as int);
  }

  @override
  Future<List<int>> getBlocksWithLimit(int startSlot, int limit,
      {Commitment? commitment}) async {
    final config = GetBlocksWithLimitConfig(commitment).value;
    final data = await _client.request(
      'getBlocksWithLimit',
      params: <dynamic>[
        startSlot,
        limit,
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _getResult(data);

    return _fromJsonArray(value, (dynamic v) => v as int);
  }

  @override
  Future<int> getBlockTime(int block) async {
    final config = <String, dynamic>{};
    final data = await _client.request(
      'getBlockTime',
      params: <dynamic>[
        block,
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _getResult(data);

    return value as int;
  }

  @override
  Future<List<ClusterNode>> getClusterNodes() async {
    final config = <String, dynamic>{};
    final data = await _client.request(
      'getClusterNodes',
      params: <dynamic>[
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _getResult(data);

    return _fromJsonArray(
        value, (dynamic v) => ClusterNode.fromJson(v as Map<String, dynamic>));
  }

  @override
  Future<EpochInfo> getEpochInfo({Commitment? commitment}) async {
    final config = GetEpochInfoConfig(commitment).value;
    final data = await _client.request(
      'getEpochInfo',
      params: <dynamic>[
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _getResult(data);

    return EpochInfo.fromJson(value as Map<String, dynamic>);
  }

  @override
  Future<EpochSchedule> getEpochSchedule() async {
    final config = <String, dynamic>{};
    final data = await _client.request(
      'getEpochSchedule',
      params: <dynamic>[
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _getResult(data);

    return EpochSchedule.fromJson(value as Map<String, dynamic>);
  }

  @override
  Future<FeeCalculatorForBlockhash> getFeeCalculatorForBlockhash(
      String blockhash,
      {Commitment? commitment}) async {
    final config = GetFeeCalculatorForBlockhashConfig(commitment).value;
    final data = await _client.request(
      'getFeeCalculatorForBlockhash',
      params: <dynamic>[
        blockhash,
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _unwrapAndGetResult(data);

    return FeeCalculatorForBlockhash.fromJson(value as Map<String, dynamic>);
  }

  @override
  Future<FeeRateGovernor> getFeeRateGovernor() async {
    final config = <String, dynamic>{};
    final data = await _client.request(
      'getFeeRateGovernor',
      params: <dynamic>[
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _getResult(data);

    return FeeRateGovernor.fromJson(value as Map<String, dynamic>);
  }

  @override
  Future<Fees> getFees({Commitment? commitment}) async {
    final config = GetFeesConfig(commitment).value;
    final data = await _client.request(
      'getFees',
      params: <dynamic>[
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _unwrapAndGetResult(data);

    return Fees.fromJson(value as Map<String, dynamic>);
  }

  @override
  Future<int> getFirstAvailableBlock() async {
    final config = <String, dynamic>{};
    final data = await _client.request(
      'getFirstAvailableBlock',
      params: <dynamic>[
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _getResult(data);

    return value as int;
  }

  @override
  Future<String> getGenesisHash() async {
    final config = <String, dynamic>{};
    final data = await _client.request(
      'getGenesisHash',
      params: <dynamic>[
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _getResult(data);

    return value as String;
  }

  @override
  Future<String> getHealth() async {
    final config = <String, dynamic>{};
    final data = await _client.request(
      'getHealth',
      params: <dynamic>[
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _getResult(data);

    return value as String;
  }

  @override
  Future<Identity> getIdentity() async {
    final config = <String, dynamic>{};
    final data = await _client.request(
      'getIdentity',
      params: <dynamic>[
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _getResult(data);

    return Identity.fromJson(value as Map<String, dynamic>);
  }

  @override
  Future<InflationGovernor> getInflationGovernor(
      {Commitment? commitment}) async {
    final config = GetInflationGovernorConfig(commitment).value;
    final data = await _client.request(
      'getInflationGovernor',
      params: <dynamic>[
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _getResult(data);

    return InflationGovernor.fromJson(value as Map<String, dynamic>);
  }

  @override
  Future<InflationRate> getInflationRate() async {
    final config = <String, dynamic>{};
    final data = await _client.request(
      'getInflationRate',
      params: <dynamic>[
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _getResult(data);

    return InflationRate.fromJson(value as Map<String, dynamic>);
  }

  @override
  Future<List<InflationReward>> getInflationReward(String addresses) async {
    final config = <String, dynamic>{};
    final data = await _client.request(
      'getInflationReward',
      params: <dynamic>[
        addresses,
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _getResult(data);

    return _fromJsonArray(value,
        (dynamic v) => InflationReward.fromJson(v as Map<String, dynamic>));
  }

  @override
  Future<List<LargeAccount>> getLargestAccounts(
      {required Commitment commitment,
      required CirculationStatus filter}) async {
    final config = GetLargestAccountsConfig(commitment, filter).value;
    final data = await _client.request(
      'getLargestAccounts',
      params: <dynamic>[
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _unwrapAndGetResult(data);

    return _fromJsonArray(
        value, (dynamic v) => LargeAccount.fromJson(v as Map<String, dynamic>));
  }

  @override
  Future<Map<String, List<int>>> getLeaderSchedule(int slot,
      {required Commitment commitment, required String identity}) async {
    final config = GetLeaderScheduleConfig(commitment, identity).value;
    final data = await _client.request(
      'getLeaderSchedule',
      params: <dynamic>[
        slot,
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _getResult(data);

    return Map<String, List<int>>.fromJson(
        value as Map<String, dynamic>, (json) => json as String);
  }

  @override
  Future<int> getMaxRetransmitSlot() async {
    final config = <String, dynamic>{};
    final data = await _client.request(
      'getMaxRetransmitSlot',
      params: <dynamic>[
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _getResult(data);

    return value as int;
  }

  @override
  Future<int> getMaxShredInsertSlot() async {
    final config = <String, dynamic>{};
    final data = await _client.request(
      'getMaxShredInsertSlot',
      params: <dynamic>[
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _getResult(data);

    return value as int;
  }

  @override
  Future<int> getMinimumBalanceForRentExemption(int accountDataLength,
      {Commitment? commitment}) async {
    final config = GetMinimumBalanceForRentExemptionConfig(commitment).value;
    final data = await _client.request(
      'getMinimumBalanceForRentExemption',
      params: <dynamic>[
        accountDataLength,
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _getResult(data);

    return value as int;
  }

  @override
  Future<List<Account>> getMultipleAccounts(String pubKeys,
      {required Commitment commitment,
      required Encoding encoding,
      required DataSlice dataSlice}) async {
    final config =
        GetMultipleAccountsConfig(commitment, encoding, dataSlice).value;
    final data = await _client.request(
      'getMultipleAccounts',
      params: <dynamic>[
        pubKeys,
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _unwrapAndGetResult(data);

    return _fromJsonArray(
        value, (dynamic v) => Account.fromJson(v as Map<String, dynamic>));
  }

  @override
  Future<List<ProgramAccount>> getProgramAccounts(String pubKey,
      {required Commitment commitment,
      required Encoding encoding,
      required DataSlice dataSlice,
      required Filter filter}) async {
    final config =
        GetProgramAccountsConfig(commitment, encoding, dataSlice, filter).value;
    final data = await _client.request(
      'getProgramAccounts',
      params: <dynamic>[
        pubKey,
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _getResult(data);

    return _fromJsonArray(value,
        (dynamic v) => ProgramAccount.fromJson(v as Map<String, dynamic>));
  }

  @override
  Future<RecentBlockhash> getRecentBlockhash({Commitment? commitment}) async {
    final config = GetRecentBlockhashConfig(commitment).value;
    final data = await _client.request(
      'getRecentBlockhash',
      params: <dynamic>[
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _unwrapAndGetResult(data);

    return RecentBlockhash.fromJson(value as Map<String, dynamic>);
  }

  @override
  Future<List<PerfSample>> getRecentPerformanceSamples(int limit) async {
    final config = <String, dynamic>{};
    final data = await _client.request(
      'getRecentPerformanceSamples',
      params: <dynamic>[
        limit,
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _getResult(data);

    return _fromJsonArray(
        value, (dynamic v) => PerfSample.fromJson(v as Map<String, dynamic>));
  }

  @override
  Future<int> getSnapshotSlot() async {
    final config = <String, dynamic>{};
    final data = await _client.request(
      'getSnapshotSlot',
      params: <dynamic>[
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _getResult(data);

    return value as int;
  }

  @override
  Future<List<TransactionSignatureInformation>> getSignaturesForAddress(
      String pubKey,
      {required int limit,
      required String before,
      required String until,
      required Commitment commitment}) async {
    final config =
        GetSignaturesForAddressConfig(limit, before, until, commitment).value;
    final data = await _client.request(
      'getSignaturesForAddress',
      params: <dynamic>[
        pubKey,
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _getResult(data);

    return _fromJsonArray(
        value,
        (dynamic v) => TransactionSignatureInformation.fromJson(
            v as Map<String, dynamic>));
  }

  @override
  Future<List<SignatureStatus?>> getSignatureStatuses(String signatures,
      {required bool searchTransactionHistory}) async {
    final config = GetSignatureStatusesConfig(searchTransactionHistory).value;
    final data = await _client.request(
      'getSignatureStatuses',
      params: <dynamic>[
        signatures,
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _unwrapAndGetResult(data);

    return _fromJsonArray(value,
        (dynamic v) => SignatureStatus?.fromJson(v as Map<String, dynamic>));
  }

  @override
  Future<int> getSlot({Commitment? commitment}) async {
    final config = GetSlotConfig(commitment).value;
    final data = await _client.request(
      'getSlot',
      params: <dynamic>[
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _getResult(data);

    return value as int;
  }

  @override
  Future<String> getSlotLeader({Commitment? commitment}) async {
    final config = GetSlotLeaderConfig(commitment).value;
    final data = await _client.request(
      'getSlotLeader',
      params: <dynamic>[
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _getResult(data);

    return value as String;
  }

  @override
  Future<List<String>> getSlotLeaders(int startSlot, int limit) async {
    final config = <String, dynamic>{};
    final data = await _client.request(
      'getSlotLeaders',
      params: <dynamic>[
        startSlot,
        limit,
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _getResult(data);

    return _fromJsonArray(value, (dynamic v) => v as String);
  }

  @override
  Future<StakeActivation> getStakeActivation(String pubKey,
      {required Commitment commitment, required int epoch}) async {
    final config = GetStakeActivationConfig(commitment, epoch).value;
    final data = await _client.request(
      'getStakeActivation',
      params: <dynamic>[
        pubKey,
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _getResult(data);

    return StakeActivation.fromJson(value as Map<String, dynamic>);
  }

  @override
  Future<Supply> getSupply(
      {required Commitment commitment,
      required bool excludeNonCirculatingAccountsList}) async {
    final config =
        GetSupplyConfig(commitment, excludeNonCirculatingAccountsList).value;
    final data = await _client.request(
      'getSupply',
      params: <dynamic>[
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _unwrapAndGetResult(data);

    return Supply.fromJson(value as Map<String, dynamic>);
  }

  @override
  Future<TokenAmount> getTokenAccountBalance(String pubKey,
      {Commitment? commitment}) async {
    final config = GetTokenAccountBalanceConfig(commitment).value;
    final data = await _client.request(
      'getTokenAccountBalance',
      params: <dynamic>[
        pubKey,
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _unwrapAndGetResult(data);

    return TokenAmount.fromJson(value as Map<String, dynamic>);
  }

  @override
  Future<List<ProgramAccount>> getTokenAccountsByDelegate(
      String pubKey, TokenAccountsFilter filter,
      {required Commitment commitment,
      required Encoding encoding,
      required DataSlice dataSlice}) async {
    final config =
        GetTokenAccountsByDelegateConfig(commitment, encoding, dataSlice).value;
    final data = await _client.request(
      'getTokenAccountsByDelegate',
      params: <dynamic>[
        pubKey,
        filter.toJson(),
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _unwrapAndGetResult(data);

    return _fromJsonArray(value,
        (dynamic v) => ProgramAccount.fromJson(v as Map<String, dynamic>));
  }

  @override
  Future<List<ProgramAccount>> getTokenAccountsByOwner(
      String pubKey, TokenAccountsFilter filter,
      {required Commitment commitment,
      required Encoding encoding,
      required DataSlice dataSlice}) async {
    final config =
        GetTokenAccountsByOwnerConfig(commitment, encoding, dataSlice).value;
    final data = await _client.request(
      'getTokenAccountsByOwner',
      params: <dynamic>[
        pubKey,
        filter.toJson(),
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _unwrapAndGetResult(data);

    return _fromJsonArray(value,
        (dynamic v) => ProgramAccount.fromJson(v as Map<String, dynamic>));
  }

  @override
  Future<List<ProgramAccount>> getTokenLargestAccounts(String pubKey,
      {Commitment? commitment}) async {
    final config = GetTokenLargestAccountsConfig(commitment).value;
    final data = await _client.request(
      'getTokenLargestAccounts',
      params: <dynamic>[
        pubKey,
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _unwrapAndGetResult(data);

    return _fromJsonArray(value,
        (dynamic v) => ProgramAccount.fromJson(v as Map<String, dynamic>));
  }

  @override
  Future<TokenAmount> getTokenSupply(String mint,
      {Commitment? commitment}) async {
    final config = GetTokenSupplyConfig(commitment).value;
    final data = await _client.request(
      'getTokenSupply',
      params: <dynamic>[
        mint,
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _unwrapAndGetResult(data);

    return TokenAmount.fromJson(value as Map<String, dynamic>);
  }

  @override
  Future<TransactionDetails> getTransaction(String signature,
      {required Encoding encoding, required Commitment commitment}) async {
    final config = GetTransactionConfig(encoding, commitment).value;
    final data = await _client.request(
      'getTransaction',
      params: <dynamic>[
        signature,
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _getResult(data);

    return TransactionDetails.fromJson(value as Map<String, dynamic>);
  }

  @override
  Future<int> getTransactionCount({Commitment? commitment}) async {
    final config = GetTransactionCountConfig(commitment).value;
    final data = await _client.request(
      'getTransactionCount',
      params: <dynamic>[
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _getResult(data);

    return value as int;
  }

  @override
  Future<SolanaVersion> getVersion() async {
    final config = <String, dynamic>{};
    final data = await _client.request(
      'getVersion',
      params: <dynamic>[
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _getResult(data);

    return SolanaVersion.fromJson(value as Map<String, dynamic>);
  }

  @override
  Future<VoteAccounts> getVoteAccounts(
      {required Commitment commitment,
      required String votePubKey,
      required bool keepUnstakedDelinquents,
      required int delinquentSlotDistance}) async {
    final config = GetVoteAccountsConfig(commitment, votePubKey,
            keepUnstakedDelinquents, delinquentSlotDistance)
        .value;
    final data = await _client.request(
      'getVoteAccounts',
      params: <dynamic>[
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _getResult(data);

    return VoteAccounts.fromJson(value as Map<String, dynamic>);
  }

  @override
  Future<int> minimumLedgerSlot() async {
    final config = <String, dynamic>{};
    final data = await _client.request(
      'minimumLedgerSlot',
      params: <dynamic>[
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _getResult(data);

    return value as int;
  }

  @override
  Future<String> requestAirdrop(String pubKey, int lamports,
      {Commitment? commitment}) async {
    final config = RequestAirdropConfig(commitment).value;
    final data = await _client.request(
      'requestAirdrop',
      params: <dynamic>[
        pubKey,
        lamports,
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _getResult(data);

    return value as String;
  }

  @override
  Future<String> sendTransaction(String transaction,
      {required Encoding encoding,
      required Commitment commitment,
      required bool skipPreflight,
      required int maxRetries}) async {
    final config =
        SendTransactionConfig(encoding, commitment, skipPreflight, maxRetries)
            .value;
    final data = await _client.request(
      'sendTransaction',
      params: <dynamic>[
        transaction,
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _getResult(data);

    return value as String;
  }

  @override
  Future<TransactionStatus> simulateTransaction(String transaction,
      {required bool sigVerify,
      required Encoding encoding,
      required Commitment commitment,
      required bool replaceRecentBlockhash,
      required SimulateTransactionAccounts accounts}) async {
    final config = SimulateTransactionConfig(
            sigVerify, encoding, commitment, replaceRecentBlockhash, accounts)
        .value;
    final data = await _client.request(
      'simulateTransaction',
      params: <dynamic>[
        transaction,
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _unwrapAndGetResult(data);

    return TransactionStatus.fromJson(value as Map<String, dynamic>);
  }

  @override
  Future<Block> getConfirmedBlock(int slot,
      {required Encoding encoding,
      required TransactionDetailLevel transactionDetails,
      required bool rewards,
      required Commitment commitment}) async {
    final config = GetConfirmedBlockConfig(
            encoding, transactionDetails, rewards, commitment)
        .value;
    final data = await _client.request(
      'getConfirmedBlock',
      params: <dynamic>[
        slot,
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _getResult(data);

    return Block.fromJson(value as Map<String, dynamic>);
  }

  @override
  Future<List<int>> getConfirmedBlocks(
      int startSlot, int endSlot, Commitment commitment) async {
    final config = <String, dynamic>{};
    final data = await _client.request(
      'getConfirmedBlocks',
      params: <dynamic>[
        startSlot,
        endSlot,
        commitment.toJson(),
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _getResult(data);

    return _fromJsonArray(value, (dynamic v) => v as int);
  }

  @override
  Future<List<int>> getConfirmedBlocksWithLimit(
      int startSlot, int limit, Commitment commitment) async {
    final config = <String, dynamic>{};
    final data = await _client.request(
      'getConfirmedBlocksWithLimit',
      params: <dynamic>[
        startSlot,
        limit,
        commitment.toJson(),
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _getResult(data);

    return _fromJsonArray(value, (dynamic v) => v as int);
  }

  @override
  Future<List<TransactionSignatureInformation>>
      getConfirmedSignaturesForAddress2(String pubKey,
          {required int limit,
          required String before,
          required String until,
          required Commitment commitment}) async {
    final config = GetConfirmedSignaturesForAddress2Config(
            limit, before, until, commitment)
        .value;
    final data = await _client.request(
      'getConfirmedSignaturesForAddress2',
      params: <dynamic>[
        pubKey,
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _getResult(data);

    return _fromJsonArray(
        value,
        (dynamic v) => TransactionSignatureInformation.fromJson(
            v as Map<String, dynamic>));
  }

  @override
  Future<TransactionDetails> getConfirmedTransaction(String signature,
      {required Encoding encoding, required Commitment commitment}) async {
    final config = GetConfirmedTransactionConfig(encoding, commitment).value;
    final data = await _client.request(
      'getConfirmedTransaction',
      params: <dynamic>[
        signature,
        if (config.isNotEmpty) config,
      ],
    );
    final dynamic value = _getResult(data);

    return TransactionDetails.fromJson(value as Map<String, dynamic>);
  }
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class GetAccountInfoConfig {
  GetAccountInfoConfig(this.commitment, this.encoding, this.dataSlice);

  final Commitment commitment;
  final Encoding encoding;
  final DataSlice dataSlice;

  Map<String, dynamic> toJson() => _$GetAccountInfoConfigToJson(this);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class GetBalanceConfig {
  GetBalanceConfig(this.commitment);

  final Commitment? commitment;

  Map<String, dynamic> toJson() => _$GetBalanceConfigToJson(this);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class GetBlockConfig {
  GetBlockConfig(
      this.encoding, this.transactionDetails, this.rewards, this.commitment);

  final Encoding encoding;
  final TransactionDetailLevel transactionDetails;
  final bool rewards;
  final Commitment commitment;

  Map<String, dynamic> toJson() => _$GetBlockConfigToJson(this);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class GetBlockHeightConfig {
  GetBlockHeightConfig(this.commitment);

  final Commitment? commitment;

  Map<String, dynamic> toJson() => _$GetBlockHeightConfigToJson(this);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class GetBlockProductionConfig {
  GetBlockProductionConfig(this.commitment, this.range, this.identity);

  final Commitment commitment;
  final Range range;
  final String identity;

  Map<String, dynamic> toJson() => _$GetBlockProductionConfigToJson(this);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class GetBlocksConfig {
  GetBlocksConfig(this.commitment);

  final Commitment? commitment;

  Map<String, dynamic> toJson() => _$GetBlocksConfigToJson(this);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class GetBlocksWithLimitConfig {
  GetBlocksWithLimitConfig(this.commitment);

  final Commitment? commitment;

  Map<String, dynamic> toJson() => _$GetBlocksWithLimitConfigToJson(this);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class GetEpochInfoConfig {
  GetEpochInfoConfig(this.commitment);

  final Commitment? commitment;

  Map<String, dynamic> toJson() => _$GetEpochInfoConfigToJson(this);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class GetFeeCalculatorForBlockhashConfig {
  GetFeeCalculatorForBlockhashConfig(this.commitment);

  final Commitment? commitment;

  Map<String, dynamic> toJson() =>
      _$GetFeeCalculatorForBlockhashConfigToJson(this);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class GetFeesConfig {
  GetFeesConfig(this.commitment);

  final Commitment? commitment;

  Map<String, dynamic> toJson() => _$GetFeesConfigToJson(this);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class GetInflationGovernorConfig {
  GetInflationGovernorConfig(this.commitment);

  final Commitment? commitment;

  Map<String, dynamic> toJson() => _$GetInflationGovernorConfigToJson(this);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class GetLargestAccountsConfig {
  GetLargestAccountsConfig(this.commitment, this.filter);

  final Commitment commitment;
  final CirculationStatus filter;

  Map<String, dynamic> toJson() => _$GetLargestAccountsConfigToJson(this);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class GetLeaderScheduleConfig {
  GetLeaderScheduleConfig(this.commitment, this.identity);

  final Commitment commitment;
  final String identity;

  Map<String, dynamic> toJson() => _$GetLeaderScheduleConfigToJson(this);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class GetMinimumBalanceForRentExemptionConfig {
  GetMinimumBalanceForRentExemptionConfig(this.commitment);

  final Commitment? commitment;

  Map<String, dynamic> toJson() =>
      _$GetMinimumBalanceForRentExemptionConfigToJson(this);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class GetMultipleAccountsConfig {
  GetMultipleAccountsConfig(this.commitment, this.encoding, this.dataSlice);

  final Commitment commitment;
  final Encoding encoding;
  final DataSlice dataSlice;

  Map<String, dynamic> toJson() => _$GetMultipleAccountsConfigToJson(this);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class GetProgramAccountsConfig {
  GetProgramAccountsConfig(
      this.commitment, this.encoding, this.dataSlice, this.filter);

  final Commitment commitment;
  final Encoding encoding;
  final DataSlice dataSlice;
  final Filter filter;

  Map<String, dynamic> toJson() => _$GetProgramAccountsConfigToJson(this);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class GetRecentBlockhashConfig {
  GetRecentBlockhashConfig(this.commitment);

  final Commitment? commitment;

  Map<String, dynamic> toJson() => _$GetRecentBlockhashConfigToJson(this);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class GetSignaturesForAddressConfig {
  GetSignaturesForAddressConfig(
      this.limit, this.before, this.until, this.commitment);

  final int limit;
  final String before;
  final String until;
  final Commitment commitment;

  Map<String, dynamic> toJson() => _$GetSignaturesForAddressConfigToJson(this);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class GetSignatureStatusesConfig {
  GetSignatureStatusesConfig(this.searchTransactionHistory);

  final bool searchTransactionHistory;

  Map<String, dynamic> toJson() => _$GetSignatureStatusesConfigToJson(this);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class GetSlotConfig {
  GetSlotConfig(this.commitment);

  final Commitment? commitment;

  Map<String, dynamic> toJson() => _$GetSlotConfigToJson(this);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class GetSlotLeaderConfig {
  GetSlotLeaderConfig(this.commitment);

  final Commitment? commitment;

  Map<String, dynamic> toJson() => _$GetSlotLeaderConfigToJson(this);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class GetStakeActivationConfig {
  GetStakeActivationConfig(this.commitment, this.epoch);

  final Commitment commitment;
  final int epoch;

  Map<String, dynamic> toJson() => _$GetStakeActivationConfigToJson(this);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class GetSupplyConfig {
  GetSupplyConfig(this.commitment, this.excludeNonCirculatingAccountsList);

  final Commitment commitment;
  final bool excludeNonCirculatingAccountsList;

  Map<String, dynamic> toJson() => _$GetSupplyConfigToJson(this);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class GetTokenAccountBalanceConfig {
  GetTokenAccountBalanceConfig(this.commitment);

  final Commitment? commitment;

  Map<String, dynamic> toJson() => _$GetTokenAccountBalanceConfigToJson(this);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class GetTokenAccountsByDelegateConfig {
  GetTokenAccountsByDelegateConfig(
      this.commitment, this.encoding, this.dataSlice);

  final Commitment commitment;
  final Encoding encoding;
  final DataSlice dataSlice;

  Map<String, dynamic> toJson() =>
      _$GetTokenAccountsByDelegateConfigToJson(this);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class GetTokenAccountsByOwnerConfig {
  GetTokenAccountsByOwnerConfig(this.commitment, this.encoding, this.dataSlice);

  final Commitment commitment;
  final Encoding encoding;
  final DataSlice dataSlice;

  Map<String, dynamic> toJson() => _$GetTokenAccountsByOwnerConfigToJson(this);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class GetTokenLargestAccountsConfig {
  GetTokenLargestAccountsConfig(this.commitment);

  final Commitment? commitment;

  Map<String, dynamic> toJson() => _$GetTokenLargestAccountsConfigToJson(this);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class GetTokenSupplyConfig {
  GetTokenSupplyConfig(this.commitment);

  final Commitment? commitment;

  Map<String, dynamic> toJson() => _$GetTokenSupplyConfigToJson(this);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class GetTransactionConfig {
  GetTransactionConfig(this.encoding, this.commitment);

  final Encoding encoding;
  final Commitment commitment;

  Map<String, dynamic> toJson() => _$GetTransactionConfigToJson(this);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class GetTransactionCountConfig {
  GetTransactionCountConfig(this.commitment);

  final Commitment? commitment;

  Map<String, dynamic> toJson() => _$GetTransactionCountConfigToJson(this);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class GetVoteAccountsConfig {
  GetVoteAccountsConfig(this.commitment, this.votePubKey,
      this.keepUnstakedDelinquents, this.delinquentSlotDistance);

  final Commitment commitment;
  final String votePubKey;
  final bool keepUnstakedDelinquents;
  final int delinquentSlotDistance;

  Map<String, dynamic> toJson() => _$GetVoteAccountsConfigToJson(this);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class RequestAirdropConfig {
  RequestAirdropConfig(this.commitment);

  final Commitment? commitment;

  Map<String, dynamic> toJson() => _$RequestAirdropConfigToJson(this);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class SendTransactionConfig {
  SendTransactionConfig(
      this.encoding, this.commitment, this.skipPreflight, this.maxRetries);

  final Encoding encoding;
  final Commitment commitment;
  final bool skipPreflight;
  final int maxRetries;

  Map<String, dynamic> toJson() => _$SendTransactionConfigToJson(this);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class SimulateTransactionConfig {
  SimulateTransactionConfig(this.sigVerify, this.encoding, this.commitment,
      this.replaceRecentBlockhash, this.accounts);

  final bool sigVerify;
  final Encoding encoding;
  final Commitment commitment;
  final bool replaceRecentBlockhash;
  final SimulateTransactionAccounts accounts;

  Map<String, dynamic> toJson() => _$SimulateTransactionConfigToJson(this);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class GetConfirmedBlockConfig {
  GetConfirmedBlockConfig(
      this.encoding, this.transactionDetails, this.rewards, this.commitment);

  final Encoding encoding;
  final TransactionDetailLevel transactionDetails;
  final bool rewards;
  final Commitment commitment;

  Map<String, dynamic> toJson() => _$GetConfirmedBlockConfigToJson(this);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class GetConfirmedSignaturesForAddress2Config {
  GetConfirmedSignaturesForAddress2Config(
      this.limit, this.before, this.until, this.commitment);

  final int limit;
  final String before;
  final String until;
  final Commitment commitment;

  Map<String, dynamic> toJson() =>
      _$GetConfirmedSignaturesForAddress2ConfigToJson(this);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class GetConfirmedTransactionConfig {
  GetConfirmedTransactionConfig(this.encoding, this.commitment);

  final Encoding encoding;
  final Commitment commitment;

  Map<String, dynamic> toJson() => _$GetConfirmedTransactionConfigToJson(this);
}

List<T> _fromJsonArray<T>(dynamic array, T Function(dynamic) convert) {
  if (array is List<Map<String, dynamic>>) {
    return array.map(convert).toList(growable: false);
  } else {
    throw const FormatException('invalid input type is not json array');
  }
}

dynamic _getResult(dynamic raw) {
  if (raw is! Map<String, dynamic>) {
    throw const FormatException('expecting a map but got something else');
  }

  return raw['result'];
}

dynamic _unwrapAndGetResult(dynamic raw) {
  final dynamic result = _getResult(raw);
  if (result is! Map<String, dynamic>) {
    throw const FormatException('expecting a map but got something else');
  }

  return result['value'];
}
