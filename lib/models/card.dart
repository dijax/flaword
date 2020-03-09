class CardModel{
  final String cardId;
  final String deckId;
  final String title;
  final String front;
  final String back;
  final String cardUnderstanding;
  final bool hidden;
  CardModel ({this.cardId, this.deckId, this.title, this.front, this.back, this.cardUnderstanding, this.hidden});
}