import 'package:flashcards/Test/mockData.dart';
import 'package:flashcards/models/TestModel.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class TestView extends StatefulWidget {
  final int deckIndex;
  final int testIndex;
  TestView(this.deckIndex, this.testIndex);
  _TestViewState createState() => _TestViewState();
}
class _TestViewState extends State<TestView> {
//  int _counter = 0;
//  int _counter2 = 0;
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  List<TestModel> tests;

  @override
  Widget build(BuildContext context) {
    tests = MockData.getDecksList()?.elementAt(widget.deckIndex)?.tests;
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text(tests?.elementAt(widget.testIndex)?.testTitle),
          backgroundColor: CustomColors.DeepBlue,
        ),
        backgroundColor: CustomColors.White,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                color: CustomColors.White,
                child: new ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: tests?.elementAt(widget.testIndex)?.questions?.length,
                    itemBuilder: (BuildContext context, int quIndex) {
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
                              child: Text(tests?.elementAt(widget.testIndex)?.questions?.elementAt(quIndex)?.question, style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
    );
  }
}
