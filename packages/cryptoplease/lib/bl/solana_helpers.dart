import 'dart:async';

import 'package:collection/collection.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:solana/dto.dart' hide Instruction;
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

Future<String> computeAssociatedTokenAccountAddress({
  required String owner,
  required String mint,
}) =>
    findProgramAddress(
      seeds: [
        Buffer.fromBase58(owner),
        Buffer.fromBase58(TokenProgram.programId),
        Buffer.fromBase58(mint),
      ],
      programId: AssociatedTokenAccountProgram.programId,
    );

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
    required String recipient,
    required String tokenAddress,
    required int amount,
    int additionalFee = 0,
    String? memo,
    String? reference,
  }) =>
      tokenAddress == Token.sol.address
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
    required String recipient,
    required int amount,
    String? memo,
    String? reference,
  }) async =>
      Message(
        instructions: [
          // We can skip memo, but also disallow empty memo which does not
          // make sense
          if (memo != null && memo.isNotEmpty)
            MemoInstruction(signers: [sender.address], memo: memo),
          Instruction(
            accounts: [
              AccountMeta.writeable(pubKey: sender.address, isSigner: false),
              AccountMeta.writeable(pubKey: recipient, isSigner: false),
              if (reference != null)
                AccountMeta.readonly(pubKey: reference, isSigner: false),
            ],
            data: Buffer.fromConcatenatedByteArrays([
              SystemProgram.transferInstructionIndex,
              Buffer.fromUint64(amount),
            ]),
            programId: SystemProgram.programId,
          ),
        ],
      );

  Future<Message> createSplTransfer({
    required Wallet sender,
    required String solanaAddress,
    required int amount,
    required String tokenAddress,
    required int additionalFee,
    String? memo,
    String? reference,
  }) async {
    final associatedAddress = await getProgramAccountAddress(
      owner: solanaAddress,
      mint: tokenAddress,
    );

    final hasAssociatedAccount = await hasAssociatedTokenAccount(
      owner: solanaAddress,
      mint: tokenAddress,
    );

    final associatedSender = await getAssociatedTokenAccount(
      owner: sender.address,
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
            AccountMeta.writeable(pubKey: sender.address, isSigner: false),
            AccountMeta.writeable(pubKey: solanaAddress, isSigner: false),
          ],
          data: Buffer.fromConcatenatedByteArrays([
            SystemProgram.transferInstructionIndex,
            Buffer.fromUint64(additionalFee),
          ]),
          programId: SystemProgram.programId,
        );

    Instruction associatedAccountInstruction() =>
        AssociatedTokenAccountInstruction(
          mint: tokenAddress,
          address: associatedAddress,
          owner: solanaAddress,
          funder: sender.address,
        );

    return Message(
      instructions: [
        // We can skip memo, but also disallow empty memo which does not
        // make sense
        if (memo != null && memo.isNotEmpty)
          MemoInstruction(signers: [sender.address], memo: memo),
        if (!hasAssociatedAccount) associatedAccountInstruction(),
        if (additionalFee > 0) additionalFeeInstruction(),
        Instruction(
          accounts: [
            AccountMeta.writeable(
              pubKey: associatedSender.pubkey,
              isSigner: false,
            ),
            AccountMeta.writeable(pubKey: associatedAddress, isSigner: false),
            AccountMeta.readonly(pubKey: sender.address, isSigner: true),
            if (reference != null)
              AccountMeta.readonly(pubKey: reference, isSigner: false),
          ],
          data: Buffer.fromConcatenatedByteArrays([
            TokenProgram.transferInstructionIndex,
            Buffer.fromUint64(amount),
          ]),
          programId: TokenProgram.programId,
        ),
      ],
    );
  }
}
