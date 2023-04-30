import 'dart:io';

import 'package:bip39/bip39.dart' as bip39;
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:solana_seed_vault/solana_seed_vault.dart';

import '../../../../core/accounts/bl/account.dart';
import '../../../../core/accounts/bl/mnemonic.dart';
import '../../../../core/file_manager.dart';
import '../../../../core/flow.dart';
import '../../../../core/wallet.dart';

part 'sign_in_bloc.freezed.dart';

@injectable
class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc(this._fileManager, this._seedVault)
      // A value of type '_$FlowInitial<Exception, dynamic>' can't be assigned
      // to a parameter of type 'Flow<Exception, SignInResult>' in a const
      // constructor.
      //
      //ignore: prefer_const_constructors, some bug in analyzer
      : super(SignInState(processingState: Flow.initial())) {
    on<SignInEvent>(_eventHandler, transformer: sequential());
  }

  final FileManager _fileManager;
  final SeedVault _seedVault;

  EventHandler<SignInEvent, SignInState> get _eventHandler =>
      (event, emit) => event.map(
            submitted: (event) => _onSubmitted(event, emit),
            newLocalWalletRequested: (_) => _onNewLocalWalletRequested(emit),
            existingSagaWalletRequested: (_) =>
                _onExistingSagaWalletRequested(emit),
            existingLocalWalletRequested: (event) =>
                _onExistingLocalWalletRequested(event, emit),
          );

  Future<void> _onExistingSagaWalletRequested(Emitter<SignInState> emit) async {
    try {
      const purpose = Purpose.signSolanaTransaction;
      final token = await _seedVault.hasUnauthorizedSeedsForPurpose(purpose)
          ? await _seedVault.authorizeSeed(purpose)
          : await _seedVault.importSeed(purpose);

      emit(state.copyWith(source: AccountSource.saga(token)));
      add(const SignInSubmitted(name: 'My Wallet'));
    } on PlatformException {
      emit(state.toSeedVaultException());
    } on Exception catch (e) {
      emit(state.toGenericException(e));
    }
  }

  Future<void> _onNewLocalWalletRequested(Emitter<SignInState> emit) async {
    emit(
      state.copyWith(
        source: bip39
            .generateMnemonic()
            .let(Mnemonic.generated)
            .let(AccountSource.local),
      ),
    );
    add(const SignInSubmitted(name: 'My Wallet'));
  }

  Future<void> _onExistingLocalWalletRequested(
    SignInExistingLocalWalletRequested event,
    Emitter<SignInState> emit,
  ) async {
    emit(
      state.copyWith(
        source: event.phrase.let(Mnemonic.typed).let(AccountSource.local),
      ),
    );
  }

  Future<void> _onSubmitted(
    SignInSubmitted event,
    Emitter<SignInState> emit,
  ) async {
    emit(state.copyWith(processingState: const Flow.processing()));
    try {
      final wallet = await state.source.when(
        local: (it) => createLocalWallet(mnemonic: it.phrase),
        saga: (it) => createSagaWallet(_seedVault, it),
      );

      final accessMode = state.source.when(
        local: (it) => it.when(
          typed: always(const AccessMode.seedInputted()),
          generated: always(const AccessMode.created()),
          empty: () => throw StateError('Seed is empty during submission.'),
        ),
        saga: always(const AccessMode.created()),
      );

      final photo = await event.photo?.let(_fileManager.copyToAppDir);

      final myAccount = MyAccount(
        firstName: event.name,
        photoPath: photo?.path,
        wallet: wallet,
        accessMode: accessMode,
      );
      emit(
        state.copyWith(
          processingState: Flow.success(
            SignInResult(
              account: myAccount,
              hasFinishedOnboarding:
                  accessMode == const AccessMode.seedInputted(),
            ),
          ),
        ),
      );
    } on Exception catch (e) {
      emit(state.toGenericException(e));
    }

    emit(state.copyWith(processingState: const Flow.initial()));
  }
}

bool validateMnemonic(String mnemonic) => bip39.validateMnemonic(mnemonic);

@freezed
class SignInState with _$SignInState {
  const factory SignInState({
    @Default(AccountSource.local(Mnemonic.empty())) AccountSource source,
    required Flow<SignInException, SignInResult> processingState,
  }) = _SignInState;
}

@freezed
class SignInResult with _$SignInResult {
  const factory SignInResult({
    required MyAccount account,
    required bool hasFinishedOnboarding,
  }) = _SignInResult;
}

@freezed
class SignInEvent with _$SignInEvent {
  const factory SignInEvent.existingSagaWalletRequested() =
      SignInExistingSagaWalletRequested;

  const factory SignInEvent.newLocalWalletRequested() =
      SignInNewLocalWalletRequested;

  const factory SignInEvent.existingLocalWalletRequested(String phrase) =
      SignInExistingLocalWalletRequested;

  const factory SignInEvent.submitted({
    required String name,
    File? photo,
  }) = SignInSubmitted;
}

@freezed
class SignInException with _$SignInException implements Exception {
  const factory SignInException.seedVaultActionCanceled() = _ActionCanceled;
  const factory SignInException.generic(Exception e) = _Generic;
}

extension on SignInState {
  SignInState toGenericException(Exception e) => copyWith(
        processingState: Flow.failure(SignInException.generic(e)),
      );

  SignInState toSeedVaultException() => copyWith(
        processingState:
            const Flow.failure(SignInException.seedVaultActionCanceled()),
      );
}
