import 'dart:io';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/accounts/bl/accounts_bloc.dart';
import '../../../../core/file_manager.dart';
import '../../../../core/flow.dart';

part 'onboarding_bloc.freezed.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc(
    this._fileManager,
    this._accountsBloc,
  ) : super(const Flow.initial()) {
    on<OnboardingEvent>(_eventHandler, transformer: sequential());
  }

  final FileManager _fileManager;
  final AccountsBloc _accountsBloc;

  EventHandler<OnboardingEvent, OnboardingState> get _eventHandler =>
      (event, emit) => event.map(
            submitted: (event) => _onSubmitted(event, emit),
          );

  Future<void> _onSubmitted(
    OnboardingSubmitted event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(const Flow.processing());
    try {
      final photo = await event.photo?.let(_fileManager.copyToAppDir);

      _accountsBloc.add(
        AccountsEvent.profileUpdated(
          name: event.name,
          photo: photo,
        ),
      );
      emit(const Flow.success(null));
    } on Exception catch (e) {
      emit(Flow.failure(e));
    }
  }
}

typedef OnboardingState = Flow<Exception, void>;

@freezed
class OnboardingEvent with _$OnboardingEvent {
  const factory OnboardingEvent.submitted({
    required String name,
    File? photo,
  }) = OnboardingSubmitted;
}
