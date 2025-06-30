class QuizQuestion {
  final String question;
  final List<String> answers;

  const QuizQuestion(this.question, this.answers);

  List<String> getShuffledAnswers() {
    final List<String> shuffledAnswers = List.of(answers); // creates a copy
    shuffledAnswers.shuffle();
    return shuffledAnswers;
  }

  String get correctAnswer => answers[0]; // Assuming first is correct
}
