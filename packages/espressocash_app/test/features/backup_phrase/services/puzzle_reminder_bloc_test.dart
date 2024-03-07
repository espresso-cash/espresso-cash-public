import 'package:espressocash_app/features/backup_phrase/services/puzzle_reminder_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'correctly parses solved data',
    () {
      final data = <String, dynamic>{'runtimeType': 'solved'};
      expect(
        PuzzleReminderData.fromJson(data),
        const PuzzleReminderData.solved(),
      );
    },
  );

  test(
    'falls back to unset on unknown type',
    () {
      final data = <String, dynamic>{'runtimeType': 'smth'};
      expect(
        PuzzleReminderData.fromJson(data),
        const PuzzleReminderData.unset(),
      );
    },
  );
}
