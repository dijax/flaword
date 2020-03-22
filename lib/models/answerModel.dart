class AnswerModel{
  final String testId;
  final String deckId;
  final String questionId;
  final String answerId;
  final String answer;
  bool checked;
  final bool correct;
  AnswerModel({this.testId, this.deckId, this.questionId, this.checked, this.answer,
    this.correct, this.answerId});

  void setChecked(bool checked) {
    this.checked = checked;
  }
}