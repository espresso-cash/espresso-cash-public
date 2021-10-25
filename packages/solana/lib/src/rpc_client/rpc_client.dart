///
/// Generated file, please do not modify
///
/// All methods needed for the RPC api are defined in this file, they were
/// generated from a specification file in json format.
///

import 'dart:async';

import 'package:solana/src/crypto/ed25519_hd_keypair.dart';
import 'package:solana/src/encoder/message.dart';
import 'package:solana/src/json_rpc_client/json_rpc_client.dart';
import 'package:solana/src/rpc_client/exceptions.dart';
import 'package:solana/src/rpc_client/rpc_types.dart';
import 'package:solana/src/rpc_client/rpc_types_extension.dart';
import 'package:solana/src/subscription_client/subscription_client.dart';
import 'package:solana/src/utils.dart';

part 'rpc_client_extension.dart';

/// Solana rpc api client
class RPCClient {
  /// Build an rpc api client to communicate with the solana node [rpcUrl].
  RPCClient({
    required String rpcUrl,
    required String websocketUrl,
  })  : _client = JsonRpcClient(rpcUrl),
        _subscriptionClient = SubscriptionClient(websocketUrl);

  final JsonRpcClient _client;
  final SubscriptionClient _subscriptionClient;

  /// Returns all information associated with the account of
  /// provided Pubkey
  Future<Account?> getAccountInfo({
    required String pubKey,
    GetAccountInfoOptions? options,
  }) async {
    final response = await _client.request(
      'getAccountInfo',
      params: <dynamic>[
        pubKey,
        options?.toJson(),
      ],
    );

    final dynamic value = _extractValueFromWrappedResponse(response);
    if (value == null) {
      return null;
    }

    if (value is! Map<String, dynamic>) {
      throw InvalidResultValueException(value);
    }

    return Account.fromJson(value);
  }

  /// Returns the balance of the account of provided Pubkey
  Future<int> getBalance({
    required String pubKey,
    CommitmentObject? commitment,
  }) async {
    final response = await _client.request(
      'getBalance',
      params: <dynamic>[
        pubKey,
        commitment?.toJson(),
      ],
    );

    return _extractValueFromWrappedResponse(response) as int;
  }

  /// Returns identity and transaction information about a
  /// confirmed block in the ledger
  Future<Block?> getBlock({
    required int slot,
    GetBlockOptions? options,
  }) async {
    final response = await _client.request(
      'getBlock',
      params: <dynamic>[
        slot,
        options?.toJson(),
      ],
    );

    final dynamic result = _extractResultFromResponse(response);
    if (result == null) {
      return null;
    }

    if (result is! Map<String, dynamic>) {
      throw const FormatException('expecting result to be map and it is not');
    }

    return Block.fromJson(result);
  }

  /// Returns the current block height of the node
  Future<int> getBlockHeight({
    CommitmentObject? commitment,
  }) async {
    final response = await _client.request(
      'getBlockHeight',
      params: <dynamic>[
        commitment?.toJson(),
      ],
    );

    return _extractResultFromResponse(response) as int;
  }

  /// Returns recent block production information from the
  /// current or previous epoch.
  Future<BlockProduction> getBlockProduction({
    GetBlockProductionOptions? options,
  }) async {
    final response = await _client.request(
      'getBlockProduction',
      params: <dynamic>[
        options?.toJson(),
      ],
    );

    final dynamic value = _extractValueFromWrappedResponse(response);
    if (value == null) {
      throw NullResponseException();
    }

    if (value is! Map<String, dynamic>) {
      throw InvalidResultValueException(value);
    }

    return BlockProduction.fromJson(value);
  }

  /// Returns commitment for particular block
  Future<BlockCommitment?> getBlockCommitment({
    required int block,
  }) async {
    final response = await _client.request(
      'getBlockCommitment',
      params: <dynamic>[
        block,
      ],
    );

    final dynamic result = _extractResultFromResponse(response);
    if (result == null) {
      return null;
    }

    if (result is! Map<String, dynamic>) {
      throw const FormatException('expecting result to be map and it is not');
    }

    return BlockCommitment.fromJson(result);
  }

