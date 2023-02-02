import 'dart:io';

import 'package:bip39/bip39.dart' as bip39;
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/accounts/bl/account.dart';
import '../../../../core/accounts/bl/accounts_bloc.dart';
import '../../../../core/accounts/bl/mnemonic.dart';
import '../../../../core/file_manager.dart';
import '../../../../core/processing_state.dart';
import '../../../../core/wallet.dart';

part 'sign_in_bloc.freezed.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc(
    this._fileManager,
    this._accountsBloc,
  ) : super(const SignInState()) {
    on<SignInEvent>(_eventHandler, transformer: sequential());
  }

  final FileManager _fileManager;
  final AccountsBloc _accountsBloc;

  EventHandler<SignInEvent, SignInState> get _eventHandler =>
      (event, emit) => event.map(
            phraseRequested: (_) => _onPhraseRequested(emit),
            phraseUpdated: (event) => _onPhraseUpdated(event, emit),
            submitted: (event) => _onSubmitted(event, emit),
          );

  Future<void> _onPhraseRequested(Emitter<SignInState> emit) async {
    emit(state.copyWith(seed: Mnemonic.generated(bip39.generateMnemonic())));
    add(const SignInSubmitted(name: 'My Wallet'));
  }

  Future<void> _onPhraseUpdated(
    SignInPhraseUpdated event,
    Emitter<SignInState> emit,
  ) async {
    emit(state.copyWith(seed: Mnemonic.typed(event.phrase)));
  }

  Future<void> _onSubmitted(
    SignInSubmitted event,
    Emitter<SignInState> emit,
  ) async {
    emit(state.copyWith(processingState: const ProcessingState.processing()));
    try {
      final wallet = await createWallet(mnemonic: state.phrase, account: 0);
      final photo = await event.photo?.let(_fileManager.copyToAppDir);

      final accessMode = state.seed.when(
        typed: always(const AccessMode.seedInputted()),
        generated: always(const AccessMode.created()),
        empty: () => throw StateError('Seed is empty during submission.'),
      );

      final myAccount = MyAccount(
        firstName: event.name,
        photoPath: photo?.path,
        wallet: wallet,
        accessMode: accessMode,
      );
      _accountsBloc.add(
        AccountsEvent.created(
          account: myAccount,
          mnemonic: state.seed,
          hasFinishedOnboarding: accessMode == const AccessMode.seedInputted(),
        ),
      );
    } on Exception catch (e) {
      emit(state.copyWith(processingState: ProcessingState.error(e)));
    }

    emit(state.copyWith(processingState: const ProcessingState.none()));
  }
}

bool validateMnemonic(String mnemonic) => bip39.validateMnemonic(mnemonic);

@freezed
class SignInState with _$SignInState {
  const factory SignInState({
    @Default(Mnemonic.empty()) Mnemonic seed,
    @Default(ProcessingStateNone<Exception>())
        ProcessingState<Exception> processingState,
  }) = _SignInState;
}

extension SignInStateExt on SignInState {
  String get phrase => seed.phrase;
}

@freezed
class SignInEvent with _$SignInEvent {
  const factory SignInEvent.phraseRequested() = SignInPhraseRequested;

  const factory SignInEvent.phraseUpdated(String phrase) = SignInPhraseUpdated;

  const factory SignInEvent.submitted({
    required String name,
    File? photo,
  }) = SignInSubmitted;
}
