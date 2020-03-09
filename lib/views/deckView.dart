import 'package:flashcards/Test/mockData.dart';
import 'package:flashcards/models/DeckModel.dart';
import 'package:flashcards/models/TestModel.dart';
import 'package:flashcards/models/card.dart';
import 'package:flashcards/models/deck.dart';
import 'package:flashcards/models/user.dart';
import 'package:flashcards/services/database.dart';
import 'package:flashcards/views/cardView.dart';
import 'package:flashcards/views/questionView.dart';
import 'package:flashcards/views/testView.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flashcards/widgets/settingsMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class DeckView extends StatefulWidget {
  final String deckId;
  final String deckTitle;
  final DateTime visitDate;
  final User user;
  DeckView({this.deckId, this.deckTitle, this.visitDate, this.user});
  _DeckViewState createState() => _DeckViewState();
}

class _DeckViewState extends State<DeckView> {
  bool testsClicked = false;
  bool testClicked = false;
  bool flashcardClicked = false;
  @override
  Widget build(BuildContext context) {
//    List<TestModel> tests = widget.deck.tests;
//    List<TestModel> tests = new List();
//    List<CardModel> cards = widget.deck.cards;
//    List<CardModel> cards = new List();
    return StreamProvider<List<CardModel>>.value(
      value: DatabaseService(uid: widget.user.uid, deck_Id: widget.deckId).cards,
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
                CardsList(user: widget.user, deckId: widget.deckId),
//                InkWell(
//                  onTap: () {setState(() {
//                    flashcardClicked = !flashcardClicked;
//                  });},
//                  child: Container(
//                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
//                    decoration: BoxDecoration(
//                      color: CustomColors.White,
//                      boxShadow: [
//                        BoxShadow(
//                          color: CustomColors.LightGrey,
//                          offset: Offset(5,5),
//                          blurRadius: 15,
//                        )
//                      ],
//                    ),
//                    child: Column(
//                      children: <Widget>[
//                        Padding(
//                          padding: EdgeInsets.symmetric(vertical: 5),
//                        ),
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          children: <Widget>[
//                            // TODO add statistics (progressbar) und settings menu
//                            Text("Flashcards", style: TextStyle(fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.bold),),
//                            IconButton(
//                              icon: Icon(Icons.play_arrow, size: 40,),
//                              onPressed: (){
//
//                              },
////                            onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => CardView(widget.deck.cards, null)));},
//                            ),
//                          ],
//                        ),
//                        Padding(
//                          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
//                        ),
//                      ],
//                    ),
//                  ),
//                ),
////                flashcardClicked? Container(
////                  color: CustomColors.White,
////                  child: new ListView.builder(
////                      physics: const NeverScrollableScrollPhysics(),
////                      shrinkWrap: true,
////                      itemCount: cards.length,
////                      itemBuilder: (BuildContext context, int cardIndex) {
////                        return (!cards.elementAt(cardIndex).hidden) ? Container(child: GestureDetector(
////                          onTap: () {
////                            setState(() {
//////                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => CardView(widget.deck.cards, cardIndex)));
////                            });
////                          },
////                          child: Center(
////                            child: Container(
////                              padding: EdgeInsets.all(20.0),
////                              height: 70,
////                              width: 300,
////                              decoration: BoxDecoration(
////                                  color: CustomColors.black,
////                                  border: Border.all(color: CustomColors.LightGrey),
////                                  borderRadius: BorderRadius.circular(20.0),
////                                  boxShadow: [
////                                    BoxShadow(
////                                      color: CustomColors.LightGrey,
////                                      offset: Offset(5,5),
////                                      blurRadius: 2,
////                                    ),
////                                  ]
////                              ),
////                              child: Row(
////                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
////                                children: <Widget>[
////                                  Center(
////                                    child: Text(cards.elementAt(cardIndex).cardTitle, style: TextStyle(color: CustomColors.White, fontSize: 20, fontFamily: 'Poppins', fontWeight: FontWeight.bold),),
////                                  ),
////                                  SettingsMenu(
////                                    user: widget.user,
////                                    list: cards,
////                                    onSelect: (List<Object> newCards, bool hidden) {
////                                      setState(() {
////                                        if(hidden){cards.elementAt(cardIndex).hidden = true;}
////                                        cards = newCards;
////                                      });
////                                    },
////                                    index: cardIndex,
////                                  ),
////                                ],
////                              ),
////                            ),
////                          ),
////                        ),): Container();
////                      }),
////                ):Container(),
//                flashcardClicked? CardsList(user: widget.user, deckId: widget.deckId):Container(),
                SizedBox(height: 20.0,),
                InkWell(
                  onTap: (){setState(() {
                    testsClicked = !testsClicked;
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
//                          IconButton(
//                            icon: Icon(Icons.play_arrow, size: 40,),
//                              onPressed: (){
//                              },
//                          ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        ),
                      ],
                    ),
                  ),
                ),
//                testsClicked ? Container(
//                  color: CustomColors.White,
//                  child: new ListView.builder(
//                      physics: const NeverScrollableScrollPhysics(),
//                      shrinkWrap: true,
//                      itemCount: tests.length,
//                      itemBuilder: (BuildContext context, int testIndex) {
//                        return !tests.elementAt(testIndex).isHidden ? Container(
//                          child: InkWell(
//                            onTap: () {
//                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => TestView(tests, testIndex)));
//                            },
//                            child: Center(
//                              child: Container(
//                                padding: EdgeInsets.all(4.0),
//                                height: 70,
//                                width: 300,
//                                decoration: BoxDecoration(
//                                    color: CustomColors.black,
//                                    border: Border.all(color: CustomColors.LightGrey),
//                                    borderRadius: BorderRadius.circular(20.0),
//                                    boxShadow: [
//                                      BoxShadow(
//                                        color: CustomColors.LightGrey,
//                                        offset: Offset(5,5),
//                                        blurRadius: 2,
//                                      ),
//                                    ]
//                                ),
//                                child: Padding(
//                                  padding: EdgeInsets.fromLTRB(15, 0, 15,5),
//                                  child: Row(
//                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                    children: <Widget>[
//                                      Center(
//                                        child: Text(tests?.elementAt(testIndex)?.testTitle, style: TextStyle(color: CustomColors.White, fontSize: 17, fontFamily: 'Poppins', fontWeight: FontWeight.bold),),
//                                      ),
//                                      IconButton(
//                                        icon: Icon(Icons.play_arrow, size: 30, color: CustomColors.White, ),
//                                        onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => QuestionView(tests.elementAt(testIndex), 0, testIndex)));},
//                                      ),
//                                      SettingsMenu(
//                                        user: widget.user,
//                                        list: tests,
//                                        onSelect: (List<Object> newTests, bool hidden) {
//                                          setState(() {
//                                            if(hidden){tests.elementAt(testIndex).isHidden = true;}
//                                            tests = newTests;
//                                          });
//                                        },
//                                        index: testIndex,
//                                      ),
//                                    ],
//                                  ),
//                                ),
//                              ),
//                            ),
//                          ),
//                        ): Container();
//                      }),
//                ):Container(),
                SizedBox(height: 20.0,),
              ],
            ),
          ),
        ),
        //bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}