  /// Returns a list of confirmed blocks between two slots
  Future<List<int>> getBlocks({
    required int startSlot,
    int? endSlot,
    Commitment? commitment,
  }) async {
    final response = await _client.request(
      'getBlocks',
      params: <dynamic>[
        startSlot,
        endSlot,
        commitment?.toJson(),
      ],
    );

    return _convertList(
      _extractResultFromResponse(response),
      (dynamic item) => item as int,
    );
  }

  /// Returns a list of confirmed blocks starting at the given
  /// slot
  Future<List<int>> getBlocksWithLimit({
    required int startSlot,
    required int limit,
    Commitment? commitment,
  }) async {
    final response = await _client.request(
      'getBlocksWithLimit',
      params: <dynamic>[
        startSlot,
        limit,
        commitment?.toJson(),
      ],
    );

    return _convertList(
      _extractResultFromResponse(response),
      (dynamic item) => item as int,
    );
  }

  /// Returns the estimated production time of a block.
  Future<int?> getBlockTime({
    required int block,
  }) async {
    final response = await _client.request(
      'getBlockTime',
      params: <dynamic>[
        block,
      ],
    );

    return _extractResultFromResponse(response) as int?;
  }

  /// Returns information about all the nodes participating in
  /// the cluster
  Future<List<ClusterNode>> getClusterNodes() async {
    final response = await _client.request(
      'getClusterNodes',
      params: <dynamic>[],
    );

    return _convertList(
      _extractResultFromResponse(response),
      (dynamic item) => ClusterNode.fromJson(item as Map<String, dynamic>),
    );
  }

  /// Returns information about the current epoch
  Future<EpochInfo> getEpochInfo({
    CommitmentObject? commitment,
  }) async {
    final response = await _client.request(
      'getEpochInfo',
      params: <dynamic>[
        commitment?.toJson(),
      ],
    );

    final dynamic result = _extractResultFromResponse(response);
    if (result == null) {
      throw NullResponseException();
    }

    if (result is! Map<String, dynamic>) {
      throw const FormatException('expecting result to be map and it is not');
    }

    return EpochInfo.fromJson(result);
  }

  /// Returns epoch schedule information from this cluster's
  /// genesis config
  Future<EpochSchedule> getEpochSchedule() async {
    final response = await _client.request(
      'getEpochSchedule',
      params: <dynamic>[],
    );

    final dynamic result = _extractResultFromResponse(response);
    if (result == null) {
      throw NullResponseException();
    }

    if (result is! Map<String, dynamic>) {
      throw const FormatException('expecting result to be map and it is not');
    }

    return EpochSchedule.fromJson(result);
  }

  /// Returns the fee calculator associated with the query
  /// blockhash, or null if the blockhash has expired
  Future<FeeCalculator?> getFeeCalculatorForBlockhash({
    required String blockhash,
    CommitmentObject? commitment,
  }) async {
    final response = await _client.request(
      'getFeeCalculatorForBlockhash',
      params: <dynamic>[
        blockhash,
        commitment?.toJson(),
      ],
    );

    final dynamic result = _extractResultFromResponse(response);
    if (result == null) {
      return null;
    }

    if (result is! Map<String, dynamic>) {
      throw const FormatException('expecting result to be map and it is not');
    }

    return FeeCalculator.fromJson(result);
  }

  /// Returns the fee rate governor information from the root bank
  Future<FeeRateGovernor> getFeeRateGovernor() async {
    final response = await _client.request(
      'getFeeRateGovernor',
      params: <dynamic>[],
    );

    final dynamic result = _extractResultFromResponse(response);
    if (result == null) {
      throw NullResponseException();
    }

    if (result is! Map<String, dynamic>) {
      throw const FormatException('expecting result to be map and it is not');
    }

    return FeeRateGovernor.fromJson(result);
  }

