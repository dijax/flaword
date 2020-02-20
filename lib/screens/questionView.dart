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
  bool show = false;
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
            (widget.test.questions.elementAt(widget.quIndex).answers.length > 1)? Container(
              color: CustomColors.White,
              child: new ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: widget.test?.questions?.elementAt(widget.quIndex)?.answers?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new Center(
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
                    );
                  }),
            ):Container(),
            Container(
              child:(widget.test.questions.elementAt(widget.quIndex).answers.length == 1) ? Container(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      show = !show;
                      print("print");
                      print(show);
                    });
                  },
                  child: Column(
                    children: <Widget>[
                      (!show)?Text("show Answer", style: TextStyle(color: CustomColors.PurpleAccent, fontSize: 15),):Text(""),
                    ],
                  ),
                ),
              ): Container(),
            ),
            show ? Center(
                child: Text(widget.test.questions.elementAt(widget.quIndex).answers.elementAt(0).answer,
                  textAlign: TextAlign.center,)):Center(),
            show ? SizedBox(height: 20,):SizedBox(),
            InkWell(
              onTap: () {
                setState(() {
                  show = !show;
                });
              },
              child: show? Text("hide Answer", style: TextStyle(color: CustomColors.PurpleAccent, fontSize: 15)):Text(""),
            ),
            SizedBox(height: 20,),
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
                    color: CustomColors.PurpleAccent,
                    onPressed: (){},
                  ),
                  Text("last question", style: TextStyle(color: CustomColors.PurpleAccent),),
                ],
              ),
              Row(
                children: <Widget>[
                  Text("Next question", style: TextStyle(color: CustomColors.PurpleAccent),),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    color: CustomColors.PurpleAccent,
                    onPressed: (){},
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }
}