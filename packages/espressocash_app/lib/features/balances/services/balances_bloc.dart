import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:solana/dto.dart';
import 'package:solana/solana.dart';

import '../../../utils/disposable_bloc.dart';
import '../../../utils/processing_state.dart';
import '../../accounts/auth_scope.dart';
import '../../analytics/analytics_manager.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../tokens/token.dart';
import '../../tokens/token_list.dart';
import '../data/cash_balance_repository.dart';
import '../data/token_balance_repository.dart';

part 'balances_bloc.freezed.dart';

final _logger = Logger('BalancesBloc');
typedef BalancesState = ProcessingState;

@Singleton(scope: authScope)
class BalancesBloc extends Bloc<BalancesEvent, BalancesState>
    with DisposableBloc {
  BalancesBloc(
    this._solanaClient,
    this._usdcRepository,
    this._tokens,
    this._tokensRepository,
    this._analyticsManager,
  ) : super(const ProcessingStateNone()) {
    on<BalancesEventRequested>(_handleRequested, transformer: droppable());
  }

  final SolanaClient _solanaClient;
  final TokenList _tokens;
  final CashBalanceRepository _usdcRepository;
  final TokenBalancesRepository _tokensRepository;
  final AnalyticsManager _analyticsManager;

  Future<void> _handleRequested(
    BalancesEventRequested event,
    Emitter<BalancesState> emit,
  ) async {
    try {
      emit(const ProcessingState.processing());

      final usdcBalance = await _solanaClient.getUsdcBalance(event.address);

      if (isClosed) return;

      emit(const ProcessingState.none());

      if (usdcBalance != null) {
        _usdcRepository.save(usdcBalance);
        _analyticsManager.setUsdcBalance(usdcBalance.decimal);
      }

      final balances = <Token, CryptoAmount>{};

      balances[Token.sol] = await _solanaClient.getSolBalance(event.address);

      final allAccounts = await _solanaClient.getSplAccounts(event.address);
      final mainAccounts = await Future.wait<_MainTokenAccount?>(
        allAccounts.map((programAccount) async {
          final account = programAccount.account;
          final data = account.data;

          if (data is ParsedAccountData) {
            return data.maybeWhen<Future<_MainTokenAccount?>>(
              splToken: (parsed) => parsed.maybeMap<Future<_MainTokenAccount?>>(
                account: (a) => _MainTokenAccount.create(
                  programAccount.pubkey,
                  a.info,
                  _tokens,
                ),
                orElse: () async => null,
              ),
              // Temporary fix until Token2022 is supported on Solana package
              unsupported: (val) async {
                final info = val['info'] as Map<String, dynamic>;

                final parsedInfo = SplTokenAccountDataInfo.fromJson(info);

                return _MainTokenAccount.createToken2022(
                  programAccount.pubkey,
                  parsedInfo,
                  _tokens,
                );
              },
              orElse: () async => null,
            );
          }
        }),
      ).then(compact);

      final tokenBalances = mainAccounts.map(
        (a) => CryptoAmount(
          value: int.parse(a.info.tokenAmount.amount),
          cryptoCurrency: CryptoCurrency(token: a.token),
        ),
      );
      await _tokensRepository.save(tokenBalances);
    } on Exception catch (exception) {
      _logger.severe('Failed to fetch balances', exception);

      if (isClosed) return;

      emit(const ProcessingState.error(BalancesRequestException()));
      emit(const ProcessingState.none());
    }
  }
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

  static Future<_MainTokenAccount?> createToken2022(
    String pubKey,
    SplTokenAccountDataInfo info,
    TokenList tokens,
  ) async {
    final token2022Program = Ed25519HDPublicKey.fromBase58(token2022ProgramId);

    final owner = Ed25519HDPublicKey.fromBase58(info.owner);
    final mint = Ed25519HDPublicKey.fromBase58(info.mint);

    final expectedPubKey = await Ed25519HDPublicKey.findProgramAddress(
      seeds: [owner.bytes, token2022Program.toByteArray(), mint.bytes],
      programId: AssociatedTokenAccountProgram.id,
    );

    if (expectedPubKey.toBase58() != pubKey) return null;

    final token = tokens.findTokenByMint(info.mint);

    return token == null ? null : _MainTokenAccount._(pubKey, info, token);
  }

  final Token token;
  final SplTokenAccountDataInfo info;
  final String pubKey;
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

  Future<CryptoAmount> getSolBalance(String address) async {
    final lamports = await rpcClient
        .getBalance(
          address,
          commitment: Commitment.confirmed,
        )
        .value;

    return CryptoAmount(value: lamports, cryptoCurrency: Currency.sol);
  }

  Future<Iterable<ProgramAccount>> getSplAccounts(String address) async {
    final accounts = [
      rpcClient.getTokenAccountsByOwner(
        address,
        const TokenAccountsFilter.byProgramId(TokenProgram.programId),
        commitment: Commitment.confirmed,
        encoding: Encoding.jsonParsed,
      ),
      rpcClient.getTokenAccountsByOwner(
        address,
        const TokenAccountsFilter.byProgramId(token2022ProgramId),
        commitment: Commitment.confirmed,
        encoding: Encoding.jsonParsed,
      ),
    ];

    final results = await Future.wait(accounts);

    return [...results[0].value, ...results[1].value];
  }
}

// Temporary fix until Token2022 is supported on Solana package
const token2022ProgramId = 'TokenzQdBNbLqP5VEhdkAS6EPFLC1PHnBqCXEpPxuEb';
