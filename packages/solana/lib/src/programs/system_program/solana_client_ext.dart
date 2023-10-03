import 'package:solana/solana.dart';

extension SolanaClientSystemProgram on SolanaClient {
  /// Creates a solana transfer message to send [lamports] SOL tokens from
  /// [source] to [destination].
  ///
  /// To add additional data to the transaction you can use the [memo] field. It
  /// accepts an arbitrary string of utf-8 characters. As of now the maximum
  /// allowed length for the memo is 566 bytes of utf-8 data.
  Future<TransactionId> transferLamports({
    required Ed25519HDKeyPair source,
    required Ed25519HDPublicKey destination,
    required int lamports,
    String? memo,
    SignatureCallback? onSigned,
    Commitment commitment = Commitment.finalized,
  }) {
    final instructions = [
      SystemInstruction.transfer(
        fundingAccount: source.publicKey,
        recipientAccount: destination,
        lamports: lamports,
      ),
      if (memo != null)
        MemoInstruction(signers: [source.publicKey], memo: memo),
    ];

    return sendAndConfirmTransaction(
      message: Message(instructions: instructions),
      signers: [source],
      onSigned: onSigned ?? ignoreOnSigned,
      commitment: commitment,
    );
  }

  /// Request airdrop for [lamports] amount to this wallet's account.
  ///
  /// For [commitment] parameter description [see this document][1]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [1]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  Future<String> requestAirdrop({
    required Ed25519HDPublicKey address,
    required int lamports,
    Commitment commitment = Commitment.finalized,
  }) async {
    final signature = await rpcClient.requestAirdrop(
      address.toBase58(),
      lamports,
      commitment: commitment,
    );
    await waitForSignatureStatus(
      signature,
      status: commitment,
    );

    return signature;
  }
}
