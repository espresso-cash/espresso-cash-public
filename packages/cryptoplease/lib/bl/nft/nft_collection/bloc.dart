import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cryptoplease/bl/accounts/account.dart';
import 'package:cryptoplease/bl/nft/nft_collection/load_nft_collection.dart';
import 'package:cryptoplease/bl/processing_state.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/solana.dart';

part 'bloc.freezed.dart';
part 'event.dart';
part 'state.dart';

typedef _Event = NftCollectionEvent;
typedef _State = NftCollectionState;
typedef _EventHandler = EventHandler<_Event, _State>;
typedef _Emitter = Emitter<_State>;

class NftCollectionBloc extends Bloc<_Event, _State> {
  NftCollectionBloc({
    required SolanaClient solanaClient,
    required MyAccount account,
  })  : _solanaClient = solanaClient,
        _account = account,
        super(const NftCollectionState()) {
    on<_Event>(_handler, transformer: sequential());
  }

  final SolanaClient _solanaClient;
  final MyAccount _account;

  _EventHandler get _handler => (event, emit) => event.map(
        updated: (updated) => _onUpdated(updated, emit),
      );

  Future<void> _onUpdated(NftCollectionEventUpdated _, _Emitter emit) async {
    emit(state.copyWith(processingState: const ProcessingState.processing()));

    await loadNftCollection(account: _account, client: _solanaClient).foldAsync(
      (e) {
        emit(state.copyWith(processingState: ProcessingState.error(e)));
        emit(state.copyWith(processingState: const ProcessingState.none()));
      },
      (c) => state
          .copyWith(
            processingState: const ProcessingState.none(),
            nftCollection: c,
          )
          .let(emit),
    );
  }
}
