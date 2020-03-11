import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashcards/models/CardUnderstanding.dart';
import 'package:flashcards/models/answer.dart';
import 'package:flashcards/models/deck.dart';
import 'package:flashcards/models/question.dart';
import 'package:flashcards/models/test.dart';
import 'package:flashcards/models/user.dart';
import 'package:flashcards/screens/home/addQuestion.dart';
import 'package:flashcards/services/database.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flashcards/widgets/dropDownWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flashcards/Test/mockData.dart';

class AddTest extends StatefulWidget {
  final String deckId;
  final String deckTitle;
  final bool deckIsGiven;
  final TestsCallback onAddTest;
  final User user;
  const AddTest({this.deckTitle, this.deckIsGiven, this.deckId, this.onAddTest, this.user});

  @override
  _AddTestState createState() => _AddTestState();
}
class _AddTestState extends State<AddTest> {
//  List<String> _decks = new List();
  String deckId;
  List<Deck> decks = new List();
  int _questionCount = 0;
  TextEditingController _testTitleEC = TextEditingController();
  List<Question> questions = new List();
  List<Answer> answers = new List();
  final TextEditingController questionEC = new TextEditingController();
  final TextEditingController answerEC = new TextEditingController();
  final List<TextEditingController> answersEC = new List();

//  String dropDownValue = MockData.decksList[0].deckTitle;
  List<Widget> _questions;

