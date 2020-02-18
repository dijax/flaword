import 'package:flashcards/utils/customColors.dart';
import 'package:flutter/material.dart';

class AddQuestion extends StatefulWidget {
  final VoidCallback onDeleteSelected;
  const AddQuestion({this.onDeleteSelected});
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  int _answersCount = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> _answers = new List.generate(_answersCount, (int answerIndex) => new Container (
        child: Column(children: <Widget>[
          Padding(padding: EdgeInsets.all(8),),
          TextField(
            cursorWidth: 300,
            decoration: InputDecoration(
              labelText: 'Enter another answer',
//                border: OutlineInputBorder(
//                    borderRadius: const BorderRadius.all(
//                      const Radius.circular(10.0),
//                    )
//                ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: CustomColors.DeepBlue, width: 1.5),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
        ],)));
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: CustomColors.White,
                boxShadow: [
                  BoxShadow(
                    color: CustomColors.LightGrey,
                    offset: Offset(5,5),
                    blurRadius: 15,
                  )
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Enter a question',
//                border: OutlineInputBorder(
//                  borderRadius: const BorderRadius.all(
//                    const Radius.circular(10.0),
//                  )
//                ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: CustomColors.DeepBlue, width: 1.5),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(8),),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Enter an answer',
//                border: OutlineInputBorder(
//                    borderRadius: const BorderRadius.all(
//                      const Radius.circular(10.0),
//                    )
//                ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: CustomColors.DeepBlue, width: 1.5),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  InkWell(
                    onTap: addOtherAnswer,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                          ListView(
                            children: _answers,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                          ),
                          Icon(Icons.add_circle, color: CustomColors.DeepBlue, size: 30, ),
                          FittedBox(
                            fit:BoxFit.contain,
                            child: Text("Add other answers", style: TextStyle(fontFamily: 'Monsterrat', fontSize: 12, fontWeight: FontWeight.bold, ), textWidthBasis: TextWidthBasis.parent,),
                          ),
                          FittedBox(
                            fit:BoxFit.contain,
                            child: Text("(multiple choice question)", style: TextStyle(fontFamily: 'Monsterrat', fontSize: 12, fontWeight: FontWeight.bold, ), textWidthBasis: TextWidthBasis.parent,),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
          ),
          Positioned(
            right: 0.0,
            child: InkWell(
              onTap: widget.onDeleteSelected,
              child: Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 14.0,
                  backgroundColor: CustomColors.White,
                  child: Icon(Icons.delete, color: CustomColors.DeepBlue,),
                ),
              ),
            ),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 20),
    );
  }

  void addOtherAnswer() {
    setState(() {
      _answersCount = _answersCount + 1;
    });
  }

}
