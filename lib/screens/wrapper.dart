import 'package:flashcards/bottomNavBar.dart';
import 'package:flashcards/models/user.dart';
import 'package:flashcards/screens/authentication/authentication.dart';
import 'package:flashcards/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flashcards/screens/authentication/loginPage.dart';
import 'package:flashcards/screens/authentication/signupPage.dart';
import 'package:flashcards/screens/home/homePage.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context); // accessing the user data from the provider
    if(user == null) return Authentication();
    else return BottomNavBar(user: user);
  }
}
