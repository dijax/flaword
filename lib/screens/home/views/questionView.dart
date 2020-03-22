import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashcards/models/answerModel.dart';
import 'package:flashcards/models/questionModel.dart';
import 'package:flashcards/models/testModel.dart';
import 'package:flashcards/models/userModel.dart';
import 'package:flashcards/services/database.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flashcards/screens/home/widgets/finishDialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

GlobalKey<_AnswerWidgetState> globalKey = GlobalKey();

class QuestionView extends StatefulWidget {
  final TestModel test;
  final int quIndex;
  final int testIndex;
  final UserModel user;
  QuestionView({this.test, this.quIndex, this.testIndex, this.user});
  _QuestionViewState createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  int _queIndex = 0;
  bool _false = false;

  @override void initState() {
    super.initState();
    _queIndex = widget.quIndex;
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<QuestionModel>>.value(value: DatabaseService(uid: widget.user.uid, deck_Id: widget.test.deckId, tstId: widget.test.testId).questions),
        StreamProvider<List<AnswerModel>>.value(value: DatabaseService(uid: widget.user.uid, deck_Id: widget.test.deckId, tstId: widget.test.testId).answers),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.test.title),
          backgroundColor: CustomColors.black,
        ),
        backgroundColor: CustomColors.White,
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              StreamProvider<List<QuestionModel>>.value(
                value: DatabaseService(uid: widget.user.uid, deck_Id: widget.test.deckId, tstId: widget.test.testId).questions,
                child: QuestionWidget(user: widget.user, testId: widget.test.testId, questionIndex: _queIndex, test: widget.test),
              ),
              (_false)? Container(
                  child: Column(children: <Widget>[
                    Text("false answer, try again", style: TextStyle(color: CustomColors.TrashRed),),
                    Icon(Icons.cancel, color: CustomColors.TrashRed,)
                  ],)
              ):Container(),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    color: CustomColors.PurpleDark,
                    onPressed: (){
                      if(_queIndex > 0) setState(() {
                        _queIndex = _queIndex - 1;
                      });
                    },
                  ),
                  Text("last question", style: TextStyle(color: CustomColors.PurpleDark),),
                ],
              ),
              Row(
                children: <Widget>[
                  Text("Next question", style: TextStyle(color: CustomColors.PurpleDark),),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    color: CustomColors.PurpleDark,
                    onPressed: (){
                      CollectionReference colRef = DatabaseService().deckCollection.document(
                          widget.user.uid).collection("decks").document(widget.test.deckId).
                      collection("tests").document(widget.test.testId)?.collection("questions");
                      if (colRef?.getDocuments() != null) {
                        colRef?.getDocuments()?.then((doc) {
                          if(doc != null && globalKey != null && globalKey.currentState != null){
                            if(globalKey.currentState.isCorrect()){
                              setState(() {
                                _false = false;
                                if(_queIndex < doc.documents.length-1) _queIndex = _queIndex +1 ;
                                else{
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) => FinishDialog(
                                      title: "Success",
                                      description:
                                      "You have finished the test.",
                                      buttonText: "Okay",
                                      icon: Icon(Icons.done, color: CustomColors.White,),
                                    ),
                                  );
                                }
                              });
                            } else{
                              setState(() {
                                _false = true;
                              });
                            }
                          }
                        });
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuestionWidget extends StatefulWidget {
  final int questionIndex;
  final UserModel user;
  final String testId;
  final TestModel test;

  QuestionWidget({this.questionIndex, this.user, this.testId, this.test});

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  bool show = false;
  @override
  Widget build(BuildContext context) {
    final questions = Provider.of<List<QuestionModel>>(context);
    print(widget.testId + " " + widget.questionIndex.toString() + ' ' + widget.user.uid);
    if(questions!=null) {
      questions.forEach((question){
        print(question.question);
      });
    }
    return (questions!=null && questions.isNotEmpty) ? StreamProvider<List<AnswerModel>>.value(
      value: DatabaseService(uid: widget.user.uid, deck_Id: widget.test.deckId,
          tstId: widget.test.testId, quId: questions[widget.questionIndex].questionId).answers,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 200,
            child: Container(
              decoration: BoxDecoration(
                color: CustomColors.White,
                borderRadius: BorderRadius.all(Radius.circular(20.0),),
                boxShadow: [
                  BoxShadow(
                    color: CustomColors.LightGrey,
                    offset: Offset(5,5),
                    blurRadius: 10,
                  )
                ],
              ),
              child: Center(
                child: (questions!=null)?Text(questions[widget.questionIndex].question,
                  style: TextStyle(fontSize: 18, fontFamily: 'Poppins'),):Container(),
              ),
            ),
          ),
          SizedBox(height: 10,),
          (questions!=null)? StreamProvider<List<AnswerModel>>.value(
            value: DatabaseService(uid: widget.user.uid, deck_Id: widget.test.deckId,
                tstId: widget.test.testId, quId: questions[widget.questionIndex].questionId).answers,
            child: AnswerWidget(key: globalKey, questionIndex: widget.questionIndex, user: widget.user,
              testId: widget.test.testId, test:widget.test, questionId: questions[widget.questionIndex].questionId,),
          ):Center(),
          show ? SizedBox(height: 20,):SizedBox(),
        ],
      ),
    ):Container(
      child: Center(
        child: Text("No questions", style: TextStyle(color: CustomColors.LightGrey, fontSize: 25),),
      ),
    );
  }
}

