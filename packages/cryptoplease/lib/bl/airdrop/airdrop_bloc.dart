import 'package:cryptoplease/bl/accounts/account.dart';
import 'package:cryptoplease/bl/balances/balances_bloc.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana.dart';

part 'airdrop_bloc.freezed.dart';

class AirdropBloc extends Bloc<AirdropEvent, AirdropState> {
  AirdropBloc({
    required SolanaClient solanaClient,
    required BalancesBloc balancesBloc,
    required MyAccount account,
  })  : _solanaClient = solanaClient,
        _balancesBloc = balancesBloc,
        _account = account,
        super(const AirdropState.none()) {
    on<AirdropEvent>(_eventHandler);
  }

  final SolanaClient _solanaClient;
  final BalancesBloc _balancesBloc;
  final MyAccount _account;

  EventHandler<AirdropEvent, AirdropState> get _eventHandler =>
      (event, emit) => event.map(
            requested: (_) => _onRequest(emit),
          );

  Future<void> _onRequest(
    Emitter<AirdropState> emit,
  ) async {
    if (state is! AirdropStateNone) return;

    emit(const AirdropState.requesting());

    await tryEitherAsync((_) async {
      await _solanaClient.requestAirdrop(
        address: _account.publicKey,
        lamports: lamportsPerSol,
      );
      // ignore: avoid_print, used in debug only anyway
    }).doOnLeftAsync(print);

    emit(const AirdropState.none());
    _balancesBloc.add(BalancesEvent.requested(address: _account.address));
  }
}

@freezed
class AirdropEvent with _$AirdropEvent {
  const factory AirdropEvent.requested() = AirdropRequested;
}

@freezed
class AirdropState with _$AirdropState {
  const factory AirdropState.none() = AirdropStateNone;

  const factory AirdropState.requesting() = AirdropStateRequesting;
}
