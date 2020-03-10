class Question{
  final String testId;
  final String deckId;
  final String questionId;
  final String question;
  final String answer;
  final double rating;
  final bool isHidden;
  Question({this.testId, this.deckId, this.questionId, this.question, this.answer, this.rating, this.isHidden});
}