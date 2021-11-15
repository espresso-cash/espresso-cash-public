// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// ClientGenerator
// **************************************************************************

class _RpcClient implements RpcClient {
  _RpcClient(String url) : _client = JsonRpcClient(url);

  final JsonRpcClient _client;

  Future<RpcResponse<AccountInfo>> getAccountInfo(String account,
      {String? encoding, Commitment? commitment}) async {
    final config = GetAccountInfoConfig(encoding, commitment).toJson();
    final data = await _client.request(
      'getAccountInfo',
      params: <dynamic>[
        account,
        if (config.isNotEmpty) config,
      ],
    );

    return RpcResponse<AccountInfo>.fromJson(
        data['result'] as Map<String, dynamic>,
        (json) => AccountInfo.fromJson(json as Map<String, dynamic>));
  }

  Future<RpcResponse<int>> getBalance(String account,
      {Commitment? commitment}) async {
    final config = GetBalanceConfig(commitment).toJson();
    final data = await _client.request(
      'getBalance',
      params: <dynamic>[
        account,
        if (config.isNotEmpty) config,
      ],
    );

    return RpcResponse<int>.fromJson(
        data['result'] as Map<String, dynamic>, (json) => json as int);
  }

  Future<int> getBlockHeight({Commitment? commitment}) async {
    final config = GetBlockHeightConfig(commitment).toJson();
    final data = await _client.request(
      'getBlockHeight',
      params: <dynamic>[
        if (config.isNotEmpty) config,
      ],
    );

    return data['result'] as int;
  }

  Future<RpcResponse<BlockProduction>> getBlockProduction(
      {Commitment? commitment, SlotRange? range, String? identity}) async {
    final config =
        GetBlockProductionConfig(commitment, range, identity).toJson();
    final data = await _client.request(
      'getBlockProduction',
      params: <dynamic>[
        if (config.isNotEmpty) config,
      ],
    );

    return RpcResponse<BlockProduction>.fromJson(
        data['result'] as Map<String, dynamic>,
        (json) => BlockProduction.fromJson(json as Map<String, dynamic>));
  }

  Future<int> getBlockCommitment(int block) async {
    final config = <String, dynamic>{};
    final data = await _client.request(
      'getBlockCommitment',
      params: <dynamic>[
        block,
        if (config.isNotEmpty) config,
      ],
    );

    return data['result'] as int;
  }

  Future<RpcResponse<RecentBlockhash>> getRecentBlockhash(
      {Commitment? commitment}) async {
    final config = GetRecentBlockhashConfig(commitment).toJson();
    final data = await _client.request(
      'getRecentBlockhash',
      params: <dynamic>[
        if (config.isNotEmpty) config,
      ],
    );

    return RpcResponse<RecentBlockhash>.fromJson(
        data['result'] as Map<String, dynamic>,
        (json) => RecentBlockhash.fromJson(json as Map<String, dynamic>));
  }

  Future<String> requestAirdrop(String account, int lamports,
      {Commitment? commitment}) async {
    final config = RequestAirdropConfig(commitment).toJson();
    final data = await _client.request(
      'requestAirdrop',
      params: <dynamic>[
        account,
        lamports,
        if (config.isNotEmpty) config,
      ],
    );

    return data['result'] as String;
  }

  Future<RpcResponse<BlockCommitment>> getFees({Commitment? commitment}) async {
    final config = GetFeesConfig(commitment).toJson();
    final data = await _client.request(
      'getFees',
      params: <dynamic>[
        if (config.isNotEmpty) config,
      ],
    );

    return RpcResponse<BlockCommitment>.fromJson(
        data['result'] as Map<String, dynamic>,
        (json) => BlockCommitment.fromJson(json as Map<String, dynamic>));
  }
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class GetAccountInfoConfig {
  GetAccountInfoConfig(this.encoding, this.commitment);

  final String? encoding;
  final Commitment? commitment;

  Map<String, dynamic> toJson() => _$GetAccountInfoConfigToJson(this);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class GetBalanceConfig {
  GetBalanceConfig(this.commitment);

  final Commitment? commitment;

  Map<String, dynamic> toJson() => _$GetBalanceConfigToJson(this);
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

  final Commitment? commitment;
  final SlotRange? range;
  final String? identity;

  Map<String, dynamic> toJson() => _$GetBlockProductionConfigToJson(this);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class GetRecentBlockhashConfig {
  GetRecentBlockhashConfig(this.commitment);

  final Commitment? commitment;

  Map<String, dynamic> toJson() => _$GetRecentBlockhashConfigToJson(this);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class RequestAirdropConfig {
  RequestAirdropConfig(this.commitment);

  final Commitment? commitment;

  Map<String, dynamic> toJson() => _$RequestAirdropConfigToJson(this);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class GetFeesConfig {
  GetFeesConfig(this.commitment);

  final Commitment? commitment;

  Map<String, dynamic> toJson() => _$GetFeesConfigToJson(this);
}
