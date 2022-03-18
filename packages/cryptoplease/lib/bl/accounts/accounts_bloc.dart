import 'dart:io';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cryptoplease/bl/accounts/account.dart';
import 'package:cryptoplease/data/files.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart';

part 'accounts_bloc.freezed.dart';
part 'accounts_event.dart';
part 'accounts_state.dart';

typedef CopyFileToAppDir = Future<File> Function(File file);
typedef LoadFileFromAppDir = Future<File> Function(String path);

class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  AccountsBloc({
    required FlutterSecureStorage storage,
  })  : _storage = storage,
        super(const AccountsState(isProcessing: true)) {
    on<AccountsEvent>(_eventHandler, transformer: sequential());
  }

  final FlutterSecureStorage _storage;

  EventHandler<AccountsEvent, AccountsState> get _eventHandler =>
      (event, emit) => event.map(
            initialize: (_) => _onInitialize(emit),
            created: (event) => _onCreated(event, emit),
            profileUpdated: (event) => _onProfileUpdated(event, emit),
            loggedOut: (_) => _onLoggedOut(emit),
          );

  Future<void> _saveNameAndPhoto({required String name, String? photo}) async {
    await _storage.write(key: nameKey, value: name);
    if (photo != null) {
      await _storage.write(key: photoKey, value: basename(photo));
    }
  }

  Future<void> _onInitialize(Emitter<AccountsState> emit) async {
    emit(state.copyWith(isProcessing: true));
    try {
      final account = await loadAccount(_storage, loadFromAppDir);
      emit(state.copyWith(account: account, isProcessing: false));
    } on Exception {
      emit(state.copyWith(isProcessing: false));
    }
  }

  Future<void> _onCreated(Created event, Emitter<AccountsState> emit) async {
    emit(state.copyWith(isProcessing: true));
    await _storage.write(key: mnemonicKey, value: event.mnemonic);

    await _saveNameAndPhoto(
      name: event.account.firstName,
      photo: event.account.photoPath,
    );
    emit(state.copyWith(account: event.account, isProcessing: false));
  }

  Future<void> _onLoggedOut(Emitter<AccountsState> emit) async {
    await _storage.deleteAll();
    emit(const AccountsState());
  }

  Future<void> _onProfileUpdated(
    ProfileUpdated event,
    Emitter<AccountsState> emit,
  ) async {
    final photo = await event.photo?.let(copyToAppDir);
    emit(state.copyWith(isProcessing: true));

    await _saveNameAndPhoto(name: event.name, photo: photo?.path);
    emit(
      AccountsState(
        account: state.account?.copyWith(
          firstName: event.name,
          photoPath: photo?.path,
        ),
        isProcessing: false,
      ),
    );
  }
}
