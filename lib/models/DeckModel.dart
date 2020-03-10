import 'CardModel.dart';
import 'TestModel.dart';

class DeckModel{
  String deckTitle;
//  List<CardModel> cards;
  List<TestModel> tests;
  double deckCompletion;
  DateTime visitDate;
  bool isHidden;
  DeckModel(this.deckTitle, /*this.cards, */this.tests, this.deckCompletion, this.visitDate, this.isHidden);
}