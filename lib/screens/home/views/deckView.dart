import 'package:flashcards/models/cardModel.dart';
import 'package:flashcards/models/testModel.dart';
import 'package:flashcards/models/userModel.dart';
import 'package:flashcards/services/database.dart';
import 'package:flashcards/screens/home/views/cardView.dart';
import 'package:flashcards/screens/home/views/questionView.dart';
import 'package:flashcards/screens/home/views/testView.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flashcards/screens/home/widgets/settingsMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class DeckView extends StatefulWidget {
  final String deckId;
  final String deckTitle;
  final DateTime visitDate;
  final UserModel user;
  DeckView({this.deckId, this.deckTitle, this.visitDate, this.user});
  _DeckViewState createState() => _DeckViewState();
}

class _DeckViewState extends State<DeckView> {
  bool testsClicked = false;
  bool testClicked = false;
  bool flashcardClicked = false;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<CardModel>>.value(value: DatabaseService(uid: widget.user.uid, deck_Id: widget.deckId).cards),
        StreamProvider<List<TestModel>>.value(value: DatabaseService(uid: widget.user.uid, deck_Id: widget.deckId).tests),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.deckTitle),
          backgroundColor: CustomColors.black,
        ),
        backgroundColor: CustomColors.White,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
          child: Center(
            child: Column(
              children: <Widget>[
                StreamProvider<UserModel>.value(
                  value: DatabaseService(uid: widget.user.uid, deck_Id: widget.deckId).username,
                  child: CardsList(user: widget.user, deckId: widget.deckId),
                ),
                SizedBox(
                  height: 20,
                ),
                StreamProvider<UserModel>.value(
                  value: DatabaseService(uid: widget.user.uid, deck_Id: widget.deckId).username,
                  child: TestsList(user: widget.user, deckId: widget.deckId),
                ),
                SizedBox(height: 20.0,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CardsList extends StatefulWidget {
  final UserModel user;
  final String deckId;
  CardsList({this.user, this.deckId});

  @override
  _CardsListState createState() => _CardsListState();
}

class _CardsListState extends State<CardsList> {
  bool _flashcardClicked = false;
  @override
  Widget build(BuildContext context) {
    final cards = Provider.of<List<CardModel>>(context);
    return (cards != null) ? Column(
      children: <Widget>[
        InkWell(
          onTap: () {setState(() {
            _flashcardClicked = !_flashcardClicked;
          });},
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // TODO add statistics (progressbar) und settings menu
                    Text("Flashcards", style: TextStyle(fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.bold),),
                    IconButton(
                      icon: Icon(Icons.play_arrow, size: 40,),
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CardView(cards: cards, cardIndex: null, user: widget.user,)));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        _flashcardClicked? Container(
          color: CustomColors.White,
          child: new ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: cards.length,
              itemBuilder: (BuildContext context, int cardIndex) {
                return (!cards.elementAt(cardIndex).isHidden) ? Container(child: GestureDetector(
                  onTap: () {
                    setState(() {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                          CardView(cards: cards, cardIndex: cardIndex, user: widget.user,)));
                    });
                  },
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      height: 70,
                      width: 300,
                      decoration: BoxDecoration(
                          color: CustomColors.black,
                          border: Border.all(color: CustomColors.LightGrey),
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: CustomColors.LightGrey,
                              offset: Offset(5,5),
                              blurRadius: 2,
                            ),
                          ]
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(cards[cardIndex].title, style: TextStyle(
                                color: CustomColors.White, fontSize: 20,
                                fontFamily: 'Poppins', fontWeight: FontWeight.bold),),
                            SettingsMenu(
                              user: widget.user,
                              list: cards[cardIndex],
                              onSelect: (dynamic card, bool isHidden) {
                                setState(() {
//                            if(hidden){cards[cardIndex].hidden = true;}
//                            cards = newCards;
                                });
                              },
                              index: cardIndex,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                ):Container();
              }),
        ):Container(), ],) : Container();
  }
}

class TestsList extends StatefulWidget {
  final UserModel user;
  final String deckId;
  TestsList({this.user, this.deckId});

  @override
  _TestsListState createState() => _TestsListState();
}

class _TestsListState extends State<TestsList> {
  bool _testsClicked = false;
  @override
  Widget build(BuildContext context) {
    final tests = Provider.of<List<TestModel>>(context);
    return (tests != null) ? Column(
        children: <Widget>[
          InkWell(
            onTap: (){setState(() {
              _testsClicked = !_testsClicked;
            });},
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
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
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // TODO: add number of tests and progressbar and settings menu
                      Text("Tests", style: TextStyle(fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  ),
                ],
              ),
            ),
          ),
          _testsClicked ? Container(
            color: CustomColors.White,
            child: new ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: tests.length,
                itemBuilder: (BuildContext context, int testIndex) {
                  return !tests.elementAt(testIndex).isHidden ? Container(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => TestView(tests, testIndex)));
                      },
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.all(4.0),
                          height: 70,
                          width: 300,
                          decoration: BoxDecoration(
                              color: CustomColors.black,
                              border: Border.all(color: CustomColors.LightGrey),
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                BoxShadow(
                                  color: CustomColors.LightGrey,
                                  offset: Offset(5,5),
                                  blurRadius: 2,
                                ),
                              ]
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(15, 0, 15,5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Center(
                                  child: Text(tests?.elementAt(testIndex)?.title, style: TextStyle(color: CustomColors.White, fontSize: 17, fontFamily: 'Poppins', fontWeight: FontWeight.bold),),
                                ),
                                IconButton(
                                  icon: Icon(Icons.play_arrow, size: 30, color: CustomColors.White, ),
                                  onPressed: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => QuestionView(test: tests.elementAt(testIndex), quIndex: 0, testIndex: testIndex, user: widget.user,)));},
                                ),
                                SettingsMenu(
                                  user: widget.user,
                                  list: tests[testIndex],
                                  onSelect: (dynamic test, bool hidden) {
                                    setState(() {
//                                    if(hidden){tests.elementAt(testIndex).isHidden = true;}
//                                    tests = newTests;
                                    });
                                  },
                                  index: testIndex,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ): Container();
                }),
          ):Container()
        ]
    ):Container();
  }
}