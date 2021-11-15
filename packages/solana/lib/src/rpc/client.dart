import 'package:json_annotation/json_annotation.dart';
import 'package:solana/solana.dart';
import 'package:solana/src/gen/annotations.dart';
import 'package:solana/src/rpc/dto/dto.dart';
import 'package:solana/src/rpc_client/json_rpc_client.dart';

part 'client.g.dart';
part 'client.rpc.dart';

@SolanaRpcClient()
abstract class RpcClient {
  factory RpcClient(String url) => _RpcClient(url);

  /// Returns all information associated with the [account] of provided Pubkey.
  Future<RpcResponse<AccountInfo>> getAccountInfo(
    String account, {
    String? encoding,
    Commitment? commitment,
  });

  /// Returns the balance of the account of provided Pubkey.
  ///
  /// [account] – Pubkey of account to query, as base-58 encoded string
  Future<RpcResponse<int>> getBalance(
    String account, {
    Commitment? commitment,
  });

  /// Returns the current block height of the node.
  Future<int> getBlockHeight({Commitment? commitment});

  /// Returns recent block production information from the current or previous
  /// epoch.
  Future<RpcResponse<BlockProduction>> getBlockProduction({
    Commitment? commitment,
    SlotRange? range,
    String? identity,
  });

  /// Returns commitment for particular block.
  Future<int> getBlockCommitment(int block);

  /// Returns a recent block hash from the ledger, and a fee schedule that
  /// can be used to compute the cost of submitting a transaction using it.
  Future<RpcResponse<RecentBlockhash>> getRecentBlockhash({
    Commitment? commitment,
  });

  /// Requests an airdrop of [lamports] to a Pubkey [account].
  Future<String> requestAirdrop(
    String account,
    int lamports, {
    Commitment? commitment,
  });

  /// Returns a recent block hash from the ledger, a fee schedule that can be
  /// used to compute the cost of submitting a transaction using it, and the
  /// last slot in which the blockhash will be valid.
  Future<RpcResponse<BlockCommitment>> getFees({
    Commitment? commitment,
  });
}
