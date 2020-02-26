import 'package:flashcards/screens/signupPage.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage();

  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin{
  List<String> decks;
  String dropDownValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(40, 40, 40, 73),
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
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(0.6),
                  radius: 50,
                  child: Icon(Icons.layers, size: 60, color: CustomColors.White,),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text("FLAWORLD",
                    style: TextStyle(
                        fontFamily: 'MrDafoe',
                        color: CustomColors.White,
                        fontSize: 25),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                ),
                Container(
//                decoration: new BoxDecoration(
//                  border: new Border(
//                    bottom: new BorderSide(
//                      width: 0.5,
//                      color: CustomColors.White,
//                    )
//                  )
//                ),
                  child: TextField(
                    style: TextStyle(color: CustomColors.White, decorationColor: CustomColors.White),
                    decoration: InputDecoration(
//                    border: new UnderlineInputBorder(
//                      borderSide: BorderSide(color: CustomColors.White),
//                    ),
//                    hintStyle: TextStyle(color: CustomColors.White, decorationColor: CustomColors.White),
                      enabledBorder: new UnderlineInputBorder(
                          borderSide: BorderSide(color: CustomColors.White,)
                      ),
                      icon: new Icon(Icons.mail_outline, color: CustomColors.White,),
                      labelText: 'E-mail adress',
                      labelStyle: TextStyle(color: CustomColors.White, fontFamily: 'Monsterrat', fontSize: 18),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide( width: 1.5, color: CustomColors.White),
                        borderRadius: BorderRadius.circular(25.0),
                      ),),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                ),
                Container(
//                decoration: new BoxDecoration(
//                  border: new Border(
//                    bottom: new BorderSide(
//                      width: 0.5,
//                      color: CustomColors.White,
//                    )
//                  )
//                ),
                  child: TextField(
                    style: TextStyle(color: CustomColors.White, decorationColor: CustomColors.White),
                    decoration: InputDecoration(
//                    border: new UnderlineInputBorder(
//                      borderSide: BorderSide(color: CustomColors.White),
//                    ),
//                    hintStyle: TextStyle(color: CustomColors.White, decorationColor: CustomColors.White),
                      enabledBorder: new UnderlineInputBorder(
                          borderSide: BorderSide(color: CustomColors.White,)
                      ),
                      icon: new Icon(Icons.lock_outline, color: CustomColors.White,),
                      labelText: 'Password',
                      labelStyle: TextStyle(color: CustomColors.White, fontFamily: 'Monsterrat', fontSize: 18),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide( width: 1.5, color: CustomColors.White),
                        borderRadius: BorderRadius.circular(25.0),
                      ),),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30),
                ),
                FlatButton(
                  color: Colors.transparent,
                  disabledColor: Colors.transparent,
                  child: Container(
                    width: 200,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: CustomColors.White),
                      borderRadius: BorderRadius.circular(10.0),
//                    gradient: LinearGradient(
//                      colors: [
//                        CustomColors.DeepBlue,
//                        CustomColors.PurpleLight,
////                        CustomColors.PurpleAccent,
//                      ],
//                    )
                    ),
                    child: Center(
                      child: Text('LOGIN', style: TextStyle(color: CustomColors.White, fontSize: 18, ), textAlign: TextAlign.center,),
                    ),
                  ),
                  onPressed: (){
                    print("hi");
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(30),
                ),
                FlatButton(
                  child: Text("SIGNUP", style: TextStyle(color: CustomColors.PurpleLight, fontSize: 18),),
                  onPressed: (){
                    print("hiiii");
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignUpPage()));
                  },
                ),
              ],
            ),
          ),
        )
    );
  }
}