  /// Returns a recent block hash from the ledger, a fee schedule
  /// that can be used to compute the cost of submitting a
  /// transaction using it, and the last slot in which the
  /// blockhash will be valid.
  Future<Fees> getFees({
    CommitmentObject? commitment,
  }) async {
    final response = await _client.request(
      'getFees',
      params: <dynamic>[
        commitment?.toJson(),
      ],
    );

    final dynamic value = _extractValueFromWrappedResponse(response);
    if (value == null) {
      throw NullResponseException();
    }

    if (value is! Map<String, dynamic>) {
      throw InvalidResultValueException(value);
    }

    return Fees.fromJson(value);
  }

  /// Returns the slot of the lowest confirmed block that has not
  /// been purged from the ledger
  Future<int> getFirstAvailableBlock() async {
    final response = await _client.request(
      'getFirstAvailableBlock',
      params: <dynamic>[],
    );

    return _extractResultFromResponse(response) as int;
  }

  /// Returns the genesis hash
  Future<String> getGenesisHash() async {
    final response = await _client.request(
      'getGenesisHash',
      params: <dynamic>[],
    );

    return _extractResultFromResponse(response) as String;
  }

  /// Returns the current health of the node.
  ///
  /// If one or more --known-validator arguments are provided to
  /// solana-validator, "ok" is returned when the node has within
  /// HEALTH_CHECK_SLOT_DISTANCE slots of the highest known
  /// validator, otherwise an error is returned. "ok" is always
  /// returned if no known validators are provided.
  Future<String> getHealth() async {
    final response = await _client.request(
      'getHealth',
      params: <dynamic>[],
    );

    return _extractResultFromResponse(response) as String;
  }

  /// Returns the identity pubkey for the current node
  Future<Identity> getIdentity() async {
    final response = await _client.request(
      'getIdentity',
      params: <dynamic>[],
    );

    final dynamic result = _extractResultFromResponse(response);
    if (result == null) {
      throw NullResponseException();
    }

    if (result is! Map<String, dynamic>) {
      throw const FormatException('expecting result to be map and it is not');
    }

    return Identity.fromJson(result);
  }

  /// Returns the current inflation governor
  Future<InflationGovernor> getInflationGovernor({
    CommitmentObject? commitment,
  }) async {
    final response = await _client.request(
      'getInflationGovernor',
      params: <dynamic>[
        commitment?.toJson(),
      ],
    );

    final dynamic result = _extractResultFromResponse(response);
    if (result == null) {
      throw NullResponseException();
    }

    if (result is! Map<String, dynamic>) {
      throw const FormatException('expecting result to be map and it is not');
    }

    return InflationGovernor.fromJson(result);
  }

  /// Returns the specific inflation values for the current epoch
  Future<InflationRate> getInflationRate() async {
    final response = await _client.request(
      'getInflationRate',
      params: <dynamic>[],
    );

    final dynamic result = _extractResultFromResponse(response);
    if (result == null) {
      throw NullResponseException();
    }

    if (result is! Map<String, dynamic>) {
      throw const FormatException('expecting result to be map and it is not');
    }

    return InflationRate.fromJson(result);
  }

  /// Returns the inflation reward for a list of addresses for an
  /// epoch
  Future<List<InflationReward>> getInflationReward({
    required List<String> addresses,
  }) async {
    final response = await _client.request(
      'getInflationReward',
      params: <dynamic>[
        addresses,
      ],
    );

    return _convertList(
      _extractResultFromResponse(response),
      (dynamic item) => InflationReward.fromJson(item as Map<String, dynamic>),
    );
  }

  /// Returns the 20 largest accounts, by lamport balance
  /// (results may be cached up to two hours)
  Future<List<LargeAccount>> getLargestAccounts({
    GetLargestAccountsOptions? options,
  }) async {
    final response = await _client.request(
      'getLargestAccounts',
      params: <dynamic>[
        options?.toJson(),
      ],
    );

    return _convertList(
      _extractValueFromWrappedResponse(response),
      (dynamic item) => LargeAccount.fromJson(item as Map<String, dynamic>),
    );
  }

