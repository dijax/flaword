class AnswerModel{
  String answer;
  bool correct;
  bool checked;
  bool answered;

  AnswerModel(this.answer, this.correct, this.checked);

  bool getChecked(){
    return this.checked;
  }

  void setChecked(bool checked) {
    this.checked = checked;
  }

  bool getAnswered(){
    return this.answered;
  }

  void setAnswered(bool answered) {
    this.answered = answered;
  }
}

