import 'dart:async';

import 'package:collection/collection.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/bl/tokens/token_list.dart';
import 'package:solana/dto.dart' hide Instruction;
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:solana/solana_pay.dart';

extension SolanaPayRequestExt on SolanaPayRequest {
  Token? token(TokenList tokenList) {
    final splToken = this.splToken;
    if (splToken == null) return Token.sol;

    return tokenList.findTokenByMint(splToken.toBase58());
  }
}

extension SolanaClientExt on SolanaClient {
  Future<Iterable<ProgramAccount>> getSplAccounts(String address) =>
      rpcClient.getTokenAccountsByOwner(
        address,
        const TokenAccountsFilter.byProgramId(TokenProgram.programId),
        commitment: Commitment.confirmed,
        encoding: Encoding.jsonParsed,
      );

  Future<bool> isSignatureSubmitted(String signature) async {
    final existing = await rpcClient.getSignatureStatuses(
      [signature],
      searchTransactionHistory: true,
    );

    return existing.firstOrNull != null;
  }

  /// Creates transfer message from [sender] to [recipient] with [amount].
  ///
  /// If [additionalFee] > 0, it will always be sent as lamports,
  /// even if the transfer is of an SPL token.
  Future<Message> createTransfer({
    required Wallet sender,
    required Ed25519HDPublicKey recipient,
    required Ed25519HDPublicKey tokenAddress,
    required int amount,
    int additionalFee = 0,
    String? memo,
    Iterable<Ed25519HDPublicKey>? reference,
  }) =>
      tokenAddress == Token.sol.publicKey
          ? createSolTransfer(
              sender: sender,
              recipient: recipient,
              amount: amount + additionalFee,
              memo: memo,
              reference: reference,
            )
          : createSplTransfer(
              sender: sender,
              solanaAddress: recipient,
              amount: amount,
              tokenAddress: tokenAddress,
              additionalFee: additionalFee,
              memo: memo,
              reference: reference,
            );

  Future<Message> createSolTransfer({
    required Wallet sender,
    required Ed25519HDPublicKey recipient,
    required int amount,
    String? memo,
    Iterable<Ed25519HDPublicKey>? reference,
  }) async =>
      Message(
        instructions: [
          // We can skip memo, but also disallow empty memo which does not
          // make sense
          if (memo != null && memo.isNotEmpty)
            MemoInstruction(signers: [sender.publicKey], memo: memo),
          Instruction(
            accounts: [
              AccountMeta.writeable(pubKey: sender.publicKey, isSigner: false),
              AccountMeta.writeable(pubKey: recipient, isSigner: false),
              if (reference != null)
                ...reference.map(
                  (r) => AccountMeta.readonly(pubKey: r, isSigner: false),
                ),
            ],
            data: ByteArray.merge([
              SystemProgram.transferInstructionIndex,
              ByteArray.u64(amount),
            ]),
            programId: SystemProgram.id,
          ),
        ],
      );

  Future<Message> createSplTransfer({
    required Wallet sender,
    required Ed25519HDPublicKey solanaAddress,
    required int amount,
    required Ed25519HDPublicKey tokenAddress,
    required int additionalFee,
    String? memo,
    Iterable<Ed25519HDPublicKey>? reference,
  }) async {
    final associatedAddress = await findAssociatedTokenAddress(
      owner: solanaAddress,
      mint: tokenAddress,
    );

    final hasAssociatedAccount = await hasAssociatedTokenAccount(
      owner: solanaAddress,
      mint: tokenAddress,
    );

    final associatedSender = await getAssociatedTokenAccount(
      owner: sender.publicKey,
      mint: tokenAddress,
    );

    if (associatedSender == null) {
      throw StateError(
        'Sender does not have associated account, '
        'yet outgoing SPL token transfer was requested',
      );
    }

    Instruction additionalFeeInstruction() => Instruction(
          accounts: [
            AccountMeta.writeable(pubKey: sender.publicKey, isSigner: false),
            AccountMeta.writeable(pubKey: solanaAddress, isSigner: false),
          ],
          data: ByteArray.merge([
            SystemProgram.transferInstructionIndex,
            ByteArray.u64(additionalFee),
          ]),
          programId: SystemProgram.id,
        );

    Instruction associatedAccountInstruction() =>
        AssociatedTokenAccountInstruction.createAccount(
          mint: tokenAddress,
          address: associatedAddress,
          owner: solanaAddress,
          funder: sender.publicKey,
        );

    return Message(
      instructions: [
        // We can skip memo, but also disallow empty memo which does not
        // make sense
        if (memo != null && memo.isNotEmpty)
          MemoInstruction(signers: [sender.publicKey], memo: memo),
        if (!hasAssociatedAccount) associatedAccountInstruction(),
        if (additionalFee > 0) additionalFeeInstruction(),
        Instruction(
          accounts: [
            AccountMeta.writeable(
              pubKey: Ed25519HDPublicKey.fromBase58(associatedSender.pubkey),
              isSigner: false,
            ),
            AccountMeta.writeable(pubKey: associatedAddress, isSigner: false),
            AccountMeta.readonly(pubKey: sender.publicKey, isSigner: true),
            if (reference != null)
              ...reference.map(
                (r) => AccountMeta.readonly(pubKey: r, isSigner: false),
              ),
          ],
          data: ByteArray.merge([
            TokenProgram.transferInstructionIndex,
            ByteArray.u64(amount),
          ]),
          programId: TokenProgram.id,
        ),
      ],
    );
  }
}