  /// Returns the leader schedule for an epoch
  Future<Map<String, List<int>>?> getLeaderSchedule({
    int? slot,
    GetLeaderScheduleOptions? options,
  }) async {
    final response = await _client.request(
      'getLeaderSchedule',
      params: <dynamic>[
        slot,
        options?.toJson(),
      ],
    );

    return _convertMap(
      _extractResultFromResponse(response),
      (dynamic key) => key as String,
      (dynamic value) => _convertList(
        response,
        (dynamic item) => item as int,
      ),
    );
  }

  /// Get the max slot seen from retransmit stage.
  Future<int> getMaxRetransmitSlot({
    required int slot,
  }) async {
    final response = await _client.request(
      'getMaxRetransmitSlot',
      params: <dynamic>[
        slot,
      ],
    );

    return _extractResultFromResponse(response) as int;
  }

  /// Get the max slot seen from after shred insert.
  Future<int> getMaxShredInsertSlot() async {
    final response = await _client.request(
      'getMaxShredInsertSlot',
      params: <dynamic>[],
    );

    return _extractResultFromResponse(response) as int;
  }

  /// Returns minimum balance required to make account rent
  /// exempt.
  Future<int> getMinimumBalanceForRentExemption({
    required int accountDataLength,
    CommitmentObject? commitment,
  }) async {
    final response = await _client.request(
      'getMinimumBalanceForRentExemption',
      params: <dynamic>[
        accountDataLength,
        commitment?.toJson(),
      ],
    );

    return _extractResultFromResponse(response) as int;
  }

  /// Returns the account information for a list of Public keys
  Future<List<Account>> getMultipleAccounts({
    required List<String> pubKeys,
    GetAccountInfoOptions? options,
  }) async {
    final response = await _client.request(
      'getMultipleAccounts',
      params: <dynamic>[
        pubKeys,
        options?.toJson(),
      ],
    );

    return _convertList(
      _extractValueFromWrappedResponse(response),
      (dynamic item) => Account.fromJson(item as Map<String, dynamic>),
    );
  }

  /// Returns all accounts owned by the provided program Pubkey
  ///
  ///
  Future<List<ProgramAccount>> getProgramAccounts({
    required String pubKey,
    GetProgramAccountsOptions? options,
  }) async {
    final response = await _client.request(
      'getProgramAccounts',
      params: <dynamic>[
        pubKey,
        options?.toJson(),
      ],
    );

    return _convertList(
      _extractResultFromResponse(response),
      (dynamic item) => ProgramAccount.fromJson(item as Map<String, dynamic>),
    );
  }

  /// Returns a recent block hash from the ledger, and a fee
  /// schedule that can be used to compute the cost of submitting
  /// a transaction using it.
  Future<RecentBlockhash> getRecentBlockhash({
    CommitmentObject? commitment,
  }) async {
    final response = await _client.request(
      'getRecentBlockhash',
      params: <dynamic>[
        commitment?.toJson(),
      ],
    );

    final dynamic value = _extractValueFromWrappedResponse(response);
    if (value == null) {
      throw NullResponseException();
    }

    if (value is! Map<String, dynamic>) {
      throw InvalidResultValueException(value);
    }

    return RecentBlockhash.fromJson(value);
  }

  /// Returns a list of recent performance samples, in reverse
  /// slot order. Performance samples are taken every 60 seconds
  /// and include the number of transactions and slots that occur
  /// in a given time window.
  Future<List<PerfSample>> getRecentPerformanceSamples({
    int? limit,
  }) async {
    final response = await _client.request(
      'getRecentPerformanceSamples',
      params: <dynamic>[
        limit,
      ],
    );

    return _convertList(
      _extractResultFromResponse(response),
      (dynamic item) => PerfSample.fromJson(item as Map<String, dynamic>),
    );
  }

