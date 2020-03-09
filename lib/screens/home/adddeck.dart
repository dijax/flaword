import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashcards/models/CardUnderstanding.dart';
import 'package:flashcards/models/user.dart';
import 'package:flashcards/screens/home/addCardPage.dart';
import 'package:flashcards/screens/home/addTest.dart';
import 'package:flashcards/services/database.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flashcards/Test/mockData.dart';

class AddDeck extends StatefulWidget {
  final User user;
  const AddDeck({this.user});

  @override
  _AddDeckState createState() => _AddDeckState();
}
class _AddDeckState extends State<AddDeck> {
  List<String> decks;
  String dropDownValue;
  TextEditingController deckTitleEditingController = TextEditingController();
  TextEditingController desTitleEditingController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    deckTitleEditingController.dispose();
    desTitleEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    if(widget.deckIsGiven){
//      dropDownValue = widget.deck;
//    } else{
//      dropDownValue = MockData.decksList[0].deckTitle;
//    }
    return Scaffold(
        backgroundColor: CustomColors.black,
        appBar: AppBar(
          title: Text('Add Deck'),
          actions: <Widget>[
            FlatButton(
              onPressed: addDeck,
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
              padding: EdgeInsets.fromLTRB(15, 10, 15, 160),
              decoration: BoxDecoration(color: CustomColors.White,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    child: TextField(
                      controller: deckTitleEditingController,
                      decoration: InputDecoration(
                        labelText: 'Enter a deck title',
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: CustomColors.DeepBlue, width: 1.5),
                          borderRadius: BorderRadius.circular(25.0),
                        ),),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    child: TextField(
                      controller: desTitleEditingController,
                      decoration: InputDecoration(
                        labelText: 'Enter a deck description',
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: CustomColors.DeepBlue, width: 2.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                  ),
                  InkWell(
                    onTap: addCard,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 100),
                      decoration: const BoxDecoration(
                        color: CustomColors.White,
                        borderRadius: BorderRadius.all(Radius.circular(50.0),),
                        boxShadow: [
                          BoxShadow(
                            color: CustomColors.LightGrey,
                            offset: Offset(5,5),
                            blurRadius: 15,
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.add_circle, color: CustomColors.black,),
                          Text("add a card"),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  InkWell(
                    onTap: addTest,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 100),
                      decoration: const BoxDecoration(
                        color: CustomColors.White,
                        borderRadius: BorderRadius.all(Radius.circular(50.0),),
                        boxShadow: [
                          BoxShadow(
                            color: CustomColors.LightGrey,
                            offset: Offset(5,5),
                            blurRadius: 15,
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.add_circle, color: CustomColors.black,),
                          Text("add a test"),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                  ),
//                  Material(
//                    child: InkWell(
//                      onTap: addDeck, // TODO: add Card either for a chosen deck or a new one
//                      child: Container(
//                        width: 150,
//                        child: Center(
//                          child: Column(
//                            children: <Widget>[
//                              Icon(Icons.check_circle, size: 30, color: CustomColors.PurpleDark,),
//                              SizedBox(height: 5,),
//                              Text(
//                                'Done',
//                                style: TextStyle(
//                                  color: CustomColors.PurpleDark,
//                                  fontSize: 20,
//                                  fontFamily: 'Poppins',
//                                  fontWeight: FontWeight.w500,
//                                ),
//                              ),
//                            ],
//                          ),
//                        ),
//                      ),
//                    ),
//                  ),
                ],
              ), //bottomNavigationBar: BottomNavBar(),
            ),
          ),
        )
    );
  }

  getDecks() {
    decks = new List();
//    if(widget.deckIsGiven){
//      decks.add(widget.deck);
//    }
//    else MockData.decksList.forEach((element) => decks.add(element.deckTitle));
    return decks;
  }

  void addDeck() {
    print("Deck added");
    DatabaseService(uid: widget.user.uid).addDeck(deckTitleEditingController.text, 0, 0, 0.0, null, false);
    Navigator.pop(context);
  }

  void addCard() {
    addDeck();
    print("add card");
    CollectionReference colRef = DatabaseService().deckCollection.document(widget.user.uid).collection("decks");
    String deckId = "";

    if(colRef.getDocuments() != null) {
      colRef.getDocuments().then((doc) {
        deckId = "deck${doc.documents.length + 1}";
        print("deckId: " + deckId);
        if(deckTitleEditingController.text.trim().isNotEmpty && deckId.trim().isNotEmpty) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
              AddCardPage(
                deckId: deckId,
                deckTitle:deckTitleEditingController.text,
                deckIsGiven: true,
                user: widget.user,)));
        }
      });
    }
    // TODO else show error
  }

  void addTest() {
    print("add test");
    if(deckTitleEditingController.text.trim().isNotEmpty)
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddTest(deckTitle:deckTitleEditingController.text, deckIsGiven: true, user: widget.user,)));
  }
}