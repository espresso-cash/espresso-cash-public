import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:espressocash_common/espressocash_common.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:solana/dto.dart';
import 'package:solana/solana.dart';

import '../../../utils/disposable_bloc.dart';
import '../../../utils/processing_state.dart';
import '../../authenticated/auth_scope.dart';
import '../data/balances_repository.dart';

part 'balances_bloc.freezed.dart';

final _logger = Logger('BalancesBloc');
typedef BalancesState = ProcessingState;

@Singleton(scope: authScope)
class BalancesBloc extends Bloc<BalancesEvent, BalancesState>
    with DisposableBloc {
  BalancesBloc(
    this._solanaClient,
    this._repository,
  ) : super(const ProcessingStateNone()) {
    on<BalancesEventRequested>(_handleRequested, transformer: droppable());
  }

  final SolanaClient _solanaClient;
  final BalancesRepository _repository;

  Future<void> _handleRequested(
    BalancesEventRequested event,
    Emitter<BalancesState> emit,
  ) async {
    try {
      emit(const ProcessingState.processing());

      final usdcBalance = await _solanaClient.getUsdcBalance(event.address);

      if (isClosed) return;

      emit(const ProcessingState.none());

      if (usdcBalance == null) {
        return;
      }

      _repository.save(usdcBalance);
    } on Exception catch (exception) {
      _logger.severe('Failed to fetch balances', exception);

      if (isClosed) return;

      emit(const ProcessingState.error(BalancesRequestException()));
      emit(const ProcessingState.none());
    }
  }
}

class BalancesRequestException implements Exception {
  const BalancesRequestException();
}

@freezed
sealed class BalancesEvent with _$BalancesEvent {
  const factory BalancesEvent.refreshRequested({
    required String address,
  }) = BalancesEventRequested;
}

extension on SolanaClient {
  Future<CryptoAmount?> getUsdcBalance(String address) async {
    try {
      final usdcTokenAccount = await findAssociatedTokenAddress(
        owner: Ed25519HDPublicKey.fromBase58(address),
        mint: Ed25519HDPublicKey.fromBase58(Token.usdc.address),
      );

      final balance = await rpcClient
          .getTokenAccountBalance(
            usdcTokenAccount.toBase58(),
            commitment: Commitment.confirmed,
          )
          .value;

      return CryptoAmount(
        value: int.parse(balance.amount),
        cryptoCurrency: Currency.usdc,
      );
    } on Exception {
      return null;
    }
  }
}
