import 'package:flashcards/screens/authentication/loginPage.dart';
import 'package:flashcards/screens/authentication/signupPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Authentication extends StatefulWidget{
  const Authentication();

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends  State<Authentication>{
  bool showLogIn = true;

  void  toggleAuthView(){
    setState(() {
      showLogIn = !showLogIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showLogIn)
    return LoginPage(toggleAuthView: toggleAuthView);
    else
      return SignUpPage(toggleAuthView: toggleAuthView);
  }
}