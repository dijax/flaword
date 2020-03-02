import 'package:flutter/material.dart';
import 'package:flashcards/screens/home/homePage.dart';
import 'package:flashcards/screens/home/decksPage.dart';
import 'package:flashcards/screens/home/statisticsPage.dart';
import 'package:flashcards/screens/home/UserPage.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch(settings.name) {
      case'/':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/decks':
        return MaterialPageRoute(builder: (_) => DecksPage());
      case '/stats':
        return MaterialPageRoute(builder: (_) => StatisticsPage());
      case '/user':
        return MaterialPageRoute(builder: (_) => UserPage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }

}


