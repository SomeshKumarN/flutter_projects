class QuizQuestion {
  const QuizQuestion(this.question, this.answerOptions);
  final String question;
  final List<String> answerOptions;
  List<String> getShuffedAnswers() {
    final shuffeledAnswers = List.of(answerOptions);
    shuffeledAnswers.shuffle();
    return shuffeledAnswers;
  }
}
