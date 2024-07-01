import 'package:collection/collection.dart';
import 'package:decimal/decimal.dart';
import 'package:solana/dto.dart'
    show FutureContextResultExt, ParsedTransaction, TransactionDetails;
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:solana/src/solana_pay/exceptions.dart';

extension SolanaClientSolanaPay on SolanaClient {
  /// Creates Solana Pay transaction from [payer] to [recipient].
  ///
  /// If [splToken] is null, the transaction will be in SOL.
  ///
  /// Recipient is `recipient` in the [Solana Pay spec][1].
  ///
  /// Amount is `amount` in the [Solana Pay spec][2].
  ///
  /// [1]:https://github.com/solana-labs/solana-pay/blob/master/SPEC.md#recipient
  /// [2]:https://github.com/solana-labs/solana-pay/blob/master/SPEC.md#amount
  Future<Message> createSolanaPayMessage({
    required Ed25519HDKeyPair payer,
    required Ed25519HDPublicKey recipient,
    required Decimal amount,
    Ed25519HDPublicKey? splToken,
    Iterable<Ed25519HDPublicKey>? reference,
    String? memo,
    Commitment commitment = Commitment.finalized,
  }) async {
    // Check that the payer and recipient accounts exist.
    final payerInfo = await rpcClient
        .getAccountInfo(payer.address, commitment: commitment)
        .value;
    if (payerInfo == null) {
      throw const CreateTransactionException('Payer not found.');
    }

    final recipientInfo = await rpcClient
        .getAccountInfo(recipient.toBase58(), commitment: commitment)
        .value;
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

    return Message(
      instructions: [
        if (memo != null) MemoInstruction(signers: const [], memo: memo),
        instruction,
      ],
    );
  }

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
  }) async =>
      sendAndConfirmTransaction(
        message: await createSolanaPayMessage(
          payer: payer,
          recipient: recipient,
          amount: amount,
          splToken: splToken,
          reference: reference,
          memo: memo,
          commitment: commitment,
        ),
        signers: [payer],
        onSigned: onSigned ?? ignoreOnSigned,
        commitment: commitment,
      );

  /// Finds the oldest transaction signature referencing a given public key.
  Future<TransactionId?> findSolanaPayTransaction({
    required Ed25519HDPublicKey reference,
    Commitment commitment = Commitment.finalized,
  }) async {
    final signatures = await rpcClient.getSignaturesForAddress(
      reference.toBase58(),
      commitment: commitment,
    );

    if (signatures.isEmpty) return null;

    // TODO(KB): Support cases when there are more than [limit] signatures.

    return signatures.last.signature;
  }

  /// Validates that a given transaction signature corresponds with a
  /// transaction containing a valid Solana Pay transfer.
  Future<TransactionDetails> validateSolanaPayTransaction({
    required TransactionId signature,
    required Ed25519HDPublicKey recipient,
    required Decimal amount,
    Ed25519HDPublicKey? splToken,
    Iterable<Ed25519HDPublicKey>? reference,
    TokenProgramType tokenProgramType = TokenProgramType.tokenProgram,
    Commitment commitment = Commitment.finalized,
  }) async {
    final response = await rpcClient.getTransaction(
      signature,
      commitment: commitment,
    );

    if (response == null) {
      throw const ValidateTransactionException('Transaction not found.');
    }

    final meta = response.meta;
    if (meta == null) {
      throw const ValidateTransactionException('Missing meta.');
    }

    if (meta.err != null) {
      throw const ValidateTransactionException('Transaction error.');
    }

    final Decimal preAmount, postAmount;
    if (splToken == null) {
      final accountIndex = (response.transaction as ParsedTransaction)
          .message
          .accountKeys
          .indexWhere((a) => a.pubkey == recipient.toBase58());
      if (accountIndex == -1) {
        throw const ValidateTransactionException('Recipient not found.');
      }

      preAmount = Decimal.fromInt(meta.preBalances[accountIndex])
          .shift(-solDecimalPlaces);
      postAmount = Decimal.fromInt(meta.postBalances[accountIndex])
          .shift(-solDecimalPlaces);
    } else {
      final recipientATA = await findAssociatedTokenAddress(
        owner: recipient,
        mint: splToken,
        tokenProgramType: tokenProgramType,
      );
      final accountIndex = (response.transaction as ParsedTransaction)
          .message
          .accountKeys
          .indexWhere((a) => a.pubkey == recipientATA.toBase58());
      if (accountIndex == -1) {
        throw const ValidateTransactionException('Recipient not found.');
      }

      final preBalance = meta.preTokenBalances
          .firstWhereOrNull((a) => a.accountIndex == accountIndex);
      final postBalance = meta.postTokenBalances
          .firstWhereOrNull((a) => a.accountIndex == accountIndex);

      preAmount =
          Decimal.parse(preBalance?.uiTokenAmount.uiAmountString ?? '0');
      postAmount =
          Decimal.parse(postBalance?.uiTokenAmount.uiAmountString ?? '0');
    }

    if (postAmount - preAmount < amount) {
      throw const ValidateTransactionException('Amount not transferred.');
    }

    if (reference != null) {
      final keys = (response.transaction as ParsedTransaction)
          .message
          .accountKeys
          .map((e) => e.pubkey);
      if (reference.any((e) => !keys.contains(e.toBase58()))) {
        throw const ValidateTransactionException('Reference not found.');
      }
    }

    return response;
  }

  /// Processes the transaction from a Solana Pay transaction request link.
  ///
  /// Transaction is `transaction` in the [Solana Pay Transaction Request spec][1].
  ///
  /// Signer is account the that may [sign the transaction][2].
  ///
  /// Commitment is used when getting latest blockhash.
  ///
  /// If [ignoreSignerVerification] is true, signature verification will be
  /// skipped for [signer]. Only applies when the transaction signatures are nonempty
  ///
  /// [1]: https://github.com/solana-labs/solana-pay/blob/master/SPEC.md#link
  /// [2]: https://github.com/solana-labs/solana-pay/blob/master/SPEC.md#post-request
  Future<SignedTx> processSolanaPayTransactionRequest({
    required String transaction,
    required Ed25519HDPublicKey signer,
    Commitment commitment = Commitment.finalized,
    bool ignoreSignerVerification = false,
  }) async {
    final tx = SignedTx.decode(transaction);

    List<Signature> signatures = tx.signatures;
    CompiledMessage compiledMessage = tx.compiledMessage;

    if (signatures.isEmpty ||
        (signatures.length == 1 && signatures.first.publicKey == signer)) {
      final addressTableLookups = compiledMessage.map(
        legacy: (_) => <MessageAddressTableLookup>[],
        v0: (v0) => v0.addressTableLookups,
      );

      final lookUpTables =
          await rpcClient.getAddressLookUpTableAccounts(addressTableLookups);

      final message =
          tx.decompileMessage(addressLookupTableAccounts: lookUpTables);

      final isLegacyTx = tx.version == TransactionVersion.legacy;

      final latestBlockhash = await rpcClient.getLatestBlockhash(
        commitment: commitment,
      );

      compiledMessage = isLegacyTx
          ? message.compile(
              recentBlockhash: latestBlockhash.value.blockhash,
              feePayer: signer,
            )
          : message.compileV0(
              recentBlockhash: latestBlockhash.value.blockhash,
              feePayer: signer,
              addressLookupTableAccounts: lookUpTables,
            );

      signatures = [
        Signature(List.filled(64, 0), publicKey: signer),
      ];
    } else {
      final feePayer = tx.compiledMessage.accountKeys.first;

      if (feePayer != signatures.first.publicKey) {
        throw const FetchTransactionException('Invalid fee payer');
      }

      for (final sig in signatures) {
        final signature = sig.bytes;
        final publicKey = sig.publicKey;

        if (ignoreSignerVerification && publicKey == signer) {
          continue;
        }

        final isValid = await verifySignature(
          message: compiledMessage.toByteArray().toList(),
          signature: signature,
          publicKey: Ed25519HDPublicKey.fromBase58(publicKey.toString()),
        );

        if (!isValid) {
          throw const FetchTransactionException('Invalid signature');
        }
      }
    }

    return SignedTx(
      compiledMessage: compiledMessage,
      signatures: signatures,
    );
  }
}
