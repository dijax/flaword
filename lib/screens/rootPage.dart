import 'package:flashcards/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flashcards/screens/loginPage.dart';
import 'package:flashcards/screens/signupPage.dart';
import 'package:flashcards/screens/homePage.dart';

//enum AuthStatus {
//  NOT_DETERMINED,
//  NOT_LOGGED_IN,
//  LOGGED_IN,
//}

class RootPage extends StatefulWidget {
//  final AuthService auth;
  RootPage();

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

class _RootPageState extends State<RootPage> {
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
    // TODO: implement build
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

    return LoginPage();
  }
}
