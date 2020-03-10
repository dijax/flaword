class Answer{
  final String testId;
  final String deckId;
  final String questionId;
  final String answerId;
  final String answer;
  final bool checked;
  final bool correct;
  Answer({this.testId, this.deckId, this.questionId, this.checked, this.answer,
    this.correct, this.answerId});
}