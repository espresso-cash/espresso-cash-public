part of 'puzzle_reminder_bloc.dart';

@freezed
class PuzzleReminderEvent with _$PuzzleReminderEvent {
  /// Indicates that the state of resolution has to be checked
  const factory PuzzleReminderEvent.checkRequested() =
      PuzzleReminderEventCheckRequested;

  /// Indicates that the user solved the puzzle
  const factory PuzzleReminderEvent.solved() = PuzzleReminderEventSolved;

  /// Indicates that the user postponed the puzzle
  const factory PuzzleReminderEvent.postponed({
    required Duration postponedBy,
  }) = PuzzleReminderEventPostponed;

  const factory PuzzleReminderEvent.loggedOut() = PuzzleReminderEventLoggedOut;
}
