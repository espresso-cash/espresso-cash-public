import 'dart:async';

import 'package:collection/collection.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/dto.dart';
import 'package:solana/solana.dart';
import 'package:uuid/uuid.dart';

import '../../../../config.dart';
import '../../../../core/amount.dart';
import '../../../../core/currency.dart';
import '../../../../core/escrow_private_key.dart';
import '../../accounts/models/account.dart';
import '../../activities/data/transaction_repository.dart';
import '../../activities/models/transaction.dart';
import '../../tokens/token.dart';
import '../data/repository.dart';
import '../models/outgoing_link_payment.dart';

@injectable
class RecoverPendingWatcher implements Disposable {
  RecoverPendingWatcher(
    this._client,
    this._repository,
    this._transactionRepository, {
    @factoryParam required MyAccount account,
  }) : _account = account;

  final SolanaClient _client;
  final TransactionRepository _transactionRepository;
  final OLPRepository _repository;
  final MyAccount _account;

  StreamSubscription<void>? _subscription;

  Ed25519HDPublicKey get _userPublicKey => _account.wallet.publicKey;

  void init() {
    if (_account.accessMode != const AccessMode.seedInputted()) return;

    _subscription = _transactionRepository
        .watchAllActivity()
        .where((event) => event.isNotEmpty)
        .listen(_recoverListener);
  }

  Future<void> _recoverListener(IList<TxCommon> transactions) async {
    final pendingEscrows = await _pendingEscrows();

    for (final detail in transactions) {
      final tx = detail.tx;

      // Check if the transaction has interacted with the escrow smart contract
      final accounts = tx.compiledMessage.accountKeys;
      final hasInteractedWithEscrow = accounts.contains(
        Ed25519HDPublicKey.fromBase58(escrowScAddress),
      );

      if (!hasInteractedWithEscrow) continue;

      // Find the escrow address from accounts. It should either be in index 1 or 2.
      // Index 0 is the platforms account, index 1 or 2 should either be the user or the escrow.
      final escrow =
          accounts.getRange(1, 2).where((e) => e != _userPublicKey).firstOrNull;

      if (escrow == null) continue;

      if (pendingEscrows.contains(escrow)) continue;

      final txList = await _client.rpcClient.getTransactionsList(
        escrow,
        limit: 2,
        commitment: Commitment.confirmed,
        encoding: Encoding.jsonParsed,
      );

      if (txList.length < 2) {
        final tx = txList.first;

        int amount = 0;

        for (final ix in tx.meta?.innerInstructions?.last.instructions ?? []) {
          if (ix is ParsedInstructionSplToken &&
              ix.parsed is ParsedSplTokenTransferInstruction) {
            final parsed = ix.parsed as ParsedSplTokenTransferInstruction;

            amount = int.parse(parsed.info.amount);
          }
        }

        final timestamp = detail.created ?? DateTime.now();

        final id = const Uuid().v4();

        await _repository.save(
          OutgoingLinkPayment(
            id: id,
            amount: CryptoAmount(
              value: amount,
              cryptoCurrency: const CryptoCurrency(token: Token.usdc),
            ),
            status: OLPStatus.recovered(escrowPubKey: escrow),
            created: timestamp,
            linksGeneratedAt: timestamp,
            escrow: null,
          ),
        );

        await _subscription?.cancel();
      }
    }
  }

  Future<List<EscrowPublicKey>> _pendingEscrows() async {
    final pending = await _repository.watchPending().first;

    final List<EscrowPublicKey> results = [];

    for (final p in pending) {
      final escrow = await p.status.maybeMap(
        recovered: (it) async => it.escrowPubKey,
        orElse: () => p.escrow?.keyPair.then((v) => v.publicKey),
      );

      if (escrow != null) {
        results.add(escrow);
      }
    }

    return results;
  }

  @override
  void onDispose() => _subscription?.cancel();
}