class CardsList extends StatefulWidget {
  final User user;
  final String deckId;
  CardsList({this.user, this.deckId});

  @override
  _CardsListState createState() => _CardsListState();
}

class _CardsListState extends State<CardsList> {
  bool _flashcardClicked = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final cards = Provider.of<List<CardModel>>(context);
    if(cards!=null){
      String id = "card"+ (cards.length + 1).toString();
      print("id "+id);
      cards.forEach((card){
        print(card.title);
      });
    }
    return (cards != null) ? Column(
      children: <Widget>[
        InkWell(
          onTap: () {setState(() {
            _flashcardClicked = !_flashcardClicked;
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
                  padding: EdgeInsets.symmetric(vertical: 5),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // TODO add statistics (progressbar) und settings menu
                    Text("Flashcards", style: TextStyle(fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.bold),),
                    IconButton(
                      icon: Icon(Icons.play_arrow, size: 40,),
                      onPressed: (){
                          print("here" + _flashcardClicked.toString());
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => CardView(cards: cards, cardIndex: null, user: widget.user,)));
                      },
//                            onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => CardView(widget.deck.cards, null)));},
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                ),
              ],
            ),
          ),
        ),
        _flashcardClicked?Container(
          color: CustomColors.White,
          child: new ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: cards.length,
            itemBuilder: (BuildContext context, int cardIndex) {
            return (!cards.elementAt(cardIndex).hidden) ? Container(child: GestureDetector(
              onTap: () {
                setState(() {
//                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => CardView(widget.deck.cards, cardIndex)));
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Center(
                        child: Text(cards[cardIndex].title, style: TextStyle(color: CustomColors.White, fontSize: 20, fontFamily: 'Poppins', fontWeight: FontWeight.bold),),
                      ),
                      SettingsMenu(
                        user: widget.user,
                        list: cards,
                        onSelect: (List<Object> newCards, bool hidden) {
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
            ):Container();
          }),
    ):Container(), ],) : Container();
  }
}
