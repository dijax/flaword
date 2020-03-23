import 'package:flashcards/models/cardModel.dart';
import 'package:flashcards/models/deckModel.dart';
import 'package:flashcards/models/settings.dart';
import 'package:flashcards/models/testModel.dart';
import 'package:flashcards/models/userModel.dart';
import 'package:flashcards/screens/home/addPages/addCardPage.dart';
import 'package:flashcards/screens/home/addPages/addDeckPage.dart';
import 'package:flashcards/screens/home/addPages/addTestPage.dart';
import 'package:flashcards/services/database.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flutter/material.dart';

class SettingsMenu extends StatefulWidget {
  final DeckCallback onSelect;
  final int index;
  final dynamic list;
  final UserModel user;
  const SettingsMenu({this.onSelect, this.index, this.list, this.user});
  @override
  _SettingsMenuState createState() => _SettingsMenuState();
}

class _SettingsMenuState extends State<SettingsMenu> {
  final GlobalKey _menuKey = new GlobalKey();
  dynamic list;

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
//        widget.onSelect(list, true);
        hideElement(list);
        break;
      case Settings.Delete:
        print("Delete has been pressed");
        showAlertDialog(context);
        widget.onSelect(list, true);
        break;
    }
    return null;
  }

  menuColor() {
    if(list is DeckModel)
      return CustomColors.black;
    if(list is CardModel)
      return CustomColors.White;
    if(list is TestModel)
      return CustomColors.White;
    return CustomColors.PurpleDark;
  }

  toPage() {
    if(list is DeckModel)
      return AddDeck(deck: list as DeckModel, user: widget.user, edit: true);
    if(list is CardModel)
      return AddCardPage(card: list as CardModel, edit:true, deckTitle: null, deckIsGiven: false, user: widget.user,);
    if(list is TestModel)
      return AddTest(test: list as TestModel, edit:true, deckTitle: null,deckIsGiven: false, user: widget.user,);
    return CustomColors.White;
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        print("cancel");
        Navigator.of(context).pop();
        },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed:  () {
        Navigator.of(context).pop();
        deleteElement(list);
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

  void hideElement(element) {
      if(element is DeckModel) {
        DatabaseService(uid: widget.user.uid).updateDeckVisibilty(true, element.deckId);
      }

      if(element is CardModel) {
        DatabaseService(uid: widget.user.uid).updateCardVisibilty(true, element.deckId, element.cardId);
      }

      if(element is TestModel) {
        DatabaseService(uid: widget.user.uid).updateTestVisibilty(true, element.deckId, element.testId);
      }
  }

  void deleteElement(list) {
    if(list is DeckModel) {
      DatabaseService(uid: widget.user.uid).removeDeck(list.deckId);
    }

    if(list is CardModel) {
      DatabaseService(uid: widget.user.uid).removeCard(list.deckId, list.cardId);
    }

    if(list is TestModel) {
      DatabaseService(uid: widget.user.uid).removeTest(list.deckId, list.testId);
    }
  }
}

typedef DeckCallback = void Function(dynamic element, bool isHidden);