import 'package:flashcards/models/AnswerModel.dart';

class QuestionModel {
  String question;
  List<AnswerModel> answers;
  bool answered;

  QuestionModel(this.question, this.answers, this.answered);
}