import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashcards/models/CardUnderstanding.dart';
import 'package:flashcards/models/answer.dart';
import 'package:flashcards/models/card.dart';
import 'package:flashcards/models/deck.dart';
import 'package:flashcards/models/question.dart';
import 'package:flashcards/models/test.dart';
import 'package:flashcards/models/user.dart';
import 'package:flashcards/screens/home/addCardPage.dart';
import 'package:flashcards/screens/home/addTest.dart';
import 'package:flashcards/services/database.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddDeck extends StatefulWidget {
  final User user;
  final bool edit;
  final Deck deck;
  const AddDeck({this.user, this.edit, this.deck});

  @override
  _AddDeckState createState() => _AddDeckState();
}
class _AddDeckState extends State<AddDeck> {
  List<String> decks;
  List<Test> tests = new List();
  List<Question> questions = new List();
  List<Answer> answers = new List();
  List<CardModel> cards = new List();
  String dropDownValue;
  TextEditingController deckTitleEditingController = TextEditingController();
  TextEditingController desTitleEditingController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    deckTitleEditingController.dispose();
    desTitleEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if(widget.edit) {
      deckTitleEditingController.text = widget.deck.title;
      desTitleEditingController.text = widget.deck.descritpion;
    }

    return Scaffold(
        backgroundColor: CustomColors.black,
        appBar: AppBar(
          title: widget.edit? Text('Edit Deck'): Text('Add Deck'),
          actions: <Widget>[
            FlatButton(
              onPressed: addDeck,
              child: Row(
                children: <Widget>[
                  Text("Done", style: TextStyle(color: CustomColors.PurpleDark, fontSize: 18),),
                  Icon(Icons.done, color: CustomColors.PurpleDark,),
                ],
              ),
            ),
          ],
          backgroundColor: CustomColors.black,
        ),
        body: SingleChildScrollView(
          child: Container(
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
              padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
              decoration: BoxDecoration(color: CustomColors.White,
                borderRadius: BorderRadius.only(
                  bottomLeft: const Radius.circular(20.0),
                  bottomRight: const Radius.circular(20.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    child: TextField(
                      controller: deckTitleEditingController,
                      decoration: InputDecoration(
                        labelText: 'Enter a deck title',
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: CustomColors.DeepBlue, width: 1.5),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    child: TextField(
                      controller: desTitleEditingController,
                      decoration: InputDecoration(
                        labelText: 'Enter a deck description',
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: CustomColors.DeepBlue, width: 2.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                  ),
                  !widget.edit ? InkWell(
                    onTap: addCard,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 100),
                      decoration: const BoxDecoration(
                        color: CustomColors.White,
                        borderRadius: BorderRadius.all(Radius.circular(50.0),),
                        boxShadow: [
                          BoxShadow(
                            color: CustomColors.LightGrey,
                            offset: Offset(5,5),
                            blurRadius: 15,
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.add_circle, color: CustomColors.black,),
                          Text("add a card"),
                        ],
                      ),
                    ),
                  ): Container(),
                  !widget.edit ? Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ):Container(),
                  !widget.edit ? InkWell(
                    onTap: addTest,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 100),
                      decoration: const BoxDecoration(
                        color: CustomColors.White,
                        borderRadius: BorderRadius.all(Radius.circular(50.0),),
                        boxShadow: [
                          BoxShadow(
                            color: CustomColors.LightGrey,
                            offset: Offset(5,5),
                            blurRadius: 15,
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.add_circle, color: CustomColors.black,),
                          Text("add a test"),
                        ],
                      ),
                    ),
                  ): Container(),
                  !widget.edit ?Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                  ):Container(),
                ],
              ), //bottomNavigationBar: BottomNavBar(),
            ),
          ),
        )
    );
  }

  // store the deck and the belonging cards and tests
  void addDeck() {
    if(deckTitleEditingController.text.trim().isNotEmpty){
      if(!widget.edit){
        DatabaseService(uid: widget.user.uid).addDeckToFireStore(deckTitleEditingController.text, 0, 0, 0.0, null, false).then((e){
          String id = e.documentID;
          cards.forEach((card){
            DatabaseService(uid: widget.user.uid).addCard(/*cardId, */id,
                card.title, card.front, card.back, card.isHidden, card.cardUnderstanding);
          });
          tests.forEach((test) {
            DatabaseService(uid: widget.user.uid).addTestToFireStore(
                id, test.title, test.completion, test.isHidden,
                test.rating).then((e){
              String testId = e.documentID;
              if (questions.isNotEmpty) {
                questions.forEach((question) {
                  DatabaseService(uid: widget.user.uid).addQuestionToFireStore(
                      testId, id, question.question, question.answer,
                      question.isHidden, question.rating).then((e){
                    String questionId = e.documentID;
                    if (answers.isNotEmpty) {
                      answers.forEach((answer) {
                        print(answer.answer + " " + answer.answerId + " " +
                            questionId + " " + testId);
                        DatabaseService(uid: widget.user.uid).addAnswerToFireStore(
                            questionId, testId, id,
                            answer.answer, answer.checked, answer.correct);
                      });
                    }
                  });
                });
              }
            });
          });
          Navigator.pop(context);
        });
      }
      else{
        DatabaseService(uid: widget.user.uid).updateDeck(widget.deck.deckId, deckTitleEditingController.text, desTitleEditingController.text);
      }
    } else {
      print("Bitte deck title angeben"); //TODO add error
    }
  }

  void addCard() {
    if(deckTitleEditingController.text.trim().isNotEmpty ) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
          AddCardPage(
            edit: false,
            onAddCard: (CardModel card){
              cards.add(card);
            },
            deckTitle:deckTitleEditingController.text,
            deckIsGiven: true,
            user: widget.user,)));
    }
  }

  void addTest() {
    if(deckTitleEditingController.text.trim().isNotEmpty) {
      if(deckTitleEditingController.text.trim().isNotEmpty) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
            AddTest(
              edit: false,
              onAddTest: (Test test, List<Question> questions, List<Answer> answers){
                tests.add(test);
                questions.forEach((question){
                  this.questions.add(question);
                });
                answers.forEach((answer){
                  this.answers.add(answer);
                });
              },
              deckTitle:deckTitleEditingController.text,
              deckIsGiven: true,
              user: widget.user,)));
      }
    }
  }
}