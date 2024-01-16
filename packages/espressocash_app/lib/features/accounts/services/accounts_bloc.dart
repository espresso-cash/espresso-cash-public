import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:solana_seed_vault/solana_seed_vault.dart';

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
    @factoryParam required AsyncCallback initAuthScope,
    @factoryParam required AsyncCallback dropAuthScope,
  })  : _storage = storage,
        _seedVault = seedVault,
        _repository = repository,
        _initAuthScope = initAuthScope,
        _dropAuthScope = dropAuthScope,
        super(const AccountsState(isProcessing: true)) {
    on<AccountsEvent>(_eventHandler, transformer: sequential());
  }

  final FlutterSecureStorage _storage;
  final SeedVault _seedVault;
  final AccountRepository _repository;
  final AsyncCallback _initAuthScope;
  final AsyncCallback _dropAuthScope;

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
        await _initAuthScope();
      }

      emit(state.copyWith(account: account, isProcessing: false));
    } on Exception {
      emit(state.copyWith(isProcessing: false));
    }
  }

  Future<void> _onCreated(Created event, Emitter<AccountsState> emit) async {
    emit(state.copyWith(isProcessing: true));

    await _repository.saveAccountSource(event.source);
    await _initAuthScope();

    emit(state.copyWith(account: event.account, isProcessing: false));
  }

  Future<void> _onLoggedOut(Emitter<AccountsState> emit) async {
    if (state.account == null) return;

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
}
