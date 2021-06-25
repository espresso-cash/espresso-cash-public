import 'package:solana/solana.dart';
import 'package:solana/src/encoder/encoder.dart';
import 'package:solana/src/hd_keypair.dart';
import 'package:solana/src/spl_token/spl_token.dart';
import 'package:solana/src/spl_token/token_amount.dart';
import 'package:solana/src/system_program/system_program.dart';
import 'package:solana/src/types/signature_status.dart';
import 'package:solana/src/types/tx_signature.dart';

/// Convenient object for common operations
class Wallet {
  Wallet({
    required this.signer,
    required RPCClient rpcClient,
  }) : _rpcClient = rpcClient;

  Future<TxSignature> _genericTransfer({
    required String source,
    required String destination,
    required int lamports,
    String? memo,
    Commitment? commitment,
  }) {
    final instructions = [
      SystemInstruction.transfer(
        source: source,
        destination: destination,
        lamports: lamports,
      ),
      if (memo != null)
        Instruction.memo(
          signers: [AccountMeta.writeable(pubKey: source, isSigner: true)],
          memo: Buffer.fromString(memo),
        ),
    ];

    final message = Message(
      instructions: instructions,
    );

    return _rpcClient.signAndSendTransaction(
      message,
      [signer],
      commitment: commitment,
    );
  }

  /// Creates a solana transfer message to send [lamports] SOL tokens from [source]
  /// to [destination].
  Future<TxSignature> transfer({
    required String destination,
    required int lamports,
    Commitment? commitment,
  }) =>
      _genericTransfer(
        source: address,
        destination: destination,
        lamports: lamports,
        commitment: commitment,
      );

  /// Creates a solana transfer message to send [lamports] SOL tokens from [source]
  /// to [destination].
  ///
  /// To add additional data to the transaction you can use the [memo] field.
  /// It accepts an arbitrary string of utf-8 characters. As of now the maximum
  /// allowed length for the memo is 566 bytes of utf-8 data.
  ///
  /// NOTE: This constructor creates a transaction with 2 instructions when a [memo]
  /// is provided.
  Future<TxSignature> transferWithMemo({
    required String destination,
    required int lamports,
    required String memo,
    Commitment? commitment,
  }) =>
      _genericTransfer(
        source: address,
        destination: destination,
        lamports: lamports,
        memo: memo,
        commitment: commitment,
      );

  Future<TxSignature> airdrop(
    int amount, {
    Commitment? commitment,
  }) async {
    final signature = await _rpcClient.requestAirdrop(
      address,
      amount,
      commitment: commitment,
    );
    await _rpcClient.waitForSignatureStatus(
      signature,
      commitment ?? TxStatus.finalized,
    );

    return signature;
  }

  Future<TokenAmount> getTokenBalance({
    required String mint,
    Commitment? commitment,
  }) async {
    final token = await SPLToken.readonly(
      mint: mint,
      rpcClient: _rpcClient,
    );
    return _rpcClient.getTokenAccountBalance(
      associatedTokenAccountAddress: await token.getAssociatedTokenAddress(
        owner: address,
      ),
      commitment: commitment,
    );
  }

  Future<int> getLamports({Commitment? commitment}) =>
      _rpcClient.getBalance(address, commitment: commitment);

  String get address => signer.address;

  final HDKeyPair signer;
  final RPCClient _rpcClient;
}
