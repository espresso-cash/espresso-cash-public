import 'package:collection/collection.dart';
import 'package:cryptoplease/config.dart';
import 'package:cryptoplease/core/accounts/bl/account.dart';
import 'package:cryptoplease/core/payments/split_key_payments/transaction/tx_creator.dart';
import 'package:cryptoplease/core/solana_helpers.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/features/incoming_split_key_payment/bl/tx_processor.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/outgoing_payment.dart';
import 'package:dfunc/dfunc.dart';
import 'package:solana/dto.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

class SolanaTxCreator implements TxCreator {
  SolanaTxCreator({
    required SolanaClient solanaClient,
  }) : _client = solanaClient;

  final SolanaClient _client;

  @override
  AsyncEither<TxCreationError, SignedTx> createOutgoingTx({
    required OutgoingTransfer payment,
    required MyAccount account,
  }) async {
    try {
      final message = await _client.createTransfer(
        sender: account.wallet,
        recipient: await payment.getRecipient(),
        tokenAddress: Ed25519HDPublicKey.fromBase58(payment.tokenAddress),
        amount: payment.amount,
        additionalFee: payment.map(
          splitKey: (p) => p.tokenAddress == Token.sol.address
              ? lamportsPerSignature
              : lamportsPerSignature + tokenProgramRent,
          direct: always(0),
        ),
        memo: payment.memo,
        reference: payment.allReferences.map(Ed25519HDPublicKey.fromBase58),
      );
      final tx = await _client.rpcClient.signMessage(
        message,
        [account.wallet],
      );

      return Either.right(tx);
    } on Exception {
      return const Either.left(TxCreationError.other());
    }
  }

  @override
  AsyncEither<TxCreationError, SignedTx> createIncomingTx({
    required String firstPart,
    required String secondPart,
    required String recipient,
    required String tokenAddress,
  }) async {
    final Ed25519HDKeyPair wallet;

    try {
      wallet = await walletFromParts(
        firstPart: firstPart,
        secondPart: secondPart,
      );
    } on Object {
      return const Either.left(TxCreationError.invalidLink());
    }

    try {
      final solBalance = await _client.rpcClient.getBalance(
        wallet.address,
        commitment: Commitment.confirmed,
      );

      final int transferAmount;
      final int remainder;
      if (tokenAddress == Token.sol.address) {
        // SOL payment, just transfer all the money minus transaction fee.
        transferAmount = solBalance - lamportsPerSignature;
        remainder = 0;
      } else {
        // SPL payment. Transfer all the money on SPL account and
        // all the money remaining on the SOL account (minus transaction fee).
        final tokenAccounts = await _client.rpcClient.getTokenAccountsByOwner(
          wallet.address,
          TokenAccountsFilter.byMint(tokenAddress),
          commitment: Commitment.confirmed,
          encoding: Encoding.jsonParsed,
        );
        final tokenAccount = tokenAccounts.firstOrNull;

        if (tokenAccount == null) {
          return const Either.left(TxCreationError.invalidLink());
        }

        transferAmount = await _client.rpcClient
            .getTokenAccountBalance(
              tokenAccount.pubkey,
              commitment: Commitment.confirmed,
            )
            .then((v) => int.parse(v.amount));

        // If recipient has already associated account, then we can
        // transfer all the money from SOL account of this temp wallet
        // to SOL account of the recipient (minus the transaction fee).
        remainder = await _client.hasAssociatedTokenAccount(
          owner: Ed25519HDPublicKey.fromBase58(recipient),
          mint: Ed25519HDPublicKey.fromBase58(tokenAddress),
        )
            ? solBalance - lamportsPerSignature
            : 0;
      }

      if (transferAmount <= 0) {
        final transactions = await _client.rpcClient.getTransactionsList(
          wallet.publicKey,
          limit: 2,
          commitment: Commitment.confirmed,
        );
        if (transactions.length < 2) {
          return const Either.left(TxCreationError.invalidLink());
        } else {
          final transaction = transactions.first;
          if (transaction.transaction.transferDestinationOrNull() ==
              recipient) {
            return const Either.left(TxCreationError.consumedByRecipient());
          }

          return const Either.left(TxCreationError.consumedByOther());
        }
      }

      final message = tokenAddress == Token.sol.address
          ? await _client.createSolTransfer(
              sender: wallet,
              recipient: Ed25519HDPublicKey.fromBase58(recipient),
              amount: transferAmount + remainder,
            )
          : await _client.createSplTransfer(
              sender: wallet,
              solanaAddress: Ed25519HDPublicKey.fromBase58(recipient),
              additionalFee: remainder,
              amount: transferAmount,
              tokenAddress: Ed25519HDPublicKey.fromBase58(tokenAddress),
            );
      final signed = await _client.rpcClient.signMessage(message, [wallet]);

      return Either.right(signed);
    } on Exception {
      return const Either.left(TxCreationError.other());
    }
  }
}

extension on Transaction {
  String? transferDestinationOrNull() {
    final tx = this;
    if (tx is! ParsedTransaction) return null;

    final parsed = tx.message.instructions.whereType<ParsedInstruction>();

    return parsed
            .map((i) => i.mapOrNull(system: (i) => i.parsed))
            .whereNotNull()
            .map(
              (i) => i.mapOrNull(
                transfer: (i) => i.info.destination,
                transferChecked: (i) => i.info.destination,
              ),
            )
            .whereNotNull()
            .firstOrNull ??
        parsed
            .map((i) => i.mapOrNull(splToken: (i) => i.parsed))
            .whereNotNull()
            .map(
              (i) => i.mapOrNull(
                transfer: (i) => i.info.destination,
                transferChecked: (i) => i.info.destination,
              ),
            )
            .whereNotNull()
            .firstOrNull;
  }
}
