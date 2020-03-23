import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashcards/models/answerModel.dart';
import 'package:flashcards/models/deckModel.dart';
import 'package:flashcards/models/questionModel.dart';
import 'package:flashcards/models/testModel.dart';
import 'package:flashcards/models/userModel.dart';
import 'package:flashcards/screens/home/addPages/addQuestion.dart';
import 'package:flashcards/screens/home/widgets/dropDownWidget.dart';
import 'package:flashcards/services/database.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTest extends StatefulWidget {
  final String deckId;
  final String deckTitle;
  final bool deckIsGiven;
  final TestsCallback onAddTest;
  final UserModel user;
  final TestModel test;
  final bool edit;
  const AddTest({this.edit, this.test, this.deckTitle, this.deckIsGiven, this.deckId, this.onAddTest, this.user});

  @override
  _AddTestState createState() => _AddTestState();
}
class _AddTestState extends State<AddTest> {
  String deckId;
  List<DeckModel> decks = new List();
  int _questionCount = 0;
  TextEditingController _testTitleEC = TextEditingController();
  List<QuestionModel> questions = new List();
  List<AnswerModel> answers = new List();
  List<TextEditingController> questionEC = new List();
  List<TextEditingController> answerEC = new List();
  List<TextEditingController> answersEC = new List();

  List<Widget> _questions;

