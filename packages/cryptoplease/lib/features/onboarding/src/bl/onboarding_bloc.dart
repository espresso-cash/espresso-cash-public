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

part 'onboarding_bloc.freezed.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc(
    this._fileManager,
    this._accountsBloc,
  ) : super(const OnboardingState()) {
    on<OnboardingEvent>(_eventHander, transformer: sequential());
  }

  final FileManager _fileManager;
  final AccountsBloc _accountsBloc;

  EventHandler<OnboardingEvent, OnboardingState> get _eventHander =>
      (event, emit) => event.map(
            phraseRequested: (_) => _onPhraseRequested(emit),
            phraseUpdated: (event) => _onPhraseUpdated(event, emit),
            submitted: (event) => _onSubmitted(event, emit),
          );

  Future<void> _onPhraseRequested(Emitter<OnboardingState> emit) async {
    emit(state.copyWith(seed: Mnemonic.generated(bip39.generateMnemonic())));
  }

  Future<void> _onPhraseUpdated(
    OnboardingPhraseUpdated event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(state.copyWith(seed: Mnemonic.typed(event.phrase)));
  }

  Future<void> _onSubmitted(
    OnboardingSubmitted event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(state.copyWith(processingState: const ProcessingState.processing()));
    try {
      final wallet = await createWallet(mnemonic: state.phrase, account: 0);
      final photo = await event.photo?.let(_fileManager.copyToAppDir);

      final accessMode = state.seed.whenOrNull(
        typed: always(const AccessMode.seedInputted()),
        generated: always(const AccessMode.created()),
      );

      final myAccount = MyAccount(
        firstName: event.name,
        photoPath: photo?.path,
        wallet: wallet,
        // ignore: avoid-non-null-assertion, should not be null here
        accessMode: accessMode!,
      );
      _accountsBloc.add(
        AccountsEvent.created(account: myAccount, mnemonic: state.seed),
      );
    } on Exception catch (e) {
      emit(state.copyWith(processingState: ProcessingState.error(e)));
    }

    emit(state.copyWith(processingState: const ProcessingState.none()));
  }
}

bool validateMnemonic(String mnemonic) => bip39.validateMnemonic(mnemonic);

@freezed
class OnboardingState with _$OnboardingState {
  const factory OnboardingState({
    @Default(Mnemonic.empty()) Mnemonic seed,
    @Default(ProcessingStateNone<Exception>())
        ProcessingState<Exception> processingState,
  }) = _OnboardingState;
}

extension OnboardingStateExt on OnboardingState {
  String get phrase => seed.phrase;
}

@freezed
class OnboardingEvent with _$OnboardingEvent {
  const factory OnboardingEvent.phraseRequested() = OnboardingPhraseRequested;

  const factory OnboardingEvent.phraseUpdated(String phrase) =
      OnboardingPhraseUpdated;

  const factory OnboardingEvent.submitted({
    required String name,
    File? photo,
  }) = OnboardingSubmitted;
}
