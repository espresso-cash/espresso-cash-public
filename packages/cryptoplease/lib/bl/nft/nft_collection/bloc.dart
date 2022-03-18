import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cryptoplease/bl/accounts/account.dart';
import 'package:cryptoplease/bl/nft/nft_collection/utils.dart';
import 'package:cryptoplease/bl/processing_state.dart';
import 'package:cryptoplease/bl/solana_helpers.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/dto.dart';
import 'package:solana/metaplex.dart';
import 'package:solana/solana.dart';

part 'bloc.freezed.dart';
part 'event.dart';
part 'state.dart';

class NftCollectionBloc extends Bloc<NftCollectionEvent, NftCollectionState> {
  NftCollectionBloc({
    required SolanaClient solanaClient,
    required MyAccount account,
  })  : _solanaClient = solanaClient,
        _account = account,
        super(const NftCollectionState()) {
    on<NftCollectionEvent>(_handler, transformer: sequential());
  }

  final SolanaClient _solanaClient;
  final MyAccount _account;

  EventHandler<NftCollectionEvent, NftCollectionState> get _handler =>
      (event, emit) => event.map(
            updated: (updated) => _onUpdated(updated, emit),
          );

  Future<IList<NonFungibleToken>> _loadNfts(MyAccount account) async {
    final wallet = account.wallet;

    final accounts = await _solanaClient.getSplAccounts(wallet.address);
    final nftCollection = await _extractNftsFromAccounts(accounts);

    return nftCollection.toIList().sort((m1, m2) => m1.name.compareTo(m2.name));
  }

  Future<void> _onUpdated(
    NftCollectionEventUpdated _,
    Emitter<NftCollectionState> emit,
  ) async {
    emit(
      state.copyWith(processingState: const ProcessingState.processing()),
    );
    try {
      final collection = await _loadNfts(_account);

      emit(
        state.copyWith(
          processingState: const ProcessingState.none(),
          nftCollection: collection,
        ),
      );
    } on Exception catch (e) {
      emit(state.copyWith(processingState: ProcessingState.error(e)));
      emit(state.copyWith(processingState: const ProcessingState.none()));
    }
  }

  Future<Iterable<NonFungibleToken>> _extractNftsFromAccounts(
    Iterable<ProgramAccount> accounts,
  ) async {
    final nftMints =
        accounts.map((d) => d.toNftAccountDataOrNull()).whereNotNull();

    final unfiltered = await Future.wait(
      nftMints.map((info) async {
        final metadata =
            await _solanaClient.rpcClient.getMetadata(mint: info.mint);

        return metadata == null
            ? null
            : NonFungibleToken(address: info.mint, metadata: metadata);
      }),
    );

    return unfiltered.whereNotNull();
  }
}
