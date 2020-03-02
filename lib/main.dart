import 'dart:io';

import 'package:flashcards/bottomNavBar.dart';
import 'package:flashcards/screens/wrapper.dart';
import 'package:flashcards/routes/routeGenerator.dart';
import 'package:flashcards/screens/authentication/loginPage.dart';
import 'package:flashcards/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return StreamProvider<User>.value(
      value: AuthService().user, // we create an instance of the AuthService to call the stream
      child: MaterialApp(
        title: 'Flashcards',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.red,
          fontFamily: 'Poppins',
        ),
        onGenerateRoute: RouteGenerator.generateRoute,
        home: Container(
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
          child: Wrapper(),
        ),
//      home: BottomNavBar(),
      ),
    );
  }
}