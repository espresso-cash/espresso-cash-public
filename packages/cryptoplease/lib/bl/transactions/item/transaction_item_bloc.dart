import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cryptoplease/bl/accounts/account.dart';
import 'package:cryptoplease/bl/tokens/token.dart' hide SplToken;
import 'package:cryptoplease/bl/transactions/list/transactions_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana.dart'
    show Ed25519HDPublicKey, findAssociatedTokenAddress;

part 'transaction_item_bloc.freezed.dart';
part 'transaction_item_event.dart';
part 'transaction_item_state.dart';

typedef _Event = TransactionItemEvent;
typedef _State = TransactionItemState;
typedef _EventHandler = EventHandler<_Event, _State>;
typedef _Emitter = Emitter<_State>;

class TransactionItemBloc extends Bloc<_Event, _State> {
  TransactionItemBloc({
    required MyAccount account,
  })  : _account = account,
        super(const TransactionItemState()) {
    on<TransactionItemEvent>(_handler, transformer: sequential());
  }

  final MyAccount _account;

  _EventHandler get _handler => (e, emit) => e.map(
        initialized: (e) => _onInitialized(e, emit),
      );

  Future<void> _onInitialized(
    TransactionItemInitializedEvent event,
    _Emitter emit,
  ) async {
    final transaction = event.transaction;
    final token = event.token;
    final address = await _getWalletAddress(token);
    final transactionType =
        _getTransactionType(address.toBase58(), transaction);
    final transactionStatus = _getTransactionStatus(transaction);

    transaction.map(
      transfer: (t) {
        final int sign;

        switch (transactionType) {
          case TransactionType.incoming:
            sign = 1;
            break;
          case TransactionType.outgoing:
            sign = -1;
            break;
          case TransactionType.unknown:
            sign = 0;
            break;
        }

        emit(
          state.copyWith(
            transactionType: transactionType,
            transactionStatus: transactionStatus,
            signedAmount: sign * t.amount,
          ),
        );
      },
      generic: (g) {
        emit(
          state.copyWith(
            transactionType: transactionType,
            transactionStatus: transactionStatus,
          ),
        );
      },
    );
  }

  TransactionItemStatus _getTransactionStatus(Transaction transaction) =>
      transaction.meta?.err == null
          ? TransactionItemStatus.succeeded
          : TransactionItemStatus.failed;

  TransactionType _getTransactionType(
    String address,
    Transaction transaction,
  ) =>
      transaction.map(
        transfer: (t) => address == t.senderAddress
            ? TransactionType.outgoing
            : TransactionType.incoming,
        generic: (g) => TransactionType.unknown,
      );

  Future<Ed25519HDPublicKey> _getWalletAddress(Token token) async =>
      token.isSolana
          ? _account.publicKey
          : await findAssociatedTokenAddress(
              owner: _account.publicKey,
              mint: Ed25519HDPublicKey.fromBase58(token.address),
            );
}
