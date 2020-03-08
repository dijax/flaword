//import 'package:flashcards/models/user.dart';
//import 'package:flashcards/screens/home/addTestPage.dart';
//import 'package:flashcards/screens/home/addCardPage.dart';
//import 'package:flashcards/services/database.dart';
//import 'package:flashcards/utils/customColors.dart';
//import 'package:flutter/material.dart';
//import 'package:flashcards/Test/mockData.dart';
//
//class AddDeckPage extends StatefulWidget {
//  final User user;
//  const AddDeckPage({this.user});
//
//  @override
//  _AddDeckPageState createState() => _AddDeckPageState();
//}
//class _AddDeckPageState extends State<AddDeckPage> {
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return FlatButton(child: Text("hi"), onPressed: done(),);
//  }
//
//  done() {
//    print("the button is clicked");
//  }
////  List<String> decks;
////  String dropDownValue = MockData.decksList[0].deckTitle;
////  TextEditingController deckTitleController = TextEditingController();
////
////  @override
////  Widget build(BuildContext context) {
////    // TODO: implement build
////    return Scaffold(
////        backgroundColor: CustomColors.black,
////        appBar: AppBar(
////          title: Text('Add Deck'),
////          backgroundColor: CustomColors.black,
////          actions: <Widget>[
////            Padding(
////              padding: const EdgeInsets.symmetric(horizontal: 8),
////              child: Row(
////                children: <Widget>[
////                  FlatButton(
////                    onPressed: addDeck(),
////                    child: Text("Done",
////                    style: TextStyle(color: CustomColors.PurpleDark, fontSize: 17),)),
//////                  Padding(
//////                    padding: const EdgeInsets.all(0.0),
//////                    child: Icon(Icons.done, color: CustomColors.PurpleDark,),
//////                  ),
////                ],
////              ),
////            ),
////          ],
////        ),
////        body: SingleChildScrollView(
////          child: Container(
////            decoration: BoxDecoration(
////              image: DecorationImage(
////                image: ExactAssetImage('assets/graphics/mountain.jpg'),
////                fit: BoxFit.cover,
////                colorFilter: ColorFilter.mode(
////                    Colors.black.withOpacity(0.6),
////                    BlendMode.dstIn
////                ),
////              ),
////
////            ),
////            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
////            child: Container(
////              padding: EdgeInsets.fromLTRB(15, 10, 15, 30),
////              decoration: BoxDecoration(color: CustomColors.White),
////              child: Column(
////                mainAxisAlignment: MainAxisAlignment.center,
////                children: <Widget>[
////                  TextField(
////                    controller: deckTitleController,
////                    decoration: InputDecoration(
////                      labelText: 'Enter a deck title',
////                      focusedBorder: OutlineInputBorder(
////                        borderSide: const BorderSide(color: CustomColors.DeepBlue, width: 1.5),
////                        borderRadius: BorderRadius.circular(25.0),
////                      ),
////                    ),
////                  ),
////                  Padding(
////                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
////                  ),
////                  TextField(
////                    decoration: InputDecoration(
////                      labelText: 'Enter a deck description',
////                      focusedBorder: OutlineInputBorder(
////                        borderSide: const BorderSide(color: CustomColors.DeepBlue, width: 2.0),
////                        borderRadius: BorderRadius.circular(25.0),
////                      ),
////                    ),
////                  ),
////                  Padding(
////                    padding: EdgeInsets.symmetric(vertical: 12),
////                  ),
////                  Material(
////                    child: InkWell(
////                      onTap: addCard,
////
////                      child: Container(
////                        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 100),
////                        decoration: BoxDecoration(
////                          color: CustomColors.White,
////                          boxShadow: [
////                            BoxShadow(
////                              color: CustomColors.LightGrey,
////                              offset: Offset(5,5),
////                              blurRadius: 15,
////                            )
////                          ],
////                        ),
////                        child: Column(
////                          children: <Widget>[
////                            Icon(Icons.add_circle, color: CustomColors.black, size: 30, ),
////                            Padding(
////                              padding: EdgeInsets.symmetric(vertical: 8),
////                            ),
////                            Text("Add a card", style: TextStyle(fontFamily: 'Monsterrat', fontSize: 20, fontWeight: FontWeight.bold, color: CustomColors.black),),
////                          ],
////                        ),
////                      ),
////                    ),),
////                  Padding(
////                    padding: EdgeInsets.symmetric(vertical: 12),
////                  ),
////                  InkWell(
////                    onTap: addTest,
////                    child: Container(
////                      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 100),
////                      decoration: BoxDecoration(
////                        color: CustomColors.White,
////                        boxShadow: [
////                          BoxShadow(
////                            color: CustomColors.LightGrey,
////                            offset: Offset(5,5),
////                            blurRadius: 15,
////                          )
////                        ],
////                      ),
////                      child: Column(
////                        children: <Widget>[
////                          Icon(Icons.add_circle, color: CustomColors.black, size: 30, ),
////                          Padding(
////                            padding: EdgeInsets.symmetric(vertical: 8),
////                          ),
////                          Text("Add a test", style: TextStyle(fontFamily: 'Monsterrat', fontSize: 20, fontWeight: FontWeight.bold, color: CustomColors.black),),
////                        ],
////                      ),
////                    ),
////                  ),
////                  Padding(
////                    padding: EdgeInsets.symmetric(vertical: 20),
////                  ),
////                    Container(
////                      child: Container(
////                        width: 120,
////                        child: Center(
////                          child: Column(
////                            children: <Widget>[
//////                              IconButton(
//////                                onPressed: addDeck(),
//////                                icon: Icon(Icons.check_circle,size: 30, color: CustomColors.PurpleDark,),
//////                              ),
////                              FlatButton(
////                                child: Text('Done', style: TextStyle(
////                                  color: CustomColors.PurpleDark,
////                                  fontSize: 20,
////                                  fontFamily: 'Monsterrat',
////                                  fontWeight: FontWeight.w500,
////                                ),),
////                                onPressed: addDeck(),
////                              ),
////                            ],
////                          ),
////                        ),
////                      ),
////                    ),
////                ],
////              ), //bottom// NavigationBar: BottomNavBar(),
////            ),
////          ),
////        )
////    );
////  }
////
////  addDeck() {
////    if(deckTitleController.text.isNotEmpty) {
////      print("new Deck has been added");
////      Navigator.pop(context);
////    }
////    print("here");
//////    DatabaseService(uid: user.uid).addDeck("deck", 0, 0, 0.0, null, false);
//////    Navigator.of(context).pop();
//////    //TODO: Add the deck to the Database
////  }
////
////  addTest() {
//////    print("I wanna add a test");
//////    if(deckTitleController.text.isNotEmpty) {
//////      Navigator.of(context).push(MaterialPageRoute(
//////          builder: (context) => AddTestPage(deck:deckTitleController.text, deckIsGiven: true, user: widget.user,)));
//////      print(deckTitleController.text);
//////    }
//////    else Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddTestPage(deck: null, deckIsGiven: false, user: widget.user,)));
////  }
////
////  addCard() {
//////    print("I wanna add a card");
//////    if(deckTitleController.text.isNotEmpty) {
//////      Navigator.of(context).push(MaterialPageRoute(
//////          builder: (context) => AddCardPage(deck:deckTitleController.text, deckIsGiven: true, user: widget.user,)));
//////      print(deckTitleController.text);
//////    }
//////    else Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddCardPage(deck: null, deckIsGiven: false, user: widget.user,)));
////  }
//}