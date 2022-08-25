import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie_app/models/quiz/question.dart';
import 'package:la_vie_app/repositories/src/local/shared_preference/cache_helper.dart';
import 'package:la_vie_app/repositories/src/local/shared_preference/cache_keys.dart';
import 'package:meta/meta.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit() : super(QuizInitial());
  static QuizCubit get(context) => BlocProvider.of(context);
  List<Question> questions = [
    Question(
        question: "What is the user experience?",
        answers: [
          "The user experience is how the developer feels about a user.",
          "The user experience is how the developer feels about a user.",
          "The user experience is how the developer feels about a user."
        ],
        correctAnswerIndex: 1),
    Question(
        question: "What is the user experience?",
        answers: [
          "The user experience is how the developer feels about a user.",
          "The user experience is how the developer feels about a user.",
          "The user experience is how the developer feels about a user."
        ],
        correctAnswerIndex: 1),
    Question(
        question: "What is the user experience?",
        answers: [
          "The user experience is how the developer feels about a user.",
          "The user experience is how the developer feels about a user.",
          "The user experience is how the developer feels about a user."
        ],
        correctAnswerIndex: 1),
    Question(
        question: "What is the user experience?",
        answers: [
          "The user experience is how the developer feels about a user.",
          "The user experience is how the developer feels about a user.",
          "The user experience is how the developer feels about a user."
        ],
        correctAnswerIndex: 1),
    Question(
        question: "What is the user experience?",
        answers: [
          "The user experience is how the developer feels about a user.",
          "The user experience is how the developer feels about a user.",
          "The user experience is how the developer feels about a user."
        ],
        correctAnswerIndex: 1),
    Question(
        question: "What is the user experience?",
        answers: [
          "The user experience is how the developer feels about a user.",
          "The user experience is how the developer feels about a user.",
          "The user experience is how the developer feels about a user."
        ],
        correctAnswerIndex: 1),
    Question(
        question: "What is the user experience?",
        answers: [
          "The user experience is how the developer feels about a user.",
          "The user experience is how the developer feels about a user.",
          "The user experience is how the developer feels about a user."
        ],
        correctAnswerIndex: 1),
    Question(
        question: "What is the user experience?",
        answers: [
          "The user experience is how the developer feels about a user.",
          "The user experience is how the developer feels about a user.",
          "The user experience is how the developer feels about a user."
        ],
        correctAnswerIndex: 1),
    Question(
        question: "What is the user experience?",
        answers: [
          "The user experience is how the developer feels about a user.",
          "The user experience is how the developer feels about a user.",
          "The user experience is how the developer feels about a user."
        ],
        correctAnswerIndex: 1),
    Question(
        question: "What is the user experience?",
        answers: [
          "The user experience is how the developer feels about a user.",
          "The user experience is how the developer feels about a user.",
          "The user experience is how the developer feels about a user."
        ],
        correctAnswerIndex: 1),
  ];
  bool showQuiz() {
    String value = CacheKeysManger.getLastQuizFromCache();
    if (value == '') {
      return true;
    } else {
      DateTime lastQuiz = DateTime.parse(value);
      if (lastQuiz.difference(DateTime.now()).inDays >= 7) {
        return true;
      } else {
        return false;
      }
    }
  }

  int correctAnswers = 0;
  int currentQuestion = 0;
  bool isFirst = true;
  bool isLast = false;
  void moveToNextQuestion() {
    currentQuestion++;
    isFirst = false;
    if (currentQuestion == questions.length - 1) {
      isLast = true;
    }
    emit(MoveToNextQuestion());
  }

  void backToPreviousQuestion() {
    currentQuestion--;
    isLast = false;
    if (currentQuestion == 0) {
      isFirst = true;
    }
    emit(MoveToPreviousQuestion());
  }

  void chooseAnswer(int answerId) {
    questions[currentQuestion].userAnswerIndex = answerId;
    emit(ChooseAnswerState());
  }

  void calculateResult() {
    correctAnswers = 0;
    for (var item in questions) {
      if (item.userAnswerIndex == item.correctAnswerIndex) {
        correctAnswers++;
      }
    }
    CacheHelper.saveData(key: "lastQuiz", value: DateTime.now().toString());
    emit(CalculateResultState());
  }
}
