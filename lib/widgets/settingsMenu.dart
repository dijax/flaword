import 'package:flashcards/Test/mockData.dart';
import 'package:flashcards/models/CardModel.dart';
import 'package:flashcards/models/DeckModel.dart';
import 'package:flashcards/models/TestModel.dart';
import 'package:flashcards/models/settings.dart';
import 'package:flashcards/screens/home/addCardPage.dart';
import 'package:flashcards/screens/home/addDeckPage.dart';
import 'package:flashcards/screens/home/addTestPage.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flutter/material.dart';

class SettingsMenu extends StatefulWidget {
  final DeckCallback onSelect;
  final int index;
  final List<dynamic> list;
  const SettingsMenu({this.onSelect, this.index, this.list});
  @override
  _SettingsMenuState createState() => _SettingsMenuState();
}

class _SettingsMenuState extends State<SettingsMenu> {
  final GlobalKey _menuKey = new GlobalKey();
  List<Object> list;

  @override
  void initState() {
    super.initState();
    list = widget.list;
  }

  @override
  Widget build(BuildContext context) {
    final button = new PopupMenuButton(
      icon: Icon(Icons.more_vert, color: menuColor(),),
        key: _menuKey,
        itemBuilder: (_) => <PopupMenuItem<Settings>>[
          new PopupMenuItem<Settings>(
              child: const Text('Edit'), value: Settings.Edit),
          new PopupMenuItem<Settings>(
              child: const Text('Hide'), value: Settings.Hide),
          new PopupMenuItem<Settings>(
            child: const Text('Delete'), value: Settings.Delete,),
        ],
        onSelected: menuItemClicked,
        );
     return new Container(
       child: button,
     );
  }

  menuItemClicked(key) {
    switch(key) {
      case Settings.Edit:
        print("Edit has been pressed");
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => toPage()));
        break;
      case Settings.Hide:
        print("Hide has been pressed");
        widget.onSelect(list, true);
        break;
      case Settings.Delete:
        print("Delete has been pressed");
        showAlertDialog(context);
        widget.onSelect(list, false);
        break;
    }
    return null;
  }

  menuColor() {
    if(list is List<DeckModel>)
      return CustomColors.black;
    if(list is List<CardModel>)
      return CustomColors.White;
    if(list is List<TestModel>)
      return CustomColors.White;
    return CustomColors.PurpleDark;
  }

  toPage() {
    if(list is List<DeckModel>)
      return AddDeckPage();
    if(list is List<CardModel>)
      return AddCardPage(null, false);
    if(list is List<TestModel>)
      return AddTestPage(null, false);
    return CustomColors.White;
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        print("cancel");
        Navigator.of(context).pop();
        list.removeAt(widget.index);
        },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete"),
      content: Text("Are you sure? \nYou won't be able to revert this."),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

typedef DeckCallback = void Function(List<dynamic> decks, bool hidden);