class AnswerWidget extends StatefulWidget {
  final int questionIndex;
  final String questionId;
  final UserModel user;
  final String testId;
  final TestModel test;
  final Key key;
  AnswerWidget({this.key, this.questionIndex, this.user, this.testId, this.test, this.questionId});

  @override
  _AnswerWidgetState createState() => _AnswerWidgetState();
}

class _AnswerWidgetState extends State<AnswerWidget> {
  bool _false = false;
  bool show = false;
  @override
  Widget build(BuildContext context) {
    final answers = Provider.of<List<AnswerModel>>(context);
    return (answers!=null) ? Column(
      children: <Widget>[
        (_false && answers.length > 1)? Container(
            child: Column(children: <Widget>[
              Text("false answer, try again", style: TextStyle(color: CustomColors.TrashRed),),
              Icon(Icons.cancel, color: CustomColors.TrashRed,)
            ],)
        ):Container(),
        Container(
          child:(answers.length == 1) ? Container(
            child: InkWell(
              onTap: () {
                setState(() {
                  show = !show;
                });
              },
              child: Column(
                children: <Widget>[
                  (!show)?Text("show Answer", style: TextStyle(color: CustomColors.PurpleDark, fontSize: 15),):Text("hide Answer", style: TextStyle(color: CustomColors.PurpleDark, fontSize: 15)),
                ],
              ),
            ),
          ): Container(),
        ),
        SizedBox(height: 50,),
        (answers.length > 1)? Container(
          color: CustomColors.White,
          child: new ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: answers?.length,
              itemBuilder: (BuildContext context, int index) {
                return new Center(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Checkbox(
                            checkColor: CustomColors.White,
                            value: answers.elementAt(index).checked,
                            onChanged: (bool value) {
                              setState(() {
                                answers.elementAt(index).checked = value;
                              });
                            },
                          ),
                          Flexible(
                            child: Text(answers[index].answer, style: TextStyle(fontSize: 16, fontFamily: 'Poppins',),),
                          ),
                        ],
                      ),
                      SizedBox(height: 15,),
                    ],
                  ),
                );
              }),
        ):(show)? Container(
          child: Text(answers[0].answer, style: TextStyle(fontSize: 16, fontFamily: 'Poppins',),),
        ):Container(),
      ],
    ):Column();
  }

  bool isCorrect(){
    final answers = Provider.of<List<AnswerModel>>(context, listen:false);
    bool isCorrect = true;
    if(answers == null || answers.isEmpty)
      isCorrect = false;
    else {
      answers.forEach((answer){
        if(answer.checked != answer.correct) {
          isCorrect = false;
        }
      });
    }
    return isCorrect;
  }
}