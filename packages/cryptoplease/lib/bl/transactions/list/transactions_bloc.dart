import 'package:cryptoplease/bl/accounts/account.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/dto.dart';
import 'package:solana/solana.dart';

part 'transactions_bloc.freezed.dart';
part 'transactions_event.dart';
part 'transactions_state.dart';

typedef TxTransformer = Transaction? Function(TransactionDetails);

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  TransactionsBloc({
    required SolanaClient solanaClient,
    required MyAccount account,
    required Token token,
  })  : _solanaClient = solanaClient,
        _account = account,
        _token = token,
        super(const TransactionsState()) {
    on<TransactionsEvent>(_eventHandler);
  }

  final SolanaClient _solanaClient;
  final MyAccount _account;
  final Token _token;

  EventHandler<TransactionsEvent, TransactionsState> get _eventHandler =>
      (event, emit) => event.map(
            loadRequested: (_) => _onLoadRequested(emit),
          );

  Future<Ed25519HDPublicKey> _getAddressForCurrentToken() async =>
      _token == Token.sol
          ? _account.publicKey
          : await findAssociatedTokenAddress(
              owner: _account.publicKey,
              mint: Ed25519HDPublicKey.fromBase58(_token.address),
            );

  Future<Iterable<Transaction>> _loadTransactions(
    TxTransformer transform,
  ) async {
    final address = await _getAddressForCurrentToken();

    final transactions = await _solanaClient.rpcClient.getTransactionsList(
      address,
      limit: 50,
      commitment: Commitment.confirmed,
    );

    return transactions.map(transform).compact();
  }

  Future<void> _onLoadRequested(Emitter<TransactionsState> emit) async {
    if (state.loadingState is InProgress) return;

    emit(state.copyWith(loadingState: const LoadingState.inProgress()));
    final Iterable<Transaction> loadedTransactions;

    try {
      if (_token == Token.sol) {
        loadedTransactions = await _loadTransactions(_solTxTransformer);
      } else {
        loadedTransactions = await _loadTransactions(_splTxTransformer);
      }

      final sortedTransactions = loadedTransactions.sorted((t1, t2) {
        final blockTime1 = t1.blockTime;
        final blockTime2 = t2.blockTime;
        if (blockTime1 == null && blockTime2 == null) {
          return 0;
        } else if (blockTime1 != null && blockTime2 != null) {
          return blockTime2.millisecondsSinceEpoch -
              blockTime1.millisecondsSinceEpoch;
        } else {
          return blockTime1 == null ? -1 : 1;
        }
      }).toIList();

      emit(
        state.copyWith(
          loadingState: const LoadingState.success(),
          transactions: sortedTransactions,
        ),
      );

      emit(state.copyWith(loadingState: const LoadingState.none()));
    } on Exception catch (e) {
      emit(state.copyWith(loadingState: LoadingState.loadingError(e)));
      emit(state.copyWith(loadingState: const LoadingState.none()));
    }
  }
}

Transaction _solTxTransformer(TransactionDetails response) {
  final transaction = response.transaction;
  final instruction = transaction.message.instructions
      .whereType<ParsedInstructionSystem>()
      .firstWhereOrNull(
        (ParsedInstructionSystem tx) => tx.parsed.maybeMap(
          transfer: (_) => true,
          transferChecked: (_) => true,
          orElse: () => false,
        ),
      );

  if (instruction == null) return _fallbackTransformer(response);

  final memo = transaction.message.instructions
      .whereType<ParsedInstructionMemo>()
      .firstOrNull;

  return instruction.parsed.maybeMap(
    transfer: (transfer) => Transaction.fromSystemTransfer(
      instruction: transfer,
      blockTime: _blockTimeToDateTime(response.blockTime),
      hash: transaction.signatures.first,
      meta: response.meta,
      memo: memo?.memo,
    ),
    transferChecked: (transfer) => Transaction.fromSystemTransferChecked(
      instruction: transfer,
      blockTime: _blockTimeToDateTime(response.blockTime),
      hash: transaction.signatures.first,
      meta: response.meta,
      memo: memo?.memo,
    ),
    orElse: () => _fallbackTransformer(response),
  );
}

Transaction _splTxTransformer(TransactionDetails response) {
  final transaction = response.transaction;
  final instruction = transaction.message.instructions
      .whereType<ParsedInstructionSplToken>()
      .firstWhereOrNull(
        (ParsedInstructionSplToken tx) => tx.parsed.maybeMap(
          transfer: (_) => true,
          transferChecked: (_) => true,
          orElse: () => false,
        ),
      );

  if (instruction == null) return _fallbackTransformer(response);

  final memo = transaction.message.instructions
      .whereType<ParsedInstructionMemo>()
      .firstOrNull;

  return instruction.parsed.maybeMap(
    transfer: (transfer) => Transaction.fromSplTokenTransfer(
      instruction: transfer,
      blockTime: _blockTimeToDateTime(response.blockTime),
      hash: transaction.signatures.first,
      meta: response.meta,
      memo: memo?.memo,
    ),
    transferChecked: (transfer) => Transaction.fromSplTokenTransferChecked(
      instruction: transfer,
      blockTime: _blockTimeToDateTime(response.blockTime),
      hash: transaction.signatures.first,
      meta: response.meta,
      memo: memo?.memo,
    ),
    orElse: () => _fallbackTransformer(response),
  );
}

Transaction _fallbackTransformer(TransactionDetails response) =>
    Transaction.generic(
      meta: response.meta,
      blockTime: _blockTimeToDateTime(response.blockTime),
      hash: response.transaction.signatures.first,
    );

DateTime? _blockTimeToDateTime(int? blockTime) {
  if (blockTime == null) return null;

  return DateTime.fromMillisecondsSinceEpoch(1000 * blockTime);
}
