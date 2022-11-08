part of 'puzzle_reminder_bloc.dart';

@freezed
class PuzzleReminderState with _$PuzzleReminderState {
  /// The base state which requires no action
  const factory PuzzleReminderState.none() = PuzzleReminderStateNone;

  /// Means that the user needs to be reminded now
  const factory PuzzleReminderState.remindNow() = PuzzleReminderStateRemindNow;
}