  /// Returns the highest slot that the node has a snapshot for
  Future<int> getSnapshotSlot() async {
    final response = await _client.request(
      'getSnapshotSlot',
      params: <dynamic>[],
    );

    return _extractResultFromResponse(response) as int;
  }

  /// Returns confirmed signatures for transactions involving an
  /// address backwards in time from the provided signature or
  /// most recent confirmed block
  Future<List<TransactionSignatureInformation>> getSignaturesForAddress({
    required String pubKey,
    GetSignaturesForAddressOptions? options,
  }) async {
    final response = await _client.request(
      'getSignaturesForAddress',
      params: <dynamic>[
        pubKey,
        options?.toJson(),
      ],
    );

    return _convertList(
      _extractResultFromResponse(response),
      (dynamic item) => TransactionSignatureInformation.fromJson(
          item as Map<String, dynamic>),
    );
  }

  /// Returns the statuses of a list of signatures. Unless the
  /// searchTransactionHistory configuration parameter is
  /// included, this method only searches the recent status cache
  /// of signatures, which retains statuses for all active slots
  /// plus MAX_RECENT_BLOCKHASHES rooted slots.
  Future<List<SignatureStatus?>> getSignatureStatuses({
    required List<String> signatures,
    GetSignatureStatusesOptions? options,
  }) async {
    final response = await _client.request(
      'getSignatureStatuses',
      params: <dynamic>[
        signatures,
        options?.toJson(),
      ],
    );

    return _convertList(
      _extractValueFromWrappedResponse(response),
      (dynamic item) => SignatureStatus?.fromJson(item as Map<String, dynamic>),
    );
  }

  /// Returns the slot that has reached the given or default
  /// commitment level
  Future<int> getSlot({
    CommitmentObject? commitment,
  }) async {
    final response = await _client.request(
      'getSlot',
      params: <dynamic>[
        commitment?.toJson(),
      ],
    );

    return _extractResultFromResponse(response) as int;
  }

  /// Returns the current slot leader
  Future<String> getSlotLeader({
    CommitmentObject? commitment,
  }) async {
    final response = await _client.request(
      'getSlotLeader',
      params: <dynamic>[
        commitment?.toJson(),
      ],
    );

    return _extractResultFromResponse(response) as String;
  }

  /// Returns the slot leaders for a given slot range
  Future<List<String>> getSlotLeaders({
    required int startSlot,
    required int limit,
  }) async {
    final response = await _client.request(
      'getSlotLeaders',
      params: <dynamic>[
        startSlot,
        limit,
      ],
    );

    return _convertList(
      _extractResultFromResponse(response),
      (dynamic item) => item as String,
    );
  }

  /// Returns epoch activation information for a stake account
  Future<StakeActivation> getStakeActivation({
    required String pubKey,
    GetStakeActivationOptions? options,
  }) async {
    final response = await _client.request(
      'getStakeActivation',
      params: <dynamic>[
        pubKey,
        options?.toJson(),
      ],
    );

    final dynamic result = _extractResultFromResponse(response);
    if (result == null) {
      throw NullResponseException();
    }

    if (result is! Map<String, dynamic>) {
      throw const FormatException('expecting result to be map and it is not');
    }

    return StakeActivation.fromJson(result);
  }

  /// Returns information about the current supply.
  Future<Supply> getSupply({
    GetSupplyOptions? options,
  }) async {
    final response = await _client.request(
      'getSupply',
      params: <dynamic>[
        options?.toJson(),
      ],
    );

    final dynamic result = _extractResultFromResponse(response);
    if (result == null) {
      throw NullResponseException();
    }

    if (result is! Map<String, dynamic>) {
      throw const FormatException('expecting result to be map and it is not');
    }

    return Supply.fromJson(result);
  }

