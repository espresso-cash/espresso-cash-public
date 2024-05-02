import 'dart:convert';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/disposable_bloc.dart';
import '../../accounts/auth_scope.dart';
import '../../accounts/models/account.dart';
import '../../accounts/models/ec_wallet.dart';

part 'puzzle_reminder_bloc.freezed.dart';
part 'puzzle_reminder_bloc.g.dart';

@Freezed(when: FreezedWhenOptions.none, map: FreezedMapOptions.none)
sealed class PuzzleReminderState with _$PuzzleReminderState {
  /// The base state which requires no action
  const factory PuzzleReminderState.none() = PuzzleReminderStateNone;

  /// Means that the user needs to be reminded now
  const factory PuzzleReminderState.remindNow() = PuzzleReminderStateRemindNow;
}

@Freezed(when: FreezedWhenOptions.none, map: FreezedMapOptions.none)
sealed class PuzzleReminderEvent with _$PuzzleReminderEvent {
  /// Indicates that the state of resolution has to be checked
  const factory PuzzleReminderEvent.checkRequested({
    required AccessMode accessMode,
    required ECWallet wallet,
  }) = PuzzleReminderEventCheckRequested;

  /// Indicates that the user solved the puzzle
  const factory PuzzleReminderEvent.solved() = PuzzleReminderEventSolved;

  /// Indicates that the user postponed the puzzle
  const factory PuzzleReminderEvent.postponed({
    required Duration postponedBy,
  }) = PuzzleReminderEventPostponed;
}

@Singleton(scope: authScope)
class PuzzleReminderBloc extends Bloc<PuzzleReminderEvent, PuzzleReminderState>
    with DisposableBloc {
  PuzzleReminderBloc(this._sharedPreferences)
      : super(const PuzzleReminderState.none()) {
    on<PuzzleReminderEvent>(_eventHandler, transformer: sequential());
  }

  final SharedPreferences _sharedPreferences;

  EventHandler<PuzzleReminderEvent, PuzzleReminderState> get _eventHandler =>
      (event, emit) => switch (event) {
            PuzzleReminderEventCheckRequested() =>
              _onCheckRequested(event, emit),
            PuzzleReminderEventSolved() => _onSolved(),
            PuzzleReminderEventPostponed() => _onPostponed(event),
          };

  PuzzleReminderData _readSharedPreferences() {
    final content = _sharedPreferences.getString(_spKey);

    return content == null
        ? const PuzzleReminderData.unset()
        : PuzzleReminderData.fromJson(
            json.decode(content) as Map<String, dynamic>,
          );
  }

  Future<void> _writeSharedPreferences(PuzzleReminderData data) =>
      _sharedPreferences.setString(_spKey, json.encode(data.toJson()));

  /// Check if the puzzle has been solved. If the key is not found in the
  /// shared preferences, it means that we are here for the first time, so
  /// show the message right away.
  ///
  /// If it was previously set, the check the `remindAt` value and schedule
  Future<void> _onCheckRequested(
    PuzzleReminderEventCheckRequested event,
    Emitter<PuzzleReminderState> emit,
  ) async {
    await event.accessMode.when(
      // Don't set a reminder if user logged in (they already know the seed)
      seedInputted: () async => add(const PuzzleReminderEvent.solved()),
      // Postpone the reminder by 1 day if user created account now
      created: () async => add(
        const PuzzleReminderEvent.postponed(postponedBy: Duration(days: 1)),
      ),
      // Check for reminder if user account was loaded from storage
      loaded: () async {
        final data = _readSharedPreferences();

        if (data.shouldRemindNow) {
          emit(const PuzzleReminderState.remindNow());
          emit(const PuzzleReminderState.none());
        }
      },
    );
  }

  /// Mark the reminder as postponed and set a date time in which to remind
  Future<void> _onPostponed(PuzzleReminderEventPostponed event) async {
    final newDate = DateTime.now().add(event.postponedBy);
    await _writeSharedPreferences(
      PuzzleReminderData.remindAfter(remindAt: newDate),
    );
  }

  /// Mark the puzzle as solved and never ask again
  Future<void> _onSolved() =>
      _writeSharedPreferences(const PuzzleReminderData.solved());

  @override
  Future<void> close() {
    _sharedPreferences.remove(_spKey);

    return super.close();
  }
}

const _spKey = 'puzzleReminder';

@Freezed(fallbackUnion: 'unset')
class PuzzleReminderData with _$PuzzleReminderData {
  const PuzzleReminderData._();

  const factory PuzzleReminderData.unset() = _PuzzleReminderDataUnset;

  const factory PuzzleReminderData.solved() = _PuzzleReminderDataSolved;

  const factory PuzzleReminderData.remindAfter({
    required DateTime remindAt,
  }) = _PuzzleReminderDataRemindAfter;

  factory PuzzleReminderData.fromJson(Map<String, dynamic> json) =>
      _$PuzzleReminderDataFromJson(json);

  bool get shouldRemindNow => maybeWhen(
        unset: () => true,
        remindAfter: (remindAt) => remindAt.isBefore(DateTime.now()),
        orElse: () => false,
      );
}
