class Question {
  String question;
  List<String> answers;
  int userAnswerIndex;
  int correctAnswerIndex;

  Question({
    required this.question,
    required this.answers,
    required this.correctAnswerIndex,
    this.userAnswerIndex = 0,
  });
}