  /// Returns the token balance of an SPL Token account.
  Future<TokenAmount> getTokenAccountBalance({
    required String pubKey,
    CommitmentObject? commitment,
  }) async {
    final response = await _client.request(
      'getTokenAccountBalance',
      params: <dynamic>[
        pubKey,
        commitment?.toJson(),
      ],
    );

    final dynamic value = _extractValueFromWrappedResponse(response);
    if (value == null) {
      throw NullResponseException();
    }

    if (value is! Map<String, dynamic>) {
      throw InvalidResultValueException(value);
    }

    return TokenAmount.fromJson(value);
  }

  /// Returns all SPL Token accounts by approved Delegate.
  Future<List<ProgramAccount>> getTokenAccountsByDelegate({
    required String pubKey,
    MintOrProgramId mintOrProgramId = const MintOrProgramId(),
    GetAccountInfoOptions? options,
  }) async {
    final response = await _client.request(
      'getTokenAccountsByDelegate',
      params: <dynamic>[
        pubKey,
        mintOrProgramId.toJson(),
        options?.toJson(),
      ],
    );

    return _convertList(
      _extractValueFromWrappedResponse(response),
      (dynamic item) => ProgramAccount.fromJson(item as Map<String, dynamic>),
    );
  }

  /// Returns all SPL Token accounts by token owner.
  Future<List<ProgramAccount>> getTokenAccountsByOwner({
    required String pubKey,
    MintOrProgramId mintOrProgramId = const MintOrProgramId(),
    GetAccountInfoOptions? options,
  }) async {
    final response = await _client.request(
      'getTokenAccountsByOwner',
      params: <dynamic>[
        pubKey,
        mintOrProgramId.toJson(),
        options?.toJson(),
      ],
    );

    return _convertList(
      _extractValueFromWrappedResponse(response),
      (dynamic item) => ProgramAccount.fromJson(item as Map<String, dynamic>),
    );
  }

  /// Returns the 20 largest accounts of a particular SPL Token
  /// type.
  Future<List<ProgramAccount>> getTokenLargestAccounts({
    required String pubKey,
    CommitmentObject? commitment,
  }) async {
    final response = await _client.request(
      'getTokenLargestAccounts',
      params: <dynamic>[
        pubKey,
        commitment?.toJson(),
      ],
    );

    return _convertList(
      _extractValueFromWrappedResponse(response),
      (dynamic item) => ProgramAccount.fromJson(item as Map<String, dynamic>),
    );
  }

  /// Returns the total supply of an SPL Token type.
  Future<TokenAmount> getTokenSupply({
    required String mint,
    CommitmentObject? commitment,
  }) async {
    final response = await _client.request(
      'getTokenSupply',
      params: <dynamic>[
        mint,
        commitment?.toJson(),
      ],
    );

    final dynamic value = _extractValueFromWrappedResponse(response);
    if (value == null) {
      throw NullResponseException();
    }

    if (value is! Map<String, dynamic>) {
      throw InvalidResultValueException(value);
    }

    return TokenAmount.fromJson(value);
  }

  /// Returns transaction details for a confirmed transaction
  Future<TransactionDetails?> getTransaction({
    required String signature,
    GetTransactionOptions? options,
  }) async {
    final response = await _client.request(
      'getTransaction',
      params: <dynamic>[
        signature,
        options?.toJson(),
      ],
    );

    final dynamic result = _extractResultFromResponse(response);
    if (result == null) {
      return null;
    }

    if (result is! Map<String, dynamic>) {
      throw const FormatException('expecting result to be map and it is not');
    }

    return TransactionDetails.fromJson(result);
  }

  /// Returns the current Transaction count from the ledger
  Future<int> getTransactionCount({
    CommitmentObject? commitment,
  }) async {
    final response = await _client.request(
      'getTransactionCount',
      params: <dynamic>[
        commitment?.toJson(),
      ],
    );

    return _extractResultFromResponse(response) as int;
  }

