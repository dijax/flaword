import 'package:flashcards/models/AnswerModel.dart';
import 'package:flashcards/models/CardModel.dart';
import 'package:flashcards/models/CardUnderstanding.dart';
import 'package:flashcards/models/DeckModel.dart';
import 'package:flashcards/models/QuestionModel.dart';
import 'package:flashcards/models/TestModel.dart';

class MockData{

  // Flashcards for the Math deck
  static List<CardModel> mathCardsList = [
    CardModel("first card", "first card", "this the front side of the first Card", "this is the back side of the first card", false, CardUnderstanding.none),
    CardModel("second card", "second card","this the front side of the first card", "this is the back side of the second card", false, CardUnderstanding.none),
    CardModel("3rd card", "3rd card", "this the front side of the 3rd Card", "this is the back side of the 3rd card", false, CardUnderstanding.none),
    CardModel("4th card", "4th card", "this the front side of the 4th Card", "this is the back side of the 4th card", false, CardUnderstanding.none),
    CardModel("5th card", "5th card", "this the front side of the 5th Card", "this is the back side of the 5th card", false, CardUnderstanding.none),
    CardModel("6th card", "6th card", "this the front side of the 6th Card", "this is the back side of the 6th card", false, CardUnderstanding.none),
    CardModel("7th card", "7th card", "this the front side of the 7th Card", "this is the back side of the 7th card", false, CardUnderstanding.none),
    CardModel("8th card", "8th card", "this the front side of the 8th Card", "this is the back side of the 8th card", false, CardUnderstanding.none),
    CardModel("9th card", "9th card", "this the front side of the 9th Card", "this is the back side of the 9th card", false, CardUnderstanding.none),
  ];

  // Flashcards for the physics deck
  static List<CardModel> physicsCardsList = [
    CardModel("first card", "first card", "this the front side of the first Card", "this is the back side of the second card", false, CardUnderstanding.none),
    CardModel("second card", "second card", "this the front side of the first card", "this is the back side of the second card", false, CardUnderstanding.none),
    CardModel("3rd card", "3rd card", "this the front side of the 3rd Card", "this is the back side of the 3rd card", false, CardUnderstanding.none),
    CardModel("4th card", "4th card", "this the front side of the 4th Card", "this is the back side of the 4th card", false, CardUnderstanding.none),
    CardModel("5th card", "5th card", "this the front side of the 5th Card", "this is the back side of the 5th card", false, CardUnderstanding.none),
    CardModel("6th card", "6th card", "this the front side of the 6th Card", "this is the back side of the 6th card", false, CardUnderstanding.none),
    CardModel("7th card", "7th card", "this the front side of the 7th Card", "this is the back side of the 7th card", false, CardUnderstanding.none),
    CardModel("8th card", "8th card", "this the front side of the 8th Card", "this is the back side of the 8th card", false, CardUnderstanding.none),
    CardModel("9th card", "9th card", "this the front side of the 9th Card", "this is the back side of the 9th card", false, CardUnderstanding.none),
    CardModel("10th card", "10th card", "this the front side of the 10th Card", "this is the back side of the 10th card", false, CardUnderstanding.none),
  ];

  // Flashcards for the biology deck
  static List<CardModel> biologyCardsList = [
    CardModel("first card", "first card", "this the front side of the first Card", "this is the back side of the second card", false, CardUnderstanding.none),
    CardModel("second card", "second card", "this the front side of the first card", "this is the back side of the second card", false, CardUnderstanding.none),
    CardModel("3rd card", "3rd card", "this the front side of the 3rd Card", "this is the back side of the 3rd card", false, CardUnderstanding.none),
    CardModel("4th card", "4th card", "this the front side of the 4th Card", "this is the back side of the 4th card", false, CardUnderstanding.none),
    CardModel("5th card", "5th card", "this the front side of the 5th Card", "this is the back side of the 5th card", false, CardUnderstanding.none),
    CardModel("6th card", "6th card", "this the front side of the 6th Card", "this is the back side of the 6th card", false, CardUnderstanding.none),
    CardModel("7th card", "7th card", "this the front side of the 7th Card", "this is the back side of the 7th card", false, CardUnderstanding.none),
    CardModel("8th card", "8th card", "this the front side of the 8th Card", "this is the back side of the 8th card", false, CardUnderstanding.none),
  ];

