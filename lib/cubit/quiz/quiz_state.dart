part of 'quiz_cubit.dart';

@immutable
abstract class QuizState {}

class QuizInitial extends QuizState {}
class MoveToNextQuestion extends QuizState {}
class MoveToPreviousQuestion extends QuizState {}
class ChooseAnswerState extends QuizState {}
class CalculateResultState extends QuizState {}