  @override
  Widget build(BuildContext context) {
    if(widget.edit){
      _testTitleEC.text = widget.test.title;
    }
    _questions = new List.generate(_questionCount, (int index) =>
    new AddQuestion(
      answerTextController: answerEC[index],
      questionTextController: questionEC[index],
      controllers: answersEC,
      onDeleteSelected: () {
        List<Widget> _questionList = _questions;
        _questionList.removeAt(index);
        setState(() {
          this._questions = _questionList;
        });
      },
    ));
    return Scaffold(
        backgroundColor: CustomColors.black,
        appBar: AppBar(
          title: (widget.edit)?Text('Edit Test'):Text('Add Test'),
          actions: <Widget>[
            FlatButton(
              onPressed: addTest,
              child: Row(
                children: <Widget>[
                  Text("Done", style: TextStyle(
                      color: CustomColors.PurpleDark, fontSize: 18),),
                  Icon(Icons.done, color: CustomColors.PurpleDark,),
                ],
              ),
            ),
          ],
          backgroundColor: CustomColors.black,
        ),
        body: SingleChildScrollView(
          child: Container(
//            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage('assets/graphics/mountain.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.6),
                    BlendMode.dstIn
                ),
              ),
            ),
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Container(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              decoration: BoxDecoration(color: CustomColors.White,
                  borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(20.0),
                    bottomRight: const Radius.circular(20.0),)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    child: TextField(
                      controller: _testTitleEC,
                      decoration: InputDecoration(
                        labelText: 'Enter a test title',
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: CustomColors
                              .DeepBlue, width: 1.5),
                          borderRadius: BorderRadius.circular(25.0),
                        ),),
                    ),
                  ),
                  (!widget.edit)?Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(10.0),
                          topRight: const Radius.circular(10.0),),
                        color: Colors.white,
                        border: Border.all(color: CustomColors.DeepBlue,),
                      ),
                      padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                      child: (!widget.deckIsGiven) ? StreamBuilder<QuerySnapshot>(
                          stream: DatabaseService(uid: widget.user.uid)
                              .deckCollection.document(widget.user.uid)
                              .collection("decks")
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError)
                              return Container();
                            else if (snapshot.data == null)
                              return Container();
                            else {
                              if(decks.isEmpty) {
                                snapshot.data.documents.forEach((doc) {
                                  decks.add(DeckModel().fromSnapshot(doc));
                                });
                              }
                              return DropDownWidget(
                                  expand: true,
                                  decks: decks,
                                  deckTitle: widget.deckTitle,
                                  deckIsGiven: widget.deckIsGiven,
                                  user: widget.user,
                                  onSelect: (String id) {
                                    deckId = id;
                                  });
                            }
                          }
                      ) : DropDownWidget(
                        expand: true,
                        deckTitle: widget.deckTitle,
                        deckIsGiven: widget.deckIsGiven,
                        user: widget.user,
                      ),
                    ),
                  ):Container(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    child: Container(
                      child: new ListView(
                        children: _questions,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                      ),
                    ),
                  ),
                  (!widget.edit) ? InkWell(
                    onTap: addQuestion,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 20, horizontal: 100),
                      decoration: const BoxDecoration(
                        color: CustomColors.White,
                        borderRadius: BorderRadius.all(Radius.circular(50.0),),
                        boxShadow: [
                          BoxShadow(
                            color: CustomColors.LightGrey,
                            offset: Offset(5, 5),
                            blurRadius: 15,
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.add_circle, color: CustomColors.black,),
                          Text("add a question"),
                        ],
                      ),
                    ),
                  ): Container(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                  ),
                ],
              ), //bottomNavigationBar: BottomNavBar(),
            ),
          ),
        )
    );
  }

  void addTest() {
    if(widget.edit){
      DatabaseService(uid: widget.user.uid).updateTestTitle(widget.test.testId, widget.test.deckId, _testTitleEC.text);
      Navigator.of(context).pop();
    }
    else {
      saveData();
      print("test added");
      if (_testTitleEC.text.trim().isNotEmpty) {
        if(!widget.edit) {
          if (widget.deckIsGiven) {
            TestModel test = TestModel(deckId: widget.deckId,
              title: _testTitleEC.text,
              completion: 0,
              rating: 0.0,
              isHidden: false,);
            widget.onAddTest(test, questions, answers);
          } else {
            DatabaseService(uid: widget.user.uid).addTest(deckId, _testTitleEC.text, 0.0, false, 0.0).then((doc){
              String testId = doc.documentID;
              if(questions.isNotEmpty) questions?.forEach((question){
                DatabaseService(uid: widget.user.uid).addQuestion(testId,
                    deckId, question.question, question.answer,
                    question.isHidden, question.rating).then((doc){
                  String questionId = doc.documentID;
                  if(answers.isNotEmpty){
                    answers.forEach((answer){
                      if(answer.questionId == question.questionId)
                        DatabaseService(uid: widget.user.uid).addAnswer(questionId,
                            testId, deckId, answer.answer, answer.checked, answer.correct);
                    });
                  }
                });
              });
            });
          }
        } else {
          DatabaseService(uid: widget.user.uid).updateTest(widget.test.testId, widget.test.deckId, _testTitleEC.text, 0.0, 0.0, false);
        }
        Navigator.pop(context);
      } else {
        // TODO add error
        print("test title fehlt");
      }
    }
  }

  saveData(){
    String id;
    widget.deckIsGiven ? id = widget.deckId : id = deckId;
    print(id);
    if(questionEC.isNotEmpty){
//      questionEC.forEach((ec) {
//        print("Ec " + ec.text + " " + questionEC.indexOf(ec).toString());
//      });
      if(questionEC[_questionCount - 1].text.trim().isNotEmpty){
        questions.add(
            QuestionModel(
              /*testId: getTestId(), */deckId: id,
                questionId: "question${questions.length+1}",
                question: questionEC[_questionCount-1].text, isHidden: false, rating: 0.0
            )
        );
      }
    }

    if(answerEC.isNotEmpty){
      if(answerEC[_questionCount-1].text.trim().isNotEmpty){
        answers.add(
            AnswerModel(
              /*testId: getTestId(),*/ deckId: id,
              questionId: questions.last.questionId,
//              answerId: "answer${answers.length+1}",
              answer: answerEC[_questionCount - 1].text, correct: true, checked: false,
            )
        );
      }
    }
    if(answersEC.isNotEmpty) {
      answersEC.forEach((answerEC) {
        if(answerEC.text.trim().isNotEmpty){
          answers.add(
              AnswerModel(
                /*testId: getTestId(), */deckId: id,
                  questionId: questions.last.questionId,
//                  answerId: "answer${answers.length+1}",
                  answer: answerEC.text, correct: false,
                  checked: false
              )
          );
        }
      });
    }
  }

  void addQuestion() {
    saveData();
    setState(() {
      _questionCount = _questionCount + 1;
      TextEditingController ec = new TextEditingController();
      TextEditingController ec2 = new TextEditingController();
      questionEC.add(ec);
      answerEC.add(ec2);
      if(!widget.deckIsGiven){
        decks.add(DeckModel(title: "hier",));
      }
    });
  }

}

typedef TestsCallback = void Function(TestModel test, List<QuestionModel>, List<AnswerModel>);