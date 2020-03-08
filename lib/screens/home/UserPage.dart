import 'package:flashcards/models/user.dart';
import 'package:flashcards/screens/home/addCardPage.dart';
import 'package:flashcards/screens/home/addDeckPage.dart';
import 'package:flashcards/screens/home/addTest.dart';
import 'package:flashcards/screens/home/addTestPage.dart';
import 'package:flashcards/screens/home/adddeck.dart';
import 'package:flashcards/services/auth.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flutter/material.dart';
import 'dart:math';
class UserPage extends StatefulWidget {
  final User user;
  UserPage( {this.user});

  _UserPageState createState() => _UserPageState();
}
class _UserPageState extends State<UserPage>{
  final AuthService _auth = AuthService();
//  AnimationController _controller;
//  List<String> tooltips = ["deck","card", "test"];


  //Animation controller for the floating action button
//  @override
//  void initState(){
//    super.initState();
//    _controller = new AnimationController(
//      vsync: this,
//      duration: const Duration(milliseconds: 500),
//    );
//  }
  @override
  Widget build(BuildContext context) {
    List<IconData> icons = [Icons.add_to_photos, Icons.add_photo_alternate, Icons.question_answer];

    return Scaffold(
//      floatingActionButton: new Padding(
//        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
//        child: new Column(
//          mainAxisSize: MainAxisSize.min,
//          children: new List.generate(icons.length, (int index) {
//            Widget child = new Container(
//              height: 70.0,
//              width: 120.0,
//              alignment: FractionalOffset.topCenter,
//              child: new ScaleTransition(
//                scale: new CurvedAnimation(
//                  parent: _controller,
//                  curve: new Interval(0.0, 1.0 - index / icons.length/ 2.0,
//                      curve: Curves.easeOut
//                  ),
//                ),
//                child: Row(
//                  children: <Widget>[
//                    Padding(
//                      padding: EdgeInsets.fromLTRB(0, 0, padd(index), 0),
//                      child: Text(tooltips[index], style: TextStyle(color: CustomColors.White, backgroundColor: CustomColors.black.withOpacity(0.5),),),
//                    ),
//                    new FloatingActionButton(
//                      heroTag: null,
//                      tooltip: "add Button",
//                      backgroundColor: CustomColors.black,
//                      mini: true,
//                      focusColor: Colors.white,
//                      child:  new
//                      Icon(icons[index], color: CustomColors.Purple,),
//                      onPressed: () {
//                        menuChildPressed(index, widget.user);
//                      },
//                    ),
//                  ],
//                ),
//              ),
//            );
//            return child;
//          }).toList()..add(
//            new FloatingActionButton (
//              heroTag: null,
//              backgroundColor: CustomColors.PurpleDark,
//              elevation: 5.0,
//              focusColor: Colors.white,
//              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
//              child: new AnimatedBuilder(animation: _controller, builder: (BuildContext context, Widget child){
//                return new Transform(
//                  transform: new Matrix4.rotationZ(_controller.value * 0.5 * pi),
//                  alignment: FractionalOffset.center,
//                  child: Column(children: <Widget>[
//                    SizedBox(height: 15,),
//                    new Icon(_controller.isDismissed ? Icons.add : Icons.add_to_photos),
//                  ],),
//                );
//              }),
//              onPressed: () {
//                if(_controller.isDismissed){
//                  _controller.forward();
//                }else{
//                  _controller.reverse();
//                }
//              },
//            ),
//          ),
//        ),
//      ),
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.3),
        title: Text('Setting'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: InkWell(
              onTap: () async{
                print("logout");
                await _auth.signOut();
              },
              child: Row(
                children: <Widget>[
                  Text("Logout", style: TextStyle(color: CustomColors.White, fontSize: 16),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.power_settings_new, color: CustomColors.White,),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.transparent,
      body: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                  child: Text("UserName", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Monsterrat',),),
                ),
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                  child: Text("Password", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Monsterrat'),),
                ),
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                  child: Text("Email", style: TextStyle(fontFamily: 'Monsterrat', fontWeight: FontWeight.bold,),),
                ),
              ),
            ]
        ),
      ),
      //bottomNavigationBar: BottomNavBar(),
    );
  }

//  void menuChildPressed(int index, User user) {
//    switch(index){
//      case 0:
//        print("the add deck child has been pressed!");
//        Navigator.of(context).push(MaterialPageRoute<Null>(builder: (BuildContext context){
//          return new Adddeck( user: user);
//        }
//        ));
//        break;
//      case 1:
//        print("the add card child has been pressed!");
//        Navigator.of(context).push(MaterialPageRoute<Null>(builder: (BuildContext context){
//          return new AddCardPage(deck: null, deckIsGiven: false, user: user);
//        }
//        ));
//        break;
//      case 2:
//        print("the add test child has been pressed!");
//        Navigator.of(context).push(MaterialPageRoute<Null>(builder: (BuildContext context){
//          return new AddTest(deck: null, deckIsGiven: false, user: user);
//        }));
//        break;
//    }
//  }

//  double padd(int index) {
//    if (index == 0)
//      return 2.5;
//    if (index == 1)
//      return 2.5+index;
//    if (index == 2)
//      return 10.0;
//    return 0;
//  }
}