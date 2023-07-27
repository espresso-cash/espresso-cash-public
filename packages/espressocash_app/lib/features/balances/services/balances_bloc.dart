import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:solana/dto.dart';
import 'package:solana/solana.dart';

import '../../../core/amount.dart';
import '../../../core/currency.dart';
import '../../../core/disposable_bloc.dart';
import '../../../core/processing_state.dart';
import '../../../core/solana_helpers.dart';
import '../../../core/tokens/token.dart';
import '../../../core/tokens/token_list.dart';
import '../../authenticated/auth_scope.dart';
import '../data/balances_repository.dart';

final _logger = Logger('BalancesBloc');
typedef BalancesState = ProcessingState;

@Singleton(scope: authScope)
class BalancesBloc extends Bloc<BalancesEvent, BalancesState>
    with DisposableBloc {
  BalancesBloc(
    this._solanaClient,
    this._tokens,
    this._repository,
  ) : super(const ProcessingStateNone()) {
    on<BalancesEventRequested>(_handleRequested, transformer: droppable());
  }

  final SolanaClient _solanaClient;
  final TokenList _tokens;
  final BalancesRepository _repository;

  Future<void> _handleRequested(
    BalancesEventRequested event,
    Emitter<BalancesState> emit,
  ) async {
    final balances = <Token, CryptoAmount>{};

    try {
      emit(const ProcessingState.processing());
      balances[Token.sol] = await _solanaClient.getSolBalance(event.address);

      final allAccounts = await _solanaClient.getSplAccounts(event.address);

      final mainAccounts = await Future.wait<_MainTokenAccount?>(
        allAccounts.map((programAccount) async {
          final pubKey = programAccount.pubkey;
          final account = programAccount.account;
          final data = account.data;

          if (data is ParsedAccountData) {
            return data.maybeWhen<Future<_MainTokenAccount?>>(
              splToken: (parsed) => parsed.maybeMap<Future<_MainTokenAccount?>>(
                account: (a) =>
                    _MainTokenAccount.create(pubKey, a.info, _tokens),
                orElse: () async => null,
              ),
              orElse: () async => null,
            );
          }
        }),
      ).then(compact);

      final tokenBalances = mainAccounts.map(
        (a) => MapEntry(
          a.token,
          CryptoAmount(
            value: int.parse(a.info.tokenAmount.amount),
            cryptoCurrency: CryptoCurrency(token: a.token),
          ),
        ),
      );
      balances.addEntries(tokenBalances);

      if (isClosed) return;

      emit(const ProcessingState.none());
      _repository.saveAll(balances.lock);
    } on Exception catch (exception) {
      _logger.severe('Failed to fetch balances', exception);

      if (isClosed) return;

      emit(const ProcessingState.error(BalancesRequestException()));
      emit(const ProcessingState.none());
    }
  }
}

sealed class BalancesEvent {
  const BalancesEvent();
}

@immutable
final class BalancesEventRequested extends BalancesEvent {
  const BalancesEventRequested({required this.address});

  final String address;
}

class BalancesRequestException implements Exception {
  const BalancesRequestException();
}

class _MainTokenAccount {
  const _MainTokenAccount._(this.pubKey, this.info, this.token);

  static Future<_MainTokenAccount?> create(
    String pubKey,
    SplTokenAccountDataInfo info,
    TokenList tokens,
  ) async {
    final expectedPubKey = await findAssociatedTokenAddress(
      owner: Ed25519HDPublicKey.fromBase58(info.owner),
      mint: Ed25519HDPublicKey.fromBase58(info.mint),
    );

    if (expectedPubKey.toBase58() != pubKey) return null;

    final token = tokens.findTokenByMint(info.mint);

    // TODO(IA): we should find a way to display this
    return token == null ? null : _MainTokenAccount._(pubKey, info, token);
  }

  final Token token;
  final SplTokenAccountDataInfo info;
  final String pubKey;
}

extension SortedBalance on Map<Token, Amount> {
  Iterable<MapEntry<Token, Amount>> _splitAndSort(
    bool Function(MapEntry<Token, Amount> entry) test,
  ) =>
      entries.where(test).toList()
        ..sort((e1, e2) => e2.value.value.compareTo(e1.value.value));

  Map<Token, Amount> get sorted {
    final geckoEntries = _splitAndSort((e) => e.key.coingeckoId != null);
    final notGeckoEntries = _splitAndSort((e) => e.key.coingeckoId == null);

    return Map.fromEntries(geckoEntries)..addEntries(notGeckoEntries);
  }
}

extension on SolanaClient {
  Future<CryptoAmount> getSolBalance(String address) async {
    final lamports = await rpcClient
        .getBalance(
          address,
          commitment: Commitment.confirmed,
        )
        .value;

    return CryptoAmount(value: lamports, cryptoCurrency: Currency.sol);
  }
}
