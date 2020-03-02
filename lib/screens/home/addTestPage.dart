import 'package:flashcards/screens/home/addQuestion.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flutter/material.dart';
import 'package:flashcards/Test/mockData.dart';

class AddTestPage extends StatefulWidget {
  final String deck;
  final bool deckIsGiven;

  const AddTestPage(this.deck, this.deckIsGiven);
  _AddTestPageState createState() => _AddTestPageState();
}

class _AddTestPageState extends State<AddTestPage> {
  List<String> _decks;
  int _questionCount = 0;
  String dropDownValue = MockData.decksList[0].deckTitle;
  TextEditingController deckTitleController = TextEditingController();
  List<Widget> _questions;

  @override
  Widget build(BuildContext context) {
    _questions = new List.generate(_questionCount, (int index) => new AddQuestion(
      onDeleteSelected:() {
        print("Delete was pressed");
        List<Widget> _questionsList = _questions;
        _questionsList.removeAt(index);
        setState(() {
          this._questions = _questionsList;
        });
      },
    ));

    return Scaffold(
        backgroundColor: CustomColors.black,
        appBar: AppBar(
          title: Text('Add Test'),
          backgroundColor: CustomColors.black,
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage('assets/graphics/mountain.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.6),
                    BlendMode.dstIn
                ),
              ),

            ),
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 135),
              decoration: BoxDecoration(color: CustomColors.White),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: deckTitleController,
                    decoration: InputDecoration(
                      labelText: 'Enter a test title',
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: CustomColors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Enter a test description',
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: CustomColors.black, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: new BorderRadius.only(
                        topLeft:  const  Radius.circular(10.0),
                        topRight: const  Radius.circular(10.0),),
                      color: Colors.white,
                      border: Border.all(color: CustomColors.black,),
                    ),
                    padding: EdgeInsets.fromLTRB(12,0,12,0),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: dropDownValue,
                      iconSize: 28,
                      elevation: 0,
                      style: TextStyle(
                        color: CustomColors.NearlyBlack,
                        fontSize: 18,
                        backgroundColor: Colors.white,
                      ),
                      onChanged: (String newValue){
                        setState(() {
                          dropDownValue = newValue;
                        });
                      },
                      items: getDecks().map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: TextStyle(color: CustomColors.DeepBlue.withOpacity(0.9), fontWeight: FontWeight.bold),),
                        );
                      }).toList(),
                    ),
                  ),
//                Padding(
//                  padding: EdgeInsets.symmetric(vertical: 12),
//                ),
                  Column(
                    children: <Widget>[
                      //TODO: Add new widget on click
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric
                      (vertical: 10),
                  ),
                  Container(
                    child: new ListView(
                      children: _questions,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    ),
                  ),
                  Material(
                    child: InkWell(
                      onTap: _addNewQuestion,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 100),
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
                            Icon(Icons.add_circle, color: CustomColors.black, size: 30, ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                            ),
                            FittedBox(
                              fit:BoxFit.contain,
                              child: Text("Add a question", style: TextStyle(fontFamily: 'Monsterrat', fontSize: 20, fontWeight: FontWeight.bold, ), textWidthBasis: TextWidthBasis.parent,),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                  ),
                  Material(
                    child: InkWell(
                      onTap: done,
                      child: Container(
                        width: 120,
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.check_circle, size: 30, color: CustomColors.PurpleDark,),
                              SizedBox(height: 5,),
                              Text(
                                'Done',
                                style: TextStyle(
                                  color: CustomColors.PurpleDark,
                                  fontSize: 20,
                                  fontFamily: 'Monsterrat',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ), //bottom// NavigationBar: BottomNavBar(),
            ),
          ),
        )
    );
  }

  done() {
    print("new test has been added");
    //TODO: Add the deck to the Database
  }

  getDecks() {
    _decks = new List();
    if(widget.deckIsGiven){
      _decks.add(widget.deck);
    }
    else MockData.decksList.forEach((element) => _decks.add(element.deckTitle));
    return _decks;
  }

  void _addNewQuestion() {
    setState(() {
      _questionCount = _questionCount + 1;
    });
  }
}