  /// Returns the current solana versions running on the node
  Future<SolanaVersion> getVersion() async {
    final response = await _client.request(
      'getVersion',
      params: <dynamic>[],
    );

    final dynamic result = _extractResultFromResponse(response);
    if (result == null) {
      throw NullResponseException();
    }

    if (result is! Map<String, dynamic>) {
      throw const FormatException('expecting result to be map and it is not');
    }

    return SolanaVersion.fromJson(result);
  }

  /// Returns the account info and associated stake for all the
  /// voting accounts in the current bank.
  Future<VoteAccounts> getVoteAccounts({
    GetVoteAccountsOptions? options,
  }) async {
    final response = await _client.request(
      'getVoteAccounts',
      params: <dynamic>[
        options?.toJson(),
      ],
    );

    final dynamic result = _extractResultFromResponse(response);
    if (result == null) {
      throw NullResponseException();
    }

    if (result is! Map<String, dynamic>) {
      throw const FormatException('expecting result to be map and it is not');
    }

    return VoteAccounts.fromJson(result);
  }

  /// Returns the lowest slot that the node has information about
  /// in its ledger. This value may increase over time if the
  /// node is configured to purge older ledger data
  Future<int> minimumLedgerSlot() async {
    final response = await _client.request(
      'minimumLedgerSlot',
      params: <dynamic>[],
    );

    return _extractResultFromResponse(response) as int;
  }

  /// Requests an airdrop of lamports to a Pubkey
  Future<String> requestAirdrop({
    required String pubKey,
    required int lamports,
    CommitmentObject? commitment,
  }) async {
    final response = await _client.request(
      'requestAirdrop',
      params: <dynamic>[
        pubKey,
        lamports,
        commitment?.toJson(),
      ],
    );

    return _extractResultFromResponse(response) as String;
  }

  /// Submits a signed transaction to the cluster for processing.
  ///
  /// This method does not alter the transaction in any way; it
  /// relays the transaction created by clients to the node as-is.
  ///
  /// If the node's rpc service receives the transaction, this
  /// method immediately succeeds, without waiting for any
  /// confirmations. A successful response from this method does
  /// not guarantee the transaction is processed or confirmed by
  /// the cluster.
  ///
  /// While the rpc service will reasonably retry to submit it,
  /// the transaction could be rejected if transaction's
  /// recent_blockhash expires before it lands.
  ///
  /// Use [RPCClient.getSignatureStatuses()] to ensure a
  /// transaction is processed and confirmed.
  ///
  /// Before submitting, the following preflight checks are
  /// performed:
  ///
  /// - The transaction signatures are verified
  /// - The transaction is simulated against the bank slot
  /// specified by the preflight commitment. On failure an error
  /// will be returned. Preflight checks may be disabled if
  /// desired. It is recommended to specify the same commitment
  /// and preflight commitment to avoid confusing behavior.
  /// - The returned signature is the first signature in the
  /// transaction, which is used to identify the transaction
  /// (transaction id). This identifier can be easily extracted
  /// from the transaction data before submission.
  Future<String> sendTransaction({
    required String transaction,
    SendTransactionOptions options = const SendTransactionOptions(),
  }) async {
    final response = await _client.request(
      'sendTransaction',
      params: <dynamic>[
        transaction,
        options.toJson(),
      ],
    );

    return _extractResultFromResponse(response) as String;
  }

  /// Simulate sending a transaction
  Future<TransactionStatus> simulateTransaction({
    required String transaction,
    SimulateTransactionOptions options = const SimulateTransactionOptions(),
  }) async {
    final response = await _client.request(
      'simulateTransaction',
      params: <dynamic>[
        transaction,
        options.toJson(),
      ],
    );

    final dynamic value = _extractValueFromWrappedResponse(response);
    if (value == null) {
      throw NullResponseException();
    }

    if (value is! Map<String, dynamic>) {
      throw InvalidResultValueException(value);
    }

    return TransactionStatus.fromJson(value);
  }

