import 'package:flashcards/bottomNavBar.dart';
import 'package:flashcards/models/user.dart';
import 'package:flashcards/screens/authentication/authentication.dart';
import 'package:flashcards/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flashcards/screens/authentication/loginPage.dart';
import 'package:flashcards/screens/authentication/signupPage.dart';
import 'package:flashcards/screens/home/homePage.dart';
import 'package:provider/provider.dart';

//enum AuthStatus {
//  NOT_DETERMINED,
//  NOT_LOGGED_IN,
//  LOGGED_IN,
//}

class Wrapper extends StatelessWidget{

//  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
//  String _userId = "";

//  @override
//  void initState() {
//    super.initState();
//    widget.auth.getCurrentUser().then((user) {
//      setState(() {
//        if(user != null) _userId = user?.uid;
//        authStatus = user?.uid == null ? AuthStatus.LOGGED_IN: AuthStatus.LOGGED_IN;
//      });
//    });
//  }

//  void loginCallback() {
//    widget.auth.getCurrentUser().then((user) {
//      setState(() {
//        _userId = user.uid.toString();
//      });
//    });
//    setState(() {
//      authStatus = AuthStatus.LOGGED_IN;
//    });
//  }

//  void logoutCallback() {
//    setState(() {
//      authStatus = AuthStatus.NOT_LOGGED_IN;
//      _userId = "";
//    });
//  }

//  Widget buildWaitingScreen() {
//    return Scaffold(
//      body: Container(
//        alignment: Alignment.center,
//        child: CircularProgressIndicator(),
//      ),
//    );
//  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context); // accessing the user data from the provider
    if(user == null) return Authentication();
    else return BottomNavBar();


//    switch(authStatus) {
//      case AuthStatus.NOT_DETERMINED:
//        return buildWaitingScreen();
//        break;
//      case AuthStatus.NOT_LOGGED_IN:
//        return new LoginPage(widget.auth);
//        break;
//      case AuthStatus.LOGGED_IN:
//        if(_userId.length > 0 && _userId != null){
//          return new HomePage();
//        } else return buildWaitingScreen();
//        break;
//      default:
//        return buildWaitingScreen();
//    }

  }
}
