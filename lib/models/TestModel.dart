import 'package:flashcards/models/QuestionModel.dart';

class TestModel {
  String testTitle;
  String testDescription;
  List<QuestionModel> questions;
  double testCompletion;
  bool isHidden;

  TestModel(this.testTitle, this.testDescription, this.questions, this.testCompletion, this.isHidden);
}