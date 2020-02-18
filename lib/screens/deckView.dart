import 'package:flashcards/Test/mockData.dart';
import 'package:flashcards/models/CardModel.dart';
import 'package:flashcards/models/TestModel.dart';
import 'package:flashcards/screens/cardView.dart';
import 'package:flashcards/screens/testView.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flutter/material.dart';

class DeckView extends StatefulWidget {
  final int index;
  DeckView(this.index);
  _DeckViewState createState() => _DeckViewState();
}
class _DeckViewState extends State<DeckView> {
  bool testsClicked = false;
  bool testClicked = false;
  bool flashcardClicked = false;
  @override
  Widget build(BuildContext context) {
    List<TestModel> tests = MockData.getDecksList().elementAt(widget.index).tests;
    List<CardModel> cards = MockData.getDecksList().elementAt(widget.index).cards;
    return Scaffold(
      appBar: AppBar(
        title: Text(_getDeckTitle(widget.index)),
        backgroundColor: CustomColors.DeepBlue,
      ),
      backgroundColor: CustomColors.White,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () {setState(() {
                    flashcardClicked = !flashcardClicked;
                  });},
                  child: Container(
//                width: 300,
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
                          padding: EdgeInsets.symmetric(vertical: 4),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Flashcards", style: TextStyle(fontFamily: 'Monsterrat', fontSize: 20, fontWeight: FontWeight.bold),),
                            IconButton(
                              icon: Icon(Icons.play_arrow, size: 40,),
                              onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => CardView(widget.index)));},
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                flashcardClicked? Container(
                  color: CustomColors.White,
                  child: new ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: cards.length,
                      itemBuilder: (BuildContext context, int index) {
                        return new InkWell(
                          child: Center(
                            child: Card(
                              child: Container(
                                padding: EdgeInsets.all(4.0),
                                height: 50,
                                width: 430,
                                decoration: BoxDecoration(
                                    color: CustomColors.White,
                                    border: Border.all(color: CustomColors.LightGrey),
                                    borderRadius: BorderRadius.circular(5.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: CustomColors.LightGrey,
                                        offset: Offset(5,5),
                                        blurRadius: 2,
                                      ),
                                    ]
                                ),
                                child: Text(cards.elementAt(index).cardTitle, style: TextStyle(fontSize: 20, fontFamily: 'Monsterrat'),),
                              ),
//                              width: 200,
//                              height: 50,
//                              decoration: BoxDecoration(
//                                boxShadow: [
//                                  BoxShadow(
//                                    color: CustomColors.LightGrey,
//                                    offset: Offset(5,5),
//                                    blurRadius: 2,
//                                  ),
//                                ],
//                              ),
//
                            ),
                          ),
                        );
                      }),
                ):Container(),
                SizedBox(height: 20.0,),
                InkWell(
                  onTap: (){setState(() {
                    testsClicked = !testsClicked;
                  });},
                  child: Container(
//                width: 300,
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
                          padding: EdgeInsets.symmetric(vertical: 4),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Tests", style: TextStyle(fontFamily: 'Monsterrat', fontSize: 20, fontWeight: FontWeight.bold),),
                            IconButton(
                              icon: Icon(Icons.play_arrow, size: 40,),
                              onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => TestView(widget.index)));},
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                testsClicked ? Container(
                  color: CustomColors.White,
                  child: new ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: tests.length,
                      itemBuilder: (BuildContext context, int testIndex) {
                        return new InkWell(
                          onTap: () {setState(() {
                            testClicked = !testClicked;
                          });},
                          child: Center(
                            child: Card(
                              child: Container(
                                padding: EdgeInsets.all(4.0),
                                height: 50,
                                width: 430,
                                decoration: BoxDecoration(
                                    color: CustomColors.White,
                                    border: Border.all(color: CustomColors.LightGrey),
                                    borderRadius: BorderRadius.circular(5.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: CustomColors.LightGrey,
                                        offset: Offset(5,5),
                                        blurRadius: 2,
                                      ),
                                    ]
                                ),

                                  child: Column(children: <Widget>[
                                    Text(tests.elementAt(testIndex).testTitle, style: TextStyle(fontSize: 20, fontFamily: 'Monsterrat'),),
                                    testClicked ? Container(
                                      color: CustomColors.White,
                                      child: new ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount: cards.length,
                                          itemBuilder: (BuildContext context, int queIndex) {
                                            return new InkWell(
                                              child: Center(
                                                child: Card(
                                                  child: Container(
                                                    padding: EdgeInsets.all(4.0),
                                                    height: 50,
                                                    width: 430,
                                                    decoration: BoxDecoration(
                                                        color: CustomColors.White,
                                                        border: Border.all(color: CustomColors.LightGrey),
                                                        borderRadius: BorderRadius.circular(5.0),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: CustomColors.LightGrey,
                                                            offset: Offset(5,5),
                                                            blurRadius: 2,
                                                          ),
                                                        ]
                                                    ),
                                                    child: Text(tests.elementAt(testIndex).questions.elementAt(queIndex).question, style: TextStyle(fontSize: 20, fontFamily: 'Monsterrat'),),
                                                  ),
//                              width: 200,
//                              height: 50,
//                              decoration: BoxDecoration(
//                                boxShadow: [
//                                  BoxShadow(
//                                    color: CustomColors.LightGrey,
//                                    offset: Offset(5,5),
//                                    blurRadius: 2,
//                                  ),
//                                ],
//                              ),
//
                                                ),
                                              ),
                                            );
                                          }),
                                    ):Container(),
                                  ],),

                              ),
//                              width: 200,
//                              height: 50,
//                              decoration: BoxDecoration(
//                                boxShadow: [
//                                  BoxShadow(
//                                    color: CustomColors.LightGrey,
//                                    offset: Offset(5,5),
//                                    blurRadius: 2,
//                                  ),
//                                ],
//                              ),
//
                            ),
                          ),
                        );
                      }),
                ):Container(),
              ],
            ),
          ),
        ),
      ),
      //bottomNavigationBar: BottomNavBar(),
    );
  }
}

String _getDeckTitle(int index) {
  return MockData.decksList.elementAt(index).deckTitle;
}