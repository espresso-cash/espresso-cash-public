import 'dart:io';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/file_manager.dart';
import '../../../core/flow.dart';

part 'onboarding_bloc.freezed.dart';

@injectable
class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc(this._fileManager) : super(const Flow.initial()) {
    on<OnboardingEvent>(_eventHandler, transformer: sequential());
  }

  final FileManager _fileManager;

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

      emit(
        Flow.success(
          OnboardingResult(
            name: event.name,
            photo: photo,
            country: event.country,
          ),
        ),
      );
    } on Exception catch (e) {
      emit(Flow.failure(e));
    }
  }
}

@freezed
class OnboardingResult with _$OnboardingResult {
  const factory OnboardingResult({
    required String name,
    required File? photo,
    required String? country,
  }) = _OnboardingResult;
}

typedef OnboardingState = Flow<Exception, OnboardingResult>;

@freezed
class OnboardingEvent with _$OnboardingEvent {
  const factory OnboardingEvent.submitted({
    required String name,
    File? photo,
    String? country,
  }) = OnboardingSubmitted;
}
