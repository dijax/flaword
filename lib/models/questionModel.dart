class QuestionModel{
  final String testId;
  final String deckId;
  final String questionId;
  final String question;
  final String answer;
  final double rating;
  final bool isHidden;
  final int answerCount;
  QuestionModel({this.testId, this.deckId, this.questionId, this.question, this.answer, this.rating, this.isHidden, this.answerCount});
}