  @override
  Widget build(BuildContext context) {
    _questions = new List.generate(_questionCount, (int index) =>
    new AddQuestion(
      testId : getTestId(),
//      onAddAnswers: (List<Answer> answers){
//        if(answers.isNotEmpty) this.answers.clear();
//        this.answers = answers;
//      },
//      onAddQuestion: (Question question) {
//          this.questions.add(question);
//      },
      answerTextController: answerEC,
      questionTextController: questionEC,
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
          title: Text('Add Test'),
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
//                  Padding(
//                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
//                  ),
//                  TextField(
//                    decoration: InputDecoration(
//                      labelText: 'Enter a card description',
//                      focusedBorder: OutlineInputBorder(
//                        borderSide: const BorderSide(color: CustomColors.DeepBlue, width: 2.0),
//                        borderRadius: BorderRadius.circular(25.0),
//                      ),
//                    ),
//                  ),
                  Padding(
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
//                      child: DropdownButton<String>(
//                        isExpanded: true,
////                        value: dropDownValue,
//                        iconSize: 28,
//                        elevation: 0,
//                        style: TextStyle(
//                          color: CustomColors.NearlyBlack,
//                          fontSize: 18,
//                          backgroundColor: Colors.white,
//                        ),
//                        onChanged: (String newValue){
//                          setState(() {
////                            dropDownValue = newValue;
//                          });
//                        },
//                        items: getDecks().map<DropdownMenuItem<String>>((String value) {
//                          return DropdownMenuItem<String>(
//                            value: value,
//                            child: Text(value, style: TextStyle(color: CustomColors.DeepBlue.withOpacity(0.9), fontWeight: FontWeight.bold),),
//                          );
//                        }).toList(),
//                      ),
                      child: (!widget.deckIsGiven) ? StreamBuilder<
                          QuerySnapshot>(
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
//                              if(decks!=null) decks.removeLast();
                              snapshot.data.documents.forEach((doc) {
                                decks.add(Deck().fromSnapshot(doc));
                              });
                              return DropDownWidget(
                                  decks: decks,
                                  deckTitle: widget.deckTitle,
                                  deckIsGiven: widget.deckIsGiven,
                                  user: widget.user,
                                  onSelect: (String id) {
                                    deckId = id;
//                                  print("tiiiiii" + deckId);
                                  });
                            }
                          }
                      ) : DropDownWidget(
                        deckTitle: widget.deckTitle,
                        deckIsGiven: widget.deckIsGiven,
                        user: widget.user,
//                        onSelect: (String id) {},
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    child: Container(
                      child: new ListView(
                        children: _questions,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                      ),
                    ),
                  ),
                  InkWell(
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
                  ),
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

//  getDecks() {
//    _decks = new List();
//    if(widget.deckIsGiven){
//      _decks.add(widget.deckTitle);
//    }
//    else MockData.decksList.forEach((element) => _decks.add(element.deckTitle));
//    return _decks;
//  }

  void addTest() {
    saveData();
    print("test added");
    if (_testTitleEC.text.isNotEmpty) {
      if (widget.deckIsGiven) {
        Test test = Test(deckId: widget.deckId,
          title: _testTitleEC.text,
          completion: 0,
          rating: 0,
          isHidden: false,);
        widget.onAddTest(test, questions, answers);
      } else {
        CollectionReference colRef = DatabaseService().deckCollection.document(
            widget.user.uid).collection("decks").document(deckId).collection("tests");

        if (colRef.getDocuments() != null) {
          colRef.getDocuments().then((doc) {
            String testId = "test${doc.documents.length + 1}";
            DatabaseService(uid: widget.user.uid).addTest(testId,
                deckId, _testTitleEC.text, 0.0, false, 0.0);
            if(questions.isNotEmpty){
              questions.forEach((question){
                DatabaseService(uid: widget.user.uid).addQuestion(question.questionId, testId,
                    deckId, question.question, question.answer,
                    question.isHidden, question.rating);
              });
            }
            if(answers.isNotEmpty){
              answers.forEach((answer){
                DatabaseService(uid: widget.user.uid).addAnswer(answer.questionId,
                    testId, deckId, answer.answer, answer.checked, answer.correct);
              });
            }
          });
        }



//    DatabaseService(uid: widget.user.uid).addQuestion(getTestId(), deckId, , answer, isHidden, rating)
//    DatabaseService(uid: widget.user.uid).addCard("deck1","deck1", "front", "back", false, CardUnderstanding.clear.toString());
      }
      Navigator.pop(context);
    } else {
      // TODO add error
      print("test title fehlt");
    }
  }

  saveData(){
//    print("ha answer " + answerEC.text);
//    print("ha question " + questionEC.text);
//    answersEC.forEach((answer){
//      print("ha answers " + answer.text);
//    });
    if(questionEC.text.trim().isNotEmpty){
      questions.add(
          Question(
              testId: getTestId(), deckId: widget.user.uid,
              questionId: "question${questions.length+1}",
              question: questionEC.text, isHidden: false
          )
      );
    }

    if(answerEC.text.trim().isNotEmpty){
      answers.add(
          Answer(
              testId: getTestId(), deckId: widget.user.uid,
              questionId: "question${questions.length+1}",
              answerId: "answer${answers.length+1}",
              answer: answerEC.text, correct: true,
          )
      );
    }

    if(answersEC.isNotEmpty) {
      answersEC.forEach((answerEC) {
        if(answerEC.text.trim().isNotEmpty){
          answers.add(
              Answer(
                testId: getTestId(), deckId: widget.user.uid,
                questionId: "question${questions.length+1}",
                answerId: "answer${answers.length+1}",
                answer: answerEC.text, correct: true,
              )
          );
        }
      });
    }
  }

  void addQuestion() {
    saveData();
    questionEC.clear();
    answerEC.clear();
    answersEC.clear();
    setState(() {
      _questionCount = _questionCount + 1;
      if(!widget.deckIsGiven){
//        decks.removeLast();
        decks.add(Deck(title: "hier",));
      }
    });
  }

  String getTestId() {
    if(!widget.deckIsGiven){
      CollectionReference colRef = DatabaseService().deckCollection.document(
          widget.user.uid).collection("decks").document(deckId).collection("tests");

      if (colRef.getDocuments() != null) {
        colRef.getDocuments().then((doc) {
          return "test${doc.documents.length + 1}";
        });
      } else return "test1";
    }else{
      CollectionReference colRef = DatabaseService().deckCollection.document(
          widget.user.uid).collection("decks").document(widget.deckId).collection(
          "tests");

      if (colRef.getDocuments() != null) {
        colRef.getDocuments().then((doc) {
          return "test${doc.documents.length + 1}";
        });
      } else return "";
    }
    return "";
  }
}

typedef TestsCallback = void Function(Test test, List<Question>, List<Answer>);