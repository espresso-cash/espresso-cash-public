import 'package:decimal/decimal.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:solana_pay/src/constants.dart';
import 'package:solana_pay/src/exceptions.dart';

extension SolanaClientSolanaPay on SolanaClient {
  /// Creates, signs and sends Solana Pay transaction from [payer] to
  /// [recipient].
  ///
  /// If [splToken] is null, the transaction will be in SOL.
  ///
  /// Recipient is `recipient` in the [Solana Pay spec][1].
  ///
  /// Amount is `amount` in the [Solana Pay spec][2].
  ///
  /// [1]:https://github.com/solana-labs/solana-pay/blob/master/SPEC.md#recipient
  /// [2]:https://github.com/solana-labs/solana-pay/blob/master/SPEC.md#amount
  Future<TransactionId> sendSolanaPay({
    required Ed25519HDKeyPair payer,
    required Ed25519HDPublicKey recipient,
    required Decimal amount,
    Ed25519HDPublicKey? splToken,
    Iterable<Ed25519HDPublicKey>? reference,
    String? memo,
    SignatureCallback? onSigned,
    Commitment commitment = Commitment.finalized,
  }) async {
    // Check that the payer and recipient accounts exist.
    final payerInfo = await rpcClient.getAccountInfo(
      payer.address,
      commitment: commitment,
    );
    if (payerInfo == null) {
      throw const CreateTransactionException('Payer not found.');
    }

    final recipientInfo = await rpcClient.getAccountInfo(
      recipient.toBase58(),
      commitment: commitment,
    );
    if (recipientInfo == null) {
      throw const CreateTransactionException('Recipient not found.');
    }

    // A native SOL or SPL token transfer instruction.
    final Instruction instruction;

    // If no SPL token mint is provided, transfer native SOL.
    if (splToken == null) {
      // Check that the payer and recipient are valid native accounts.
      if (payerInfo.owner != SystemProgram.programId) {
        throw const CreateTransactionException('Payer owner invalid.');
      }
      if (payerInfo.executable) {
        throw const CreateTransactionException('Payer executable.');
      }
      if (recipientInfo.owner != SystemProgram.programId) {
        throw const CreateTransactionException('Recipient owner invalid.');
      }
      if (recipientInfo.executable) {
        throw const CreateTransactionException('Recipient executable.');
      }

      // Check that the amount provided doesn't have greater precision than SOL.
      if (amount.scale > solDecimalPlaces) {
        throw const CreateTransactionException('Amount decimals invalid.');
      }

      // Convert input decimal amount to integer lamports.
      final lamports = amount.shift(solDecimalPlaces).toBigInt().toInt();

      // Check that the payer has enough lamports.
      if (lamports > payerInfo.lamports) {
        throw const CreateTransactionException('Insufficient funds.');
      }

      // Create an instruction to transfer native SOL.
      instruction = SystemInstruction.transfer(
        fundingAccount: payer.publicKey,
        recipientAccount: recipient,
        lamports: lamports,
      );
    }
    // Otherwise, transfer SPL tokens from payer's ATA to recipient's ATA
    else {
      // Check that the token provided is an initialized mint
      final mint = await getMint(address: splToken);
      if (!mint.isInitialized) {
        throw const CreateTransactionException('Mint not initialized.');
      }

      // Check that the amount provided doesn't have greater precision than the
      // mint.
      if (amount.scale > mint.decimals) {
        throw const CreateTransactionException('Amount decimals invalid.');
      }

      // Convert input decimal amount to integer tokens according to the mint
      // decimals.
      final value = amount.shift(mint.decimals).toBigInt().toInt();

      // Get the payer's ATA and check that the account exists and can send
      // tokens.
      final payerAccount = await getAssociatedTokenAccount(
        owner: payer.publicKey,
        mint: splToken,
      );
      if (payerAccount == null) {
        throw const CreateTransactionException('Payer ATA not found.');
      }

      // TODO(KB): Check for initialized and not frozen

      // Get the recipient's ATA and check that the account exists and can
      // receive tokens.
      final recipientAccount = await getAssociatedTokenAccount(
        owner: recipient,
        mint: splToken,
      );
      if (recipientAccount == null) {
        throw const CreateTransactionException('Recipient ATA not found.');
      }

      // TODO(KB): Check for initialized and not frozen

      // Check that the payer has enough tokens
      if (value > payerAccount.account.lamports) {
        throw const CreateTransactionException('Insufficient funds.');
      }

      instruction = TokenInstruction.transferChecked(
        amount: value,
        decimals: mint.decimals,
        source: Ed25519HDPublicKey.fromBase58(payerAccount.pubkey),
        mint: mint.address,
        destination: Ed25519HDPublicKey.fromBase58(recipientAccount.pubkey),
        owner: payer.publicKey,
      );
    }

    if (reference != null) {
      instruction.accounts.addAll(
        reference.map((e) => AccountMeta.readonly(pubKey: e, isSigner: false)),
      );
    }

    final message = Message(
      instructions: [
        if (memo != null) MemoInstruction(signers: [], memo: memo),
        instruction,
      ],
    );

    return sendAndConfirmTransaction(
      message: message,
      signers: [payer],
      onSigned: onSigned ?? ignoreOnSigned,
      commitment: commitment,
    );
  }
}
