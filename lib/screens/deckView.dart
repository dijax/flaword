import 'package:flashcards/Test/mockData.dart';
import 'package:flashcards/models/CardModel.dart';
import 'package:flashcards/models/TestModel.dart';
import 'package:flashcards/screens/cardView.dart';
import 'package:flashcards/screens/questionView.dart';
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
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
        child: Center(
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: () {setState(() {
                  flashcardClicked = !flashcardClicked;
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
                            onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => CardView(widget.index)));},
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
              flashcardClicked? Container(
                color: CustomColors.White,
                child: new ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: cards.length,
                    itemBuilder: (BuildContext context, int index) {
                      return new InkWell(
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.all(20.0),
                            height: 70,
                            width: 300,
                            decoration: BoxDecoration(
                                color: CustomColors.DeepBlue,
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
                              child: Text(cards.elementAt(index).cardTitle, style: TextStyle(color: CustomColors.White, fontSize: 20, fontFamily: 'Poppins', fontWeight: FontWeight.bold),),
                            ),
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
                          // TODO: add number of tests and progressbar and settings menu
                          Text("Tests", style: TextStyle(fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.bold),),
                          IconButton(
                            icon: Icon(Icons.play_arrow, size: 40,),
                              onPressed: (){
                              },
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
              testsClicked ? Container(
                color: CustomColors.White,
                child: new ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: tests.length,
                    itemBuilder: (BuildContext context, int testIndex) {
                      return new InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => TestView(widget.index, testIndex)));
                        },
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.all(4.0),
                            height: 70,
                            width: 300,
                            decoration: BoxDecoration(
                                color: CustomColors.DeepBlue,
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
                                  child: Text(tests?.elementAt(testIndex)?.testTitle, style: TextStyle(color: CustomColors.White, fontSize: 17, fontFamily: 'Poppins', fontWeight: FontWeight.bold),),
                                ),
                                IconButton(
                                  icon: Icon(Icons.play_arrow, size: 30, ),
                                  onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => QuestionView(tests.elementAt(testIndex), 0, testIndex)));},
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ):Container(),
              SizedBox(height: 20.0,),
            ],
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