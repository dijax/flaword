import 'dart:math';

import 'package:flashcards/screens/addDeckPage.dart';
import 'package:flashcards/screens/addTestPage.dart';
import 'package:flashcards/screens/decksPage.dart';
import 'package:flashcards/screens/homePage.dart';
import 'package:flashcards/screens/statisticsPage.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flashcards/screens/UserPage.dart';
import 'package:flashcards/screens/addCardPage.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}
class _BottomNavBarState extends State<BottomNavBar> with TickerProviderStateMixin{

  // List of icons shown by clicking the add floating action button
  List<IconData> icons = [Icons.add_to_photos, Icons.add_photo_alternate, Icons.question_answer];
  List<String> tooltips = ["deck","card", "test"];
  int _currentIndex = 0;
  AnimationController _controller;

  //Animation controller for the floating action button
  @override
  void initState(){
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: new Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: new List.generate(icons.length, (int index) {
            Widget child = new Container(
              height: 70.0,
              width: 56.0,
              alignment: FractionalOffset.topCenter,
              child: new ScaleTransition(
                scale: new CurvedAnimation(
                  parent: _controller,
                  curve: new Interval(0.0, 1.0 - index / icons.length/ 2.0,
                      curve: Curves.easeOut
                  ),
                ),
                child:  new FloatingActionButton(
                  heroTag: null,
                  backgroundColor: CustomColors.NearlyBlack,
                  mini: true,
                  tooltip: 'Add Button',
                  focusColor: Colors.white,
                  child:  new Icon(icons[index], color: CustomColors.PurpleLight,),
                  onPressed: () {
                    menuChildPressed(index);
                  },
                ),
              ),
            );
            return child;
          }).toList()..add(
            new FloatingActionButton (
              heroTag: null,
              backgroundColor: CustomColors.PurpleDark,
              elevation: 5.0,
              tooltip: 'Add Card',
              focusColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
              child: new AnimatedBuilder(animation: _controller, builder: (BuildContext context, Widget child){
                return new Transform(
                  transform: new Matrix4.rotationZ(_controller.value * 0.5 * pi),
                  alignment: FractionalOffset.center,
                  child: new Icon(_controller.isDismissed ? Icons.add : Icons.add_to_photos),
                );
              }),
              onPressed: () {
                if(_controller.isDismissed){
                  _controller.forward();
                }else{
                  _controller.reverse();
                }
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 50.0,
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.library_books, size: 30,),
          Icon(Icons.trending_up, size: 30),
          Icon(Icons.person, size: 30),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: CustomColors.DeepBlue,
        animationCurve: Curves.easeInOutCirc,
        animationDuration: Duration(milliseconds: 600),
        onTap: onTappedBar,
        index: _currentIndex,
      ),
      body: new Container(
        child: _children[_currentIndex],
      )
    );
  }

  final List<Widget> _children = [
    HomePage(),
    DecksPage(),
    StatisticsPage(),
    UserPage(),
  ];

  String text = 'Default Text';

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void menuChildPressed(int index) {
    switch(index){
      case 0:
        print("the add deck child has been pressed!");
        Navigator.of(context).push(MaterialPageRoute<Null>(builder: (BuildContext context){
          return new AddDeckPage();
        }
        ));
        break;
      case 1:
        print("the add card child has been pressed!");
        Navigator.of(context).push(MaterialPageRoute<Null>(builder: (BuildContext context){
          return new AddCardPage(null, false);
        }
        ));
        break;
      case 2:
        print("the add test child has been pressed!");
        Navigator.of(context).push(MaterialPageRoute<Null>(builder: (BuildContext context){
          return new AddTestPage(null, false);
        }));
        break;
    }
  }

}