  /// Returns identity and transaction information about a
  /// confirmed block in the ledger
  Future<Block> getConfirmedBlock({
    required int slot,
    GetBlockOptions? options,
  }) async {
    final response = await _client.request(
      'getConfirmedBlock',
      params: <dynamic>[
        slot,
        options?.toJson(),
      ],
    );

    final dynamic result = _extractResultFromResponse(response);
    if (result == null) {
      throw NullResponseException();
    }

    if (result is! Map<String, dynamic>) {
      throw const FormatException('expecting result to be map and it is not');
    }

    return Block.fromJson(result);
  }

  /// Returns a list of confirmed blocks between two slots
  Future<List<int>> getConfirmedBlocks({
    required int startSlot,
    int? endSlot,
    Commitment? commitment,
  }) async {
    final response = await _client.request(
      'getConfirmedBlocks',
      params: <dynamic>[
        startSlot,
        endSlot,
        commitment?.toJson(),
      ],
    );

    return _convertList(
      _extractResultFromResponse(response),
      (dynamic item) => item as int,
    );
  }

  /// Returns a list of confirmed blocks starting at the given
  /// slot
  Future<List<int>> getConfirmedBlocksWithLimit({
    required int startSlot,
    required int limit,
    Commitment? commitment,
  }) async {
    final response = await _client.request(
      'getConfirmedBlocksWithLimit',
      params: <dynamic>[
        startSlot,
        limit,
        commitment?.toJson(),
      ],
    );

    return _convertList(
      _extractResultFromResponse(response),
      (dynamic item) => item as int,
    );
  }

  /// Returns confirmed signatures for transactions involving an
  /// address backwards in time from the provided signature or
  /// most recent confirmed block
  ///
  ///
  Future<List<TransactionSignatureInformation>>
      getConfirmedSignaturesForAddress2({
    required String pubKey,
    GetSignaturesForAddressOptions? options,
  }) async {
    final response = await _client.request(
      'getConfirmedSignaturesForAddress2',
      params: <dynamic>[
        pubKey,
        options?.toJson(),
      ],
    );

    return _convertList(
      _extractResultFromResponse(response),
      (dynamic item) => TransactionSignatureInformation.fromJson(
          item as Map<String, dynamic>),
    );
  }

  /// Returns transaction details for a confirmed transaction
  Future<TransactionDetails?> getConfirmedTransaction({
    required String signature,
    GetConfirmedTransactionOptions? options,
  }) async {
    final response = await _client.request(
      'getConfirmedTransaction',
      params: <dynamic>[
        signature,
        options?.toJson(),
      ],
    );

    final dynamic result = _extractResultFromResponse(response);
    if (result == null) {
      return null;
    }

    if (result is! Map<String, dynamic>) {
      throw const FormatException('expecting result to be map and it is not');
    }

    return TransactionDetails.fromJson(result);
  }

  dynamic _extractResultFromResponse(dynamic response) {
    if (response is! Map<String, dynamic>) {
      throw InvalidResponseException(response);
    }

    return response['result'];
  }

  dynamic _extractValueFromWrappedResponse(dynamic response) {
    final dynamic result = _extractResultFromResponse(response);
    if (result == null) {
      throw NullResponseException();
    }

    if (result is! Map<String, dynamic>) {
      throw const FormatException(
          'result member must be a map with a "value" key in it');
    }

    return result['value'];
  }

  List<T> _convertList<T>(dynamic list, T Function(dynamic item) convert) {
    if (list is! List<dynamic>) {
      throw const FormatException('input object is not a list');
    }

    return list.map(convert).toList(growable: false);
  }

  Map<K, T> _convertMap<K, T>(
    dynamic map,
    K Function(dynamic key) convertKey,
    T Function(dynamic value) convertValue,
  ) {
    if (map is! Map<dynamic, dynamic>) {
      throw const FormatException('input object is not a map');
    }

    final result = <K, T>{};
    for (final entry in map.entries) {
      result[convertKey(entry.key)] = convertValue(entry.value);
    }

    return result;
  }
}
