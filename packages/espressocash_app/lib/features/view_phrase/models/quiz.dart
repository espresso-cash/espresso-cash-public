import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz.freezed.dart';

typedef Explanation = ({
  String title,
  String description,
});

@freezed
class QuizQuestion with _$QuizQuestion {
  const factory QuizQuestion({
    required String question,
    required IList<String> options,
    required int correctAnswer,
    required Explanation correctExplanation,
    required Explanation incorrectExplanation,
  }) = _QuizQuestion;
}
