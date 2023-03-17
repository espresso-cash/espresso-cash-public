import 'package:collection/collection.dart';
import 'package:dfunc/dfunc.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/dto.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/amount.dart';
import '../../../../core/currency.dart';
import '../../../../core/tokens/token.dart';
import '../../models/outgoing_split_key_payment.dart';
import 'repository.dart';

@injectable
class RecoverPendingWatcher {
  RecoverPendingWatcher(
    this._client,
    this._repository, {
    @factoryParam required Ed25519HDPublicKey userPublicKey,
  }) : _userPublicKey = userPublicKey;

  final SolanaClient _client;
  final OSKPRepository _repository;
  final Ed25519HDPublicKey _userPublicKey;

  Future<void> init() async {
    const fetchLimit = 100;

    final details = await _client.rpcClient.getTransactionsList(
      limit: fetchLimit,
      _userPublicKey,
      encoding: Encoding.base64,
      commitment: Commitment.confirmed,
    );

    final pendingEscrows = await _pendingEscrows();

    for (final detail in details) {
      final rawTx = detail.transaction as RawTransaction;
      final tx = SignedTx.fromBytes(rawTx.data);

      final accounts = tx.compiledMessage.accountKeys;

      final hasInteractedWithEscrow = accounts.contains(
        Ed25519HDPublicKey.fromBase58(
          'GHrMLBLnwGB8ypCWQnPeRzgHwePpUtSnY5ZSCCWzYmhC',
        ),
      );

      if (hasInteractedWithEscrow) {
        final escrow = accounts
            .getRange(1, 2)
            .where((e) => e != _userPublicKey)
            .firstOrNull;

        if (escrow != null) {
          if (pendingEscrows.contains(escrow.toBase58())) continue;

          final txList = await _client.rpcClient.getTransactionsList(
            escrow,
            limit: 2,
            commitment: Commitment.confirmed,
            encoding: Encoding.jsonParsed,
          );

          if (txList.length < 2) {
            final id = const Uuid().v4();

            final tx = txList.first;

            int amount = 0;

            for (final ix
                in tx.meta?.innerInstructions?.last.instructions ?? []) {
              if (ix is ParsedInstructionSplToken &&
                  ix.parsed is ParsedSplTokenTransferInstruction) {
                final parsed = ix.parsed as ParsedSplTokenTransferInstruction;

                amount = int.parse(parsed.info.amount);
              }
            }

            final timestamp = detail.blockTime?.let(
                  (it) => DateTime.fromMillisecondsSinceEpoch(it * 1000),
                ) ??
                DateTime.now();

            await _repository.save(
              OutgoingSplitKeyPayment(
                id: id,
                amount: CryptoAmount(
                  value: amount,
                  cryptoCurrency: const CryptoCurrency(token: Token.usdc),
                ),
                status: OSKPStatus.recovered(escrow: escrow),
                created: timestamp,
              ),
            );
          }
        }
      }
    }
  }

  Future<List<String>> _pendingEscrows() async {
    final pending = await _repository.watchPending().first;

    final List<String> results = [];

    for (final p in pending) {
      final escrowAddress = p.status.mapOrNull(
        txCreated: (it) async => it.escrow.keyPair.then((v) => v.address),
        txSent: (it) async => it.escrow.keyPair.then((v) => v.address),
        txConfirmed: (it) async => it.escrow.keyPair.then((v) => v.address),
        linksReady: (it) async => it.escrow.keyPair.then((v) => v.address),
        cancelTxCreated: (it) async => it.escrow.keyPair.then((v) => v.address),
        cancelTxFailure: (it) async => it.escrow.keyPair.then((v) => v.address),
        cancelTxSent: (it) async => it.escrow.keyPair.then((v) => v.address),
        recovered: (it) => it.escrow.toBase58(),
      );

      if (escrowAddress != null && escrowAddress is String) {
        results.add(escrowAddress);
      }
    }

    return results;
  }
}
