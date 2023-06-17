import 'dart:convert';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/accounts/bl/account.dart';
import '../../../../core/accounts/bl/ec_wallet.dart';

part 'puzzle_reminder_bloc.freezed.dart';
part 'puzzle_reminder_bloc.g.dart';
part 'puzzle_reminder_event.dart';
part 'puzzle_reminder_state.dart';

@injectable
class PuzzleReminderBloc
    extends Bloc<PuzzleReminderEvent, PuzzleReminderState> {
  PuzzleReminderBloc(this._sharedPreferences)
      : super(const PuzzleReminderState.none()) {
    on<PuzzleReminderEvent>(_eventHandler, transformer: sequential());
  }

  final SharedPreferences _sharedPreferences;

  EventHandler<PuzzleReminderEvent, PuzzleReminderState> get _eventHandler =>
      (event, emit) => event.map(
            checkRequested: (e) => _onCheckRequested(e, emit),
            solved: (_) => _onSolved(),
            postponed: _onPostponed,
            loggedOut: (_) => _onLoggedOut(),
          );

  Future<PuzzleReminderData> _readSharedPreferences() async {
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
    if (event.wallet is SagaWallet) {
      // Don't set a reminder if wallet is from Saga
      add(const PuzzleReminderEvent.solved());

      return;
    }

    await event.accessMode.when(
      // Don't set a reminder if user logged in (they already know the seed)
      seedInputted: () async => add(const PuzzleReminderEvent.solved()),
      // Postpone the reminder by 1 day if user created account now
      created: () async => add(
        const PuzzleReminderEvent.postponed(postponedBy: Duration(days: 1)),
      ),
      // Check for reminder if user account was loaded from storage
      loaded: () async {
        final data = await _readSharedPreferences();

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

  Future<void> _onLoggedOut() => _sharedPreferences.remove(_spKey);
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
