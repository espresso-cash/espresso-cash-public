import 'package:collection/collection.dart';
import 'package:cryptoplease/config.dart';
import 'package:cryptoplease/core/solana_helpers.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/features/incoming_split_key_payment/bl/bloc.dart';
import 'package:dfunc/dfunc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/dto.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

part 'tx_processor.freezed.dart';

class TxProcessor {
  TxProcessor(this._solanaClient);

  final SolanaClient _solanaClient;

  AsyncEither<TxCreationError, SignedTx> createTx({
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
      final solBalance = await _solanaClient.rpcClient.getBalance(
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
        final tokenAccounts =
            await _solanaClient.rpcClient.getTokenAccountsByOwner(
          wallet.address,
          TokenAccountsFilter.byMint(tokenAddress),
          commitment: Commitment.confirmed,
          encoding: Encoding.jsonParsed,
        );
        final tokenAccount = tokenAccounts.firstOrNull;

        if (tokenAccount == null) {
          return const Either.left(TxCreationError.invalidLink());
        }

        transferAmount = await _solanaClient.rpcClient
            .getTokenAccountBalance(
              tokenAccount.pubkey,
              commitment: Commitment.confirmed,
            )
            .then((v) => int.parse(v.amount));

        // If recipient has already associated account, then we can
        // transfer all the money from SOL account of this temp wallet
        // to SOL account of the recipient (minus the transaction fee).
        remainder = await _solanaClient.hasAssociatedTokenAccount(
          owner: Ed25519HDPublicKey.fromBase58(recipient),
          mint: Ed25519HDPublicKey.fromBase58(tokenAddress),
        )
            ? solBalance - lamportsPerSignature
            : 0;
      }

      if (transferAmount <= 0) {
        final transactions = await _solanaClient.rpcClient.getTransactionsList(
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
          ? await _solanaClient.createSolTransfer(
              sender: wallet,
              recipient: Ed25519HDPublicKey.fromBase58(recipient),
              amount: transferAmount + remainder,
            )
          : await _solanaClient.createSplTransfer(
              sender: wallet,
              solanaAddress: Ed25519HDPublicKey.fromBase58(recipient),
              additionalFee: remainder,
              amount: transferAmount,
              tokenAddress: Ed25519HDPublicKey.fromBase58(tokenAddress),
            );
      final signed =
          await _solanaClient.rpcClient.signMessage(message, [wallet]);

      return Either.right(signed);
    } on Exception {
      return const Either.left(TxCreationError.other());
    }
  }

  AsyncEither<SplitKeyIncomingPaymentError, SignedTx> sendPayment(
    SignedTx tx,
  ) async {
    try {
      await _solanaClient.rpcClient.sendTransaction(
        tx.encode(),
        preflightCommitment: Commitment.confirmed,
      );

      return Either.right(tx);
    } on JsonRpcException catch (e) {
      final txError = e.transactionError;

      switch (txError) {
        case TransactionError.alreadyProcessed:
          return Either.right(tx);
        case TransactionError.blockhashNotFound:
          return _solanaClient.rpcClient
              .getTransaction(tx.id)
              .toEither()
              .foldAsync(
                always(
                  const Either.left(SplitKeyIncomingPaymentError.invalidTx()),
                ),
                always(Either.right(tx)),
              );
        default:
          return const Either.left(SplitKeyIncomingPaymentError.invalidTx());
      }
    } on Exception {
      return Either.left(SplitKeyIncomingPaymentError.failedToSubmit(tx));
    }
  }

  AsyncEither<SplitKeyIncomingPaymentError, SignedTx> wait(SignedTx tx) async {
    try {
      await _solanaClient.waitForSignatureStatus(
        tx.id,
        status: Commitment.confirmed,
        timeout: waitForSignatureDefaultTimeout,
      );

      return Either.right(tx);
    } on Object {
      return Either.left(SplitKeyIncomingPaymentError.failedToConfirm(tx));
    }
  }
}

Future<Wallet> walletFromParts({
  required String firstPart,
  required String secondPart,
}) async {
  final keyPart1 = ByteArray.fromBase58(firstPart).toList();
  final keyPart2 = ByteArray.fromBase58(secondPart).toList();

  return Wallet.fromPrivateKeyBytes(privateKey: keyPart1 + keyPart2);
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

@freezed
class TxCreationError with _$TxCreationError {
  const factory TxCreationError.invalidLink() = _InvalidLink;
  const factory TxCreationError.consumedByRecipient() = _ConsumedByRecipient;
  const factory TxCreationError.consumedByOther() = _ConsumedByOther;
  const factory TxCreationError.other() = _Other;
}