  static List<AnswerModel> answers1 = [AnswerModel("this is the first correct answer of the first math question", true),
                                       AnswerModel("this is the second correct answer of the first math question", true),
                                       AnswerModel("this is the first false answer of the first math question", false),
                                       AnswerModel("this is the second false answer of the first math question", false)];

  static List<AnswerModel> answers2 = [AnswerModel("this is the first correct answer of the 2nd math question", true),
                                       AnswerModel("this is the second correct answer of the 2nd math question", true),
                                       AnswerModel("this is the first false answer of the 2nd math question", false),
                                       AnswerModel("this is the second false answer of the 2nd math question", false)];

  static List<AnswerModel> answers3 = [AnswerModel("this is the first correct answer of the 3rd math question", true),
                                       AnswerModel("this is the second correct answer of the 3rd math question", true),
                                       AnswerModel("this is the first false answer of the 3rd math question", false),
                                       AnswerModel("this is the second false answer of the 3rd math question", false)];

  static List<AnswerModel> answers4 = [AnswerModel("this is the first correct answer of the 4th math question", true),
                                       AnswerModel("this is the second correct answer of the 4th math question", true),
                                       AnswerModel("this is the first false answer of the 4th math question", false),
                                       AnswerModel("this is the second false answer of the 4th math question", false)];

  static List<AnswerModel> answers5 = [AnswerModel("this is the first correct answer of the 5th math question", true),
                                       AnswerModel("this is the second correct answer of the 5th math question", true),
                                       AnswerModel("this is the first false answer of the 5th math question", false),
                                       AnswerModel("this is the second false answer of the 5th math question", false)];

  static List<AnswerModel> answers6 = [AnswerModel("this is the first correct answer of the 6th math question", true),
                                       AnswerModel("this is the second correct answer of the 6th math question", true),
                                       AnswerModel("this is the first false answer of the 6th math question", false),
                                       AnswerModel("this is the second false answer of the 6th math question", false)];

  // Questionlist for the math deck
  static List<QuestionModel> mathQuestionsList = [
    QuestionModel("this is the 1st math question", answers1, false),
    QuestionModel("this is the 2nd math question", answers2, false),
    QuestionModel("this is the 3rd math question", answers3, false),
    QuestionModel("this is the 4th math question", answers4, false),
    QuestionModel("this is the 5th math question", answers5, false),
    QuestionModel("this is the 6th math question", answers6, false),
  ];

  static List<TestModel> mathTestsList = [
    // first math test
    TestModel("Math test1", "this is the math test1", mathQuestionsList, 0.0),
    TestModel("Math test2", "this is the math test2", mathQuestionsList, 0.0),
    TestModel("Math test3", "this is the math test3", mathQuestionsList, 0.0),
    TestModel("Math test4", "this is the math test4", mathQuestionsList, 0.0),
    TestModel("Math test5", "this is the math test5", mathQuestionsList, 0.0),
  ];

  static List<AnswerModel> phyAnswers = [AnswerModel("this is the first correct answer of the 1st physics question", true)];

  static List<TestModel> physicsTestsList = [
    TestModel("Physics test1", "this is the math test1", phyQuestionsList, 0.0),
  ];
  static List<QuestionModel> phyQuestionsList = [
  QuestionModel("this is the 1st phy question", phyAnswers, false),];

  static List<AnswerModel> bioAnswers = [AnswerModel("this is the first correct answer of the 1st bio question", true)];
  static List<QuestionModel> bioQuestionsList = [
  QuestionModel("this is the 1st phy question", phyAnswers, false),];

  static List<TestModel> biologyTestsList = [
    TestModel("Biology test1", "this is the math test1", bioQuestionsList, 0.0),
  ];

  static List<DeckModel> decksList = [
    DeckModel("Math deck", mathCardsList, mathTestsList, 0.4),
    DeckModel("Physics Deck", physicsCardsList, physicsTestsList, 0.1),
    DeckModel("Biology Deck", biologyCardsList, biologyTestsList, 0.2),
  ];

  static List<DeckModel> getDecksList() {
    return decksList;
  }

  static List<TestModel> getTestList() {
    return mathTestsList;
  }
}
