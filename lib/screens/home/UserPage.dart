import 'package:flashcards/services/auth.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  _UserPageState createState() => _UserPageState();
}
class _UserPageState extends State<UserPage> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: CustomColors.black,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage('assets/graphics/mountain.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                CustomColors.black.withOpacity(0.6),
                BlendMode.dstIn
            ),
          ),

        ),

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
              InkWell(
                onTap: () async{
                  print("logout");
                  await _auth.signOut();
                  },
                child: Row(
                  children: <Widget>[
                    FlatButton(
                      child: Text("Logout", style: TextStyle(color: CustomColors.White),),
                      onPressed: (){},
                    ),
                    Icon(Icons.power_settings_new, color: CustomColors.White,),
                  ],
                ),
              ),
            ]
        ),
      ),
      //bottomNavigationBar: BottomNavBar(),
    );
  }
}