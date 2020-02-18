import 'package:flashcards/Test/mockData.dart';
import 'package:flashcards/models/TestModel.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class TestView extends StatefulWidget {
  final int index;
  TestView(this.index);
  _TestViewState createState() => _TestViewState();
}
class _TestViewState extends State<TestView> {
  int _counter = 0;
  int _counter2 = 0;
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  List<TestModel> tests;

  @override
  Widget build(BuildContext context) {
    tests = MockData.getDecksList().elementAt(widget.index).tests;
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Flashcards"), //TODO: Deck name dynamisch ändern
          backgroundColor: CustomColors.DeepBlue,
        ),
        backgroundColor: CustomColors.White,
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: FlipCard(
                key: cardKey,
                flipOnTouch: false,
                front: SizedBox(
                  height: 300,
                  child: InkWell(
                      onTap: () => cardKey.currentState.toggleCard(),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: CustomColors.White,
                            boxShadow: [
                              BoxShadow(
                                color: CustomColors.LightGrey,
                                offset: Offset(5,5),
                                blurRadius: 15,
                              ),]),
                        child: Center(
                            child: Text(tests.elementAt(widget.index).questions.elementAt(_counter).question),
                            ),
                        ),
                  ),
                ),
                back: SizedBox(
                  height: 300,
                  child: InkWell(
                    onTap: () => cardKey.currentState.toggleCard(),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: CustomColors.White,
                        boxShadow: [
                          BoxShadow(
                            color: CustomColors.LightGrey,
                            offset: Offset(5,5),
                            blurRadius: 15,
                          ),
                        ],
                      ),
                      child: Center(
                          child: Text(tests.elementAt(widget.index).questions.elementAt(_counter).answers.elementAt(_counter2).answer)),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              color: CustomColors.White,
              child: new ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: tests.elementAt(widget.index).questions.elementAt(_counter).answers.length,
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
                            child: Text(tests.elementAt(index).testTitle, style: TextStyle(fontSize: 20, fontFamily: 'Monsterrat'),),
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
            ),
            RaisedButton(
              onPressed: pressed,
            ),
          ],
//
        )
    );
  }

  void pressed() {
    setState(() {
      if(_counter < tests.length-1) {
        _counter++;
        return;
      }
      print("done");
    });
  }
}
