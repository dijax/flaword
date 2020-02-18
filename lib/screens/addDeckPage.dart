import 'package:flashcards/screens/AddTestPage.dart';
import 'package:flashcards/screens/addCardPage.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flutter/material.dart';
import 'package:flashcards/Test/mockData.dart';

class AddDeckPage extends StatefulWidget {
  _AddDeckPageState createState() => _AddDeckPageState();
}
class _AddDeckPageState extends State<AddDeckPage> {
  List<String> decks;
  String dropDownValue = MockData.decksList[0].deckTitle;
  TextEditingController deckTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: CustomColors.DeepBlue,
        appBar: AppBar(
          title: Text('Add Deck'),
          backgroundColor: CustomColors.DeepBlue,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Container(
            padding: EdgeInsets.fromLTRB(15, 30, 15, 130),
            decoration: BoxDecoration(color: CustomColors.White),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: deckTitleController,
                  decoration: InputDecoration(
                    labelText: 'Enter a deck title',
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: CustomColors.DeepBlue, width: 1.5),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Enter a deck description',
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: CustomColors.DeepBlue, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                Material(
                  child: InkWell(
                    onTap: () {this.addCard();},

                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 100),
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
                          Icon(Icons.add_circle, color: CustomColors.DeepBlue, size: 30, ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                          ),
                          Text("Add a card", style: TextStyle(fontFamily: 'Monsterrat', fontSize: 20, fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                  ),),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                InkWell(
                  onTap: (){this.addTest();},
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 100),
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
                        Icon(Icons.add_circle, color: CustomColors.DeepBlue, size: 30, ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                        ),
                        Text("Add a test", style: TextStyle(fontFamily: 'Monsterrat', fontSize: 20, fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                ),
                Material(
                  child: InkWell(
                    onTap: () {this.done();},
                    child: Container(
                      width: 120,
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.check_circle, size: 30, color: CustomColors.PurpleLight,),
                            SizedBox(height: 5,),
                            Text(
                              'Done',
                              style: TextStyle(
                                color: CustomColors.PurpleLight,
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
        )
    );
  }

  done() {
    print("new Deck has been added");
    //TODO: Add the deck to the Database
  }

  addTest() {
    print("I wanna add a test");
    if(deckTitleController.text.isNotEmpty) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddTestPage(deckTitleController.text, true)));
      print(deckTitleController.text);
    }
    else Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddTestPage(null, false)));
  }

  addCard() {
    print("I wanna add a card");
    if(deckTitleController.text.isNotEmpty) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddCardPage(deckTitleController.text, true)));
      print(deckTitleController.text);
    }
    else Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddCardPage(null, false)));
  }
}