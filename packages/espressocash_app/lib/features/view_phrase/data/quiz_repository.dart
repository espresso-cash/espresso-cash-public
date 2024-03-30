import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../l10n/gen/app_localizations.dart';
import '../models/quiz.dart';

@injectable
class QuizRepository {
  const QuizRepository();

  IList<QuizQuestion> getQuestions(AppLocalizations l10n) => [
        QuizQuestion(
          question: l10n.quizFirstQuestion,
          options: [
            l10n.quizFirstQuestionOptionA,
            l10n.quizFirstQuestionOptionB,
          ].lock,
          correctAnswer: 1,
          correctExplanation: (
            title: l10n.quizFirstQuestionExplanationTitle,
            description: l10n.quizFirstQuestionExplanationSubtitle1,
          ),
          incorrectExplanation: (
            title: l10n.quizFirstQuestionExplanationTitle,
            description: l10n.quizFirstQuestionExplanationSubtitle2,
          ),
        ),
        QuizQuestion(
          question: l10n.quizSecondQuestion,
          options: [
            l10n.quizSecondQuestionOptionA,
            l10n.quizSecondQuestionOptionB,
          ].lock,
          correctAnswer: 0,
          correctExplanation: (
            title: l10n.quizSecondQuestionExplanationTitle,
            description: l10n.quizSecondQuestionExplanationSubtitle,
          ),
          incorrectExplanation: (
            title: l10n.quizSecondQuestionExplanationTitle,
            description: l10n.quizSecondQuestionExplanationSubtitle,
          ),
        ),
      ].lock;
}
