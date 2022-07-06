import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana.dart';

part 'airdrop_bloc.freezed.dart';

class AirdropBloc extends Bloc<AirdropEvent, AirdropState> {
  AirdropBloc({
    required SolanaClient solanaClient,
    required VoidCallback onAirdropCompleted,
    required Ed25519HDPublicKey account,
  })  : _solanaClient = solanaClient,
        _onAirdropCompleted = onAirdropCompleted,
        _account = account,
        super(const AirdropState.none()) {
    on<AirdropEvent>(_eventHandler);
  }

  final SolanaClient _solanaClient;
  final VoidCallback _onAirdropCompleted;
  final Ed25519HDPublicKey _account;

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
        address: _account,
        lamports: lamportsPerSol,
      );
      // ignore: avoid_print, used in debug only anyway
    }).doOnLeftAsync(print);

    emit(const AirdropState.none());
    _onAirdropCompleted();
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
