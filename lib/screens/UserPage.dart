import 'package:flashcards/utils/customColors.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  _UserPageState createState() => _UserPageState();
}
class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: CustomColors.DeepBlue,
      body: Column(
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
                child: Text("Userpasswort", style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Monsterrat'),),
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                child: Text("Username", style: TextStyle(fontFamily: 'Monsterrat', fontWeight: FontWeight.bold,),),
              ),
            ),
          ]
      ),
      //bottomNavigationBar: BottomNavBar(),
    );
  }
}