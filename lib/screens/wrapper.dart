import 'package:flashcards/models/userModel.dart';
import 'package:flashcards/screens/authentication/authentication.dart';
import 'package:flashcards/screens/home/bottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context); // accessing the user data from the provider
    if(user == null) return Authentication();
    else return BottomNavBar(user: user);
  }
}
