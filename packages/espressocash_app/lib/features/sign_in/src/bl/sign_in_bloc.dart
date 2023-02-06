import 'dart:io';

import 'package:bip39/bip39.dart' as bip39;
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/accounts/bl/account.dart';
import '../../../../core/accounts/bl/mnemonic.dart';
import '../../../../core/file_manager.dart';
import '../../../../core/flow.dart';
import '../../../../core/wallet.dart';

part 'sign_in_bloc.freezed.dart';

@injectable
class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc(this._fileManager)
      // A value of type '_$FlowInitial<Exception, dynamic>' can't be assigned
      // to a parameter of type 'Flow<Exception, SignInResult>' in a const
      // constructor.
      //
      //ignore: prefer_const_constructors, some bug in analyzer
      : super(SignInState(processingState: Flow.initial())) {
    on<SignInEvent>(_eventHandler, transformer: sequential());
  }

  final FileManager _fileManager;

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
    emit(state.copyWith(processingState: const Flow.processing()));
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
      emit(state.copyWith(processingState: Flow.failure(e)));
    }

    emit(state.copyWith(processingState: const Flow.initial()));
  }
}

bool validateMnemonic(String mnemonic) => bip39.validateMnemonic(mnemonic);

@freezed
class SignInState with _$SignInState {
  const factory SignInState({
    @Default(Mnemonic.empty()) Mnemonic seed,
    required Flow<Exception, SignInResult> processingState,
  }) = _SignInState;
}

@freezed
class SignInResult with _$SignInResult {
  const factory SignInResult({
    required MyAccount account,
    required bool hasFinishedOnboarding,
  }) = _SignInResult;
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
