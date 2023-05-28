// ignore_for_file: cast_nullable_to_non_nullable

import 'dart:typed_data';

import 'package:solana/dto.dart';
import 'package:solana/solana.dart';
import 'package:solana/src/programs/token_program/raw_mint.dart';

extension SolanaClientTokenProgram on SolanaClient {
  /// Gets information about mint with [address] public key.
  ///
  /// Throws [TokenAccountNotFoundException] if info is not found.
  Future<Mint> getMint({
    required Ed25519HDPublicKey address,
    Commitment commitment = Commitment.finalized,
  }) async {
    final info = await rpcClient
        .getAccountInfo(
          address.toBase58(),
          commitment: commitment,
          encoding: Encoding.base64,
        )
        .value;

    if (info == null) throw const TokenAccountNotFoundException();

    final raw = RawMint.fromBorsh(
      Uint8List.fromList((info.data as BinaryAccountData).data),
    );

    return Mint(
      address: address,
      supply: raw.supply,
      decimals: raw.decimals,
      isInitialized: raw.isInitialized,
      mintAuthority: raw.mintAuthorityOption == 0 ? null : raw.mintAuthority,
      freezeAuthority:
          raw.freezeAuthorityOption == 0 ? null : raw.freezeAuthority,
    );
  }

  /// Get the minimum lamport balance for a rent-exempt mint.
  Future<int> getMinimumBalanceForMintRentExemption({
    Commitment? commitment,
  }) =>
      rpcClient.getMinimumBalanceForRentExemption(
        TokenProgram.neededMintAccountSpace,
        commitment: commitment,
      );

  /// Create a new token owned by [mintAuthority] with number of [decimals].
  ///
  /// Optionally, you can specify a [freezeAuthority]. By default the
  /// [freezeAuthority] is not set.
  ///
  /// Finally, you can also send the transaction with optional [commitment].
  Future<Mint> initializeMint({
    required Ed25519HDKeyPair mintAuthority,
    required int decimals,
    Ed25519HDPublicKey? freezeAuthority,
    SignatureCallback? onSigned,
    Commitment commitment = Commitment.finalized,
  }) async {
    final mint = await Ed25519HDKeyPair.random();

    const space = TokenProgram.neededMintAccountSpace;
    final rent = await rpcClient.getMinimumBalanceForRentExemption(
      space,
      commitment: commitment,
    );

    final instructions = TokenInstruction.createAccountAndInitializeMint(
      mint: mint.publicKey,
      mintAuthority: mintAuthority.publicKey,
      freezeAuthority: freezeAuthority,
      rent: rent,
      space: space,
      decimals: decimals,
    );

    final message = Message(instructions: instructions);

    await sendAndConfirmTransaction(
      message: message,
      signers: [mintAuthority, mint],
      onSigned: onSigned ?? ignoreOnSigned,
      commitment: commitment,
    );

    return getMint(address: mint.publicKey, commitment: commitment);
  }

  /// Mint [destination] with [amount] tokens.
  Future<TransactionId> mintTo({
    required Ed25519HDPublicKey mint,
    required Ed25519HDPublicKey destination,
    required int amount,
    required Ed25519HDKeyPair authority,
    SignatureCallback? onSigned,
    Commitment commitment = Commitment.finalized,
  }) async {
    final instruction = TokenInstruction.mintTo(
      mint: mint,
      destination: destination,
      authority: authority.publicKey,
      amount: amount,
    );

    return sendAndConfirmTransaction(
      message: Message.only(instruction),
      signers: [authority],
      onSigned: onSigned ?? ignoreOnSigned,
      commitment: commitment,
    );
  }

  /// Transfers [amount] SPL token with [mint] from this wallet to the
  /// [destination] address with an optional [memo].
  ///
  /// For [commitment] parameter description [see this document][1]
  /// [Commitment.processed] is not supported as [commitment].
  ///
  /// [1]: https://docs.solana.com/developing/clients/jsonrpc-api#configuring-state-commitment
  Future<TransactionId> transferSplToken({
    required Ed25519HDPublicKey mint,
    required Ed25519HDPublicKey destination,
    required int amount,
    required Wallet owner,
    String? memo,
    SignatureCallback? onSigned,
    Commitment commitment = Commitment.finalized,
  }) async {
    final associatedRecipientAccount = await getAssociatedTokenAccount(
      owner: destination,
      mint: mint,
      commitment: commitment,
    );
    final associatedSenderAccount = await getAssociatedTokenAccount(
      owner: owner.publicKey,
      mint: mint,
      commitment: commitment,
    );
    // Throw an appropriate exception if the sender has no associated
    // token account
    if (associatedSenderAccount == null) {
      throw NoAssociatedTokenAccountException(owner.address, mint.toBase58());
    }
    // Also throw an adequate exception if the recipient has no associated
    // token account
    if (associatedRecipientAccount == null) {
      throw NoAssociatedTokenAccountException(
        destination.toBase58(),
        mint.toBase58(),
      );
    }

    final instruction = TokenInstruction.transfer(
      source: Ed25519HDPublicKey.fromBase58(associatedSenderAccount.pubkey),
      destination:
          Ed25519HDPublicKey.fromBase58(associatedRecipientAccount.pubkey),
      owner: owner.publicKey,
      amount: amount,
    );

    final message = Message(
      instructions: [
        instruction,
        if (memo != null && memo.isNotEmpty)
          MemoInstruction(signers: [owner.publicKey], memo: memo),
      ],
    );

    return sendAndConfirmTransaction(
      message: message,
      signers: [owner],
      onSigned: onSigned ?? ignoreOnSigned,
      commitment: commitment,
    );
  }
}
