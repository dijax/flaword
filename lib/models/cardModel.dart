import 'package:flashcards/models/CardUnderstanding.dart';

class CardModel{
  final String cardId;
  final String deckId;
  final String title;
  final String front;
  final String back;
  String cardUnderstanding;
  final String description;
  final bool isHidden;
  CardModel ({this.description, this.cardId, this.deckId, this.title, this.front, this.back, this.cardUnderstanding, this.isHidden});

  setCardUnderstanding(CardUnderstanding cardUnderstanding){
    this.cardUnderstanding =  cardUnderstanding.toString();
  }
}