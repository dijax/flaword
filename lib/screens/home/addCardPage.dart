import 'package:flashcards/models/CardUnderstanding.dart';
import 'package:flashcards/models/user.dart';
import 'package:flashcards/services/database.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flashcards/Test/mockData.dart';

class AddCardPage extends StatefulWidget {
  final String deck;
  final bool deckIsGiven;
  final User user;
  const AddCardPage({this.deck, this.deckIsGiven, this.user});

  @override
  _AddCardPageState createState() => _AddCardPageState();
}
class _AddCardPageState extends State<AddCardPage> {
  List<String> decks;
  String dropDownValue;

  @override
  Widget build(BuildContext context) {
    if(widget.deckIsGiven){
      dropDownValue = widget.deck;
    } else{
      dropDownValue = MockData.decksList[0].deckTitle;
    }
    return Scaffold(
      backgroundColor: CustomColors.black,
      appBar: AppBar(
        title: Text('Add Card'),
        actions: <Widget>[
          FlatButton(
            onPressed: addCard,
            child: Row(
              children: <Widget>[
                Text("Done", style: TextStyle(color: CustomColors.PurpleDark, fontSize: 18),),
                Icon(Icons.done, color: CustomColors.PurpleDark,),
              ],
            ),
          ),
        ],
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
            padding: EdgeInsets.fromLTRB(15, 10, 15, 150),
            decoration: BoxDecoration(color: CustomColors.White),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Enter a card title',
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: CustomColors.DeepBlue, width: 1.5),
                        borderRadius: BorderRadius.circular(25.0),
                      ),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Enter a card description',
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: CustomColors.DeepBlue, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: new BorderRadius.only(
                        topLeft:  const  Radius.circular(10.0),
                        topRight: const  Radius.circular(10.0),),
                      color: Colors.white,
                      border: Border.all(color: CustomColors.DeepBlue,),
                    ),
                    padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
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
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'Card front',
                      focusedBorder:OutlineInputBorder(
                        borderSide: const BorderSide(color: CustomColors.DeepBlue, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'Card back',
                      focusedBorder:OutlineInputBorder(
                        borderSide: const BorderSide(color: CustomColors.DeepBlue, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                ),
//                Material(
//                  child: InkWell(
//                    onTap: addCard, // TODO: add Card either for a chosen deck or a new one
//                    child: Container(
//                      width: 150,
//                      child: Center(
//                        child: Column(
//                          children: <Widget>[
//                            Icon(Icons.check_circle, size: 30, color: CustomColors.PurpleDark,),
//                            SizedBox(height: 5,),
//                            Text(
//                              'Done',
//                              style: TextStyle(
//                                color: CustomColors.PurpleDark,
//                                fontSize: 20,
//                                fontFamily: 'Poppins',
//                                fontWeight: FontWeight.w500,
//                              ),
//                            ),
//                          ],
//                        ),
//                      ),
//                    ),
//                  ),
//                ),
              ],
            ), //bottomNavigationBar: BottomNavBar(),
          ),
        ),
      )
    );
  }

  getDecks() {
    decks = new List();
    if(widget.deckIsGiven){
      decks.add(widget.deck);
    }
    else MockData.decksList.forEach((element) => decks.add(element.deckTitle));
    return decks;
  }

  void addCard() {
    print("Card added");
    DatabaseService(uid: widget.user.uid).addCard("deck1","deck1", "front", "back", false, CardUnderstanding.clear.toString());
    Navigator.pop(context);
  }
}