enum QuizOption { optionA, optionB }

typedef Explanation = ({
  String title,
  String description,
});

class QuizQuestion {
  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.correctExplanation,
    required this.incorrectExplanation,
  });

  String question;
  Map<QuizOption, String> options;
  QuizOption correctAnswer;
  Explanation correctExplanation;
  Explanation incorrectExplanation;
}
