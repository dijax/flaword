import 'package:flashcards/models/answer.dart';
import 'package:flashcards/models/question.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flutter/material.dart';

class AddQuestion extends StatefulWidget {
  final QuestionCallback onAddQuestion;
  final AnswersCallback onAddAnswers;
  final TextEditingController questionTextController;
  final TextEditingController answerTextController;
  final List<TextEditingController> controllers;
  final VoidCallback onDeleteSelected;
//  final String testId;
  const AddQuestion({this.onAddAnswers, this.onAddQuestion, this.onDeleteSelected, this.questionTextController, this.answerTextController, this.controllers});
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  Answer answer;
  int _answersCount = 0;
  Question question;
  List<Answer> answers = new List();

  @override
  Widget build(BuildContext context) {
    for(int i = 0; i< _answersCount; i++){
      TextEditingController ec = new TextEditingController();
      widget.controllers.add(ec);
    }
    List<Widget> _answers = new List.generate(_answersCount, (int answerIndex) => new Container (
        child: Column(children: <Widget>[
          Padding(padding: EdgeInsets.all(8),),
          TextField(
//            onChanged: others,
            controller: widget.controllers[answerIndex],
//            cursorWidth: 300,
            decoration: InputDecoration(
              labelText: 'Enter another answer',
//                border: OutlineInputBorder(
//                    borderRadius: const BorderRadius.all(
//                      const Radius.circular(10.0),
//                    )
//                ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: CustomColors.DeepBlue, width: 1.5),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
        ],)));

    return Container(
      child: Stack(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: CustomColors.White,
                boxShadow: [
                  BoxShadow(
                    color: CustomColors.LightGrey,
                    offset: Offset(5,5),
                    blurRadius: 15,
                  )
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Enter a question',
//                border: OutlineInputBorder(
//                  borderRadius: const BorderRadius.all(
//                    const Radius.circular(10.0),
//                  )
//                ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: CustomColors.DeepBlue, width: 1.5),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
//                    onChanged: addQuestion(),
                  controller: widget.questionTextController,
                  ),
                  Padding(padding: EdgeInsets.all(8),),
                  TextField(
//                    onChanged: addAnswer(),
                    controller: widget.answerTextController,
                    decoration: InputDecoration(
                      labelText: 'Enter an answer',
//                border: OutlineInputBorder(
//                    borderRadius: const BorderRadius.all(
//                      const Radius.circular(10.0),
//                    )
//                ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: CustomColors.DeepBlue, width: 1.5),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  InkWell(
                    onTap: addOtherAnswer,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                        color: CustomColors.White,
                        boxShadow: [
                          BoxShadow(
                            color: CustomColors.LightGrey,
                            offset: Offset(5,5),
                            blurRadius: 15,
                          )
                        ],
                      ),

                      child: Column(
                        children: <Widget>[
                          ListView(
                            children: _answers,
                            physics: const NeverScrollableScrollPhysics(),
//                            scrollDirection: Axis.vertical,,
                            shrinkWrap: true,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                          ),
                          Icon(Icons.add_circle, color: CustomColors.black, size: 30, ),
                          FittedBox(
                            fit:BoxFit.contain,
                            child: Text("Add other answers", style: TextStyle(fontFamily: 'Monsterrat', fontSize: 12, fontWeight: FontWeight.bold, ), textWidthBasis: TextWidthBasis.parent,),
                          ),
                          FittedBox(
                            fit:BoxFit.contain,
                            child: Text("(multiple choice question)", style: TextStyle(fontFamily: 'Monsterrat', fontSize: 12, fontWeight: FontWeight.bold, ), textWidthBasis: TextWidthBasis.parent,),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
          ),
          Positioned(
            right: 0.0,
            child: InkWell(
              onTap: (){
                setState(() {
                  _answersCount = _answersCount - 1; //TODO: Fix
                });
              },
              child: Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 14.0,
                  backgroundColor: CustomColors.White,
                  child: Icon(Icons.delete, color: CustomColors.black,),
                ),
              ),
            ),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 20),
    );
  }

  void addOtherAnswer() {
    setState(() {
      _answersCount = _answersCount + 1;
    });
  }

  addAnswer() {
//    if(widget.answerTextController.text.trim().isNotEmpty){
//      answer = Answer(testId: widget.testId, answer: _answerTextController.text, checked: false, correct: true);
//      answers.add(answer);
//      widget.onAddAnswers(answers);
//    }
  }

  addQuestion() {
//    if(widget.questionTextController.text.trim().isNotEmpty){
//      question = Question(testId: widget.testId, question: _questionTextController.text, isHidden: false);
//      widget.onAddQuestion(question);
//    }
  }

  void others(String value) {
//    if(controllers.isNotEmpty){
//      answer = Answer(testId: widget.testId, answer: value, checked: false, correct: false);
//      answers.replaceRange(_answersCount, _answersCount, [answer, answer]);
//      widget.onAddAnswers(answers);
//    }
  }
}

typedef QuestionCallback = void Function(Question question);
typedef AnswersCallback = void Function(List<Answer> answers);
