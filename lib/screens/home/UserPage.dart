import 'package:flashcards/models/userModel.dart';
import 'package:flashcards/services/auth.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flutter/material.dart';
class UserPage extends StatefulWidget {
  final UserModel user;
  UserPage( {this.user});

  _UserPageState createState() => _UserPageState();
}
class _UserPageState extends State<UserPage>{
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    List<IconData> icons = [Icons.add_to_photos, Icons.add_photo_alternate, Icons.question_answer];

    return Scaffold(
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
    );
  }
}