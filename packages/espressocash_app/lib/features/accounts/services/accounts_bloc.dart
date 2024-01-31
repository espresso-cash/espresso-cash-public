import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:solana_seed_vault/solana_seed_vault.dart';

import '../../analytics/analytics_manager.dart';
import '../data/account_repository.dart';
import '../models/account.dart';
import '../models/mnemonic.dart';

part 'accounts_bloc.freezed.dart';
part 'accounts_event.dart';
part 'accounts_state.dart';

@injectable
class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  AccountsBloc({
    required FlutterSecureStorage storage,
    required SeedVault seedVault,
    required AccountRepository repository,
    required AnalyticsManager analyticsManager,
    @factoryParam required AsyncCallback initAuthScope,
    @factoryParam required AsyncCallback dropAuthScope,
  })  : _storage = storage,
        _seedVault = seedVault,
        _repository = repository,
        _initAuthScope = initAuthScope,
        _dropAuthScope = dropAuthScope,
        _analyticsManager = analyticsManager,
        super(const AccountsState(isProcessing: true)) {
    on<AccountsEvent>(_eventHandler, transformer: sequential());
  }

  final FlutterSecureStorage _storage;
  final SeedVault _seedVault;
  final AccountRepository _repository;
  final AsyncCallback _initAuthScope;
  final AsyncCallback _dropAuthScope;
  final AnalyticsManager _analyticsManager;

  EventHandler<AccountsEvent, AccountsState> get _eventHandler =>
      (event, emit) => event.map(
            initialize: (_) => _onInitialize(emit),
            created: (event) => _onCreated(event, emit),
            loggedOut: (_) => _onLoggedOut(emit),
          );

  Future<void> _onInitialize(Emitter<AccountsState> emit) async {
    emit(state.copyWith(isProcessing: true));
    try {
      final account = await _repository.loadAccount();
      if (account != null) {
        await _processLogIn(account);
      }

      emit(state.copyWith(account: account, isProcessing: false));
    } on Exception {
      emit(state.copyWith(isProcessing: false));
    }
  }

  Future<void> _onCreated(Created event, Emitter<AccountsState> emit) async {
    emit(state.copyWith(isProcessing: true));

    await _repository.saveAccountSource(event.source);
    await _processLogIn(event.account);

    emit(state.copyWith(account: event.account, isProcessing: false));
  }

  Future<void> _onLoggedOut(Emitter<AccountsState> emit) async {
    if (state.account == null) return;

    _analyticsManager.setWalletAddress(null);
    Sentry.configureScope((scope) => scope.removeExtra('walletAddress'));

    try {
      final authToken = await _repository.loadAuthToken();
      if (authToken != null) {
        await _seedVault.deauthorizeSeed(authToken);
      }
    } finally {
      await _storage.deleteAll();
      await _dropAuthScope();
      emit(const AccountsState());
    }
  }

  Future<void> _processLogIn(MyAccount account) async {
    Sentry.configureScope(
      (scope) => scope.setExtra('walletAddress', account.address),
    );
    _analyticsManager.setWalletAddress(account.address);
    await _initAuthScope();
  }
}
