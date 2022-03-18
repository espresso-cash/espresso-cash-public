import 'dart:io';

import 'package:bip39/bip39.dart' as bip39;
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cryptoplease/bl/accounts/account.dart';
import 'package:cryptoplease/bl/accounts/accounts_bloc.dart';
import 'package:cryptoplease/bl/processing_state.dart';
import 'package:cryptoplease/bl/wallet/wallet.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_bloc.freezed.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc(
    this._copyFile,
    this._accountsBloc,
  ) : super(const SignUpState()) {
    on<SignUpEvent>(_eventHander, transformer: sequential());
  }

  final CopyFileToAppDir _copyFile;
  final AccountsBloc _accountsBloc;

  EventHandler<SignUpEvent, SignUpState> get _eventHander =>
      (event, emit) => event.map(
            phraseRequested: (_) => _onPhraseRequested(emit),
            phraseUpdated: (event) => _onPhraseUpdated(event, emit),
            submitted: (event) => _onSubmitted(event, emit),
          );

  Future<void> _onPhraseRequested(Emitter<SignUpState> emit) async {
    emit(state.copyWith(phrase: bip39.generateMnemonic()));
  }

  Future<void> _onPhraseUpdated(
    SignUpPhraseUpdated event,
    Emitter<SignUpState> emit,
  ) async {
    emit(state.copyWith(phrase: event.phrase));
  }

  Future<void> _onSubmitted(
    SignUpSubmitted event,
    Emitter<SignUpState> emit,
  ) async {
    emit(state.copyWith(processingState: const ProcessingState.processing()));
    try {
      final wallet = await createWallet(mnemonic: state.phrase, account: 0);
      final photo = await event.photo?.let(_copyFile);
      final myAccount = MyAccount(
        firstName: event.name,
        photoPath: photo?.path,
        wallet: wallet,
      );
      _accountsBloc.add(
        AccountsEvent.created(account: myAccount, mnemonic: state.phrase),
      );
    } on Exception catch (e) {
      emit(state.copyWith(processingState: ProcessingState.error(e)));
    }

    emit(state.copyWith(processingState: const ProcessingState.none()));
  }
}

bool validateMnemonic(String mnemonic) => bip39.validateMnemonic(mnemonic);

@freezed
class SignUpState with _$SignUpState {
  const factory SignUpState({
    @Default('') String phrase,
    @Default(ProcessingStateNone<Exception>())
        ProcessingState<Exception> processingState,
  }) = _SignUpState;
}

@freezed
class SignUpEvent with _$SignUpEvent {
  const factory SignUpEvent.phraseRequested() = SignUpPhraseRequested;

  const factory SignUpEvent.phraseUpdated(String phrase) = SignUpPhraseUpdated;

  const factory SignUpEvent.submitted({
    required String name,
    File? photo,
  }) = SignUpSubmitted;
}
