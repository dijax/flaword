class Deck{
  final String deckId;
  final String title;
  final int cardsCount;
  final int testsCount;
  final double completion;
  final DateTime visited;
  final bool hidden;
  Deck({this.deckId, this.title, this.cardsCount, this.testsCount, this.completion, this.visited, this.hidden});
}