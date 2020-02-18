import 'package:flashcards/models/TestModel.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flutter/material.dart';

class TestView extends StatefulWidget {
  final TestModel test;
  final int quIndex;
  TestView(this.test, this.quIndex);
  _TestViewState createState() => _TestViewState();
}
class _TestViewState extends State<TestView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.test.testTitle),
        backgroundColor: CustomColors.DeepBlue,
      ),
      backgroundColor: CustomColors.White,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 200,
              child: Text(widget.test?.questions?.elementAt(widget.quIndex)?.question),
            ),
            Container(
              color: CustomColors.White,
              child: new ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: widget.test?.questions?.elementAt(widget.quIndex)?.answers?.length,
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
                            child: Text(widget.test?.questions?.elementAt(widget.quIndex)?.answers?.elementAt(index)?.answer, style: TextStyle(fontSize: 20, fontFamily: 'Monsterrat'),),
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