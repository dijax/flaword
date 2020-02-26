import 'CardUnderstanding.dart';

class CardModel {
  String cardTitle;
  String cardDescription;
  String front;
  String back;
  bool hidden;
  CardUnderstanding cardUnderstanding;

  CardModel(this.cardTitle, this.cardDescription, this.back, this.front, this.hidden, this.cardUnderstanding);

  CardUnderstanding get understand{
    return cardUnderstanding;
  }

  set understand(CardUnderstanding understanding) {
    this.cardUnderstanding = understanding;
  }
}