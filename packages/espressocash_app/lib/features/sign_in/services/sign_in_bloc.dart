import 'package:bip39/bip39.dart' as bip39;
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../utils/flow.dart';
import '../../accounts/models/account.dart';
import '../../accounts/models/mnemonic.dart';
import '../../accounts/models/wallet.dart';

part 'sign_in_bloc.freezed.dart';

@injectable
class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc()
      // A value of type '_$FlowInitial<Exception, dynamic>' can't be assigned
      // to a parameter of type 'Flow<Exception, SignInResult>' in a const
      // constructor.
      //
      //ignore: prefer_const_constructors, some bug in analyzer
      : super(SignInState(processingState: Flow.initial())) {
    on<SignInEvent>(_eventHandler, transformer: sequential());
  }

  EventHandler<SignInEvent, SignInState> get _eventHandler =>
      (event, emit) => event.map(
            submitted: (event) => _onSubmitted(event, emit),
            newLocalWalletRequested: (_) => _onNewLocalWalletRequested(emit),
            existingLocalWalletRequested: (event) =>
                _onExistingLocalWalletRequested(event, emit),
          );

  void _onNewLocalWalletRequested(Emitter<SignInState> emit) {
    emit(
      state.copyWith(
        source: bip39
            .generateMnemonic()
            .let(Mnemonic.generated)
            .let(AccountSource.local),
      ),
    );
    add(const SignInSubmitted());
  }

  void _onExistingLocalWalletRequested(
    SignInExistingLocalWalletRequested event,
    Emitter<SignInState> emit,
  ) {
    emit(
      state.copyWith(
        source: event.phrase.let(Mnemonic.typed).let(AccountSource.local),
      ),
    );
  }

  Future<void> _onSubmitted(
    SignInSubmitted _,
    Emitter<SignInState> emit,
  ) async {
    emit(state.copyWith(processingState: const Flow.processing()));
    try {
      final wallet = await state.source.when(
        local: (it) => createLocalWallet(mnemonic: it.phrase),
      );

      final accessMode = state.source.when(
        local: (it) => it.when(
          typed: always(const AccessMode.seedInputted()),
          generated: always(const AccessMode.created()),
          empty: () => throw StateError('Seed is empty during submission.'),
        ),
      );

      final myAccount = MyAccount(wallet: wallet, accessMode: accessMode);
      emit(state.copyWith(processingState: Flow.success(myAccount)));
    } on Exception catch (error) {
      emit(state.toGenericException(error));
    }

    emit(state.copyWith(processingState: const Flow.initial()));
  }
}

@freezed
class SignInState with _$SignInState {
  const factory SignInState({
    @Default(AccountSource.local(Mnemonic.empty())) AccountSource source,
    required Flow<SignInException, MyAccount> processingState,
  }) = _SignInState;
}

@freezed
class SignInEvent with _$SignInEvent {
  const factory SignInEvent.newLocalWalletRequested() =
      SignInNewLocalWalletRequested;

  const factory SignInEvent.existingLocalWalletRequested(String phrase) =
      SignInExistingLocalWalletRequested;

  const factory SignInEvent.submitted() = SignInSubmitted;
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
}
