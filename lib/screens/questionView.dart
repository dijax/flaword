import 'package:flashcards/models/TestModel.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flutter/material.dart';

class QuestionView extends StatefulWidget {
  final TestModel test;
  final int quIndex;
  final int testIndex;
  QuestionView(this.test, this.quIndex, this.testIndex);
  _QuestionViewState createState() => _QuestionViewState();
}
class _QuestionViewState extends State<QuestionView> {
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
        padding: EdgeInsets.all(20),
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
                  child: Text(widget.test?.questions?.elementAt(widget.quIndex)?.question, style: TextStyle(fontSize: 18, fontFamily: 'Poppins'),),
                ),
              ),
            ),
            SizedBox(height: 40,),
            Container(
              color: CustomColors.White,
              child: new ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: widget.test?.questions?.elementAt(widget.quIndex)?.answers?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new InkWell(
                      child: Center(
//                            padding: EdgeInsets.all(4.0),
//                            height: 50,
//                            width: 430,
//                            decoration: BoxDecoration(
//                                color: CustomColors.White,
//                                border: Border.all(color: CustomColors.LightGrey),
//                                borderRadius: BorderRadius.circular(5.0),
//                                boxShadow: [
//                                  BoxShadow(
//                                    color: CustomColors.LightGrey,
//                                    offset: Offset(5,5),
//                                    blurRadius: 2,
//                                  ),
//                                ]
//                            ),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Checkbox(
                                  checkColor: CustomColors.PurpleLight,
                                  value: false,
//                                  onChanged: (){},
                                ),
                                Flexible(
                                  child: Text(widget.test?.questions?.elementAt(widget.quIndex)?.answers?.elementAt(index)?.answer, style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),),
                                ),
                              ],
                            ),
                            SizedBox(height: 15,),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(height: 20,),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        color: CustomColors.PurpleLight,
                        onPressed: (){},
                      ),
                      Text("last question", style: TextStyle(color: CustomColors.PurpleLight),),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("Next question", style: TextStyle(color: CustomColors.PurpleLight),),
                      IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        color: CustomColors.PurpleLight,
                        onPressed: (){},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}