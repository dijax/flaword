import 'package:flashcards/Test/mockData.dart';
import 'package:flashcards/models/DeckModel.dart';
import 'package:flashcards/models/TestModel.dart';
import 'package:flashcards/models/card.dart';
import 'package:flashcards/models/deck.dart';
import 'package:flashcards/models/settings.dart';
import 'package:flashcards/models/test.dart';
import 'package:flashcards/models/user.dart';
import 'package:flashcards/screens/home/addCardPage.dart';
import 'package:flashcards/screens/home/addDeckPage.dart';
import 'package:flashcards/screens/home/addTest.dart';
import 'package:flashcards/screens/home/addTestPage.dart';
import 'package:flashcards/screens/home/adddeck.dart';
import 'package:flashcards/services/database.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flutter/material.dart';

class SettingsMenu extends StatefulWidget {
  final DeckCallback onSelect;
  final int index;
  final dynamic list;
  final User user;
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
        widget.onSelect(list, true);
        hideElement(list);
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
    if(list is Deck)
      return CustomColors.black;
    if(list is CardModel)
      return CustomColors.White;
    if(list is Test)
      return CustomColors.White;
    return CustomColors.PurpleDark;
  }

  toPage() {
    if(list is Deck)
      return AddDeck(deck: list as Deck, user: widget.user, edit: true);
    if(list is CardModel)
      return AddCardPage(card: list as CardModel, edit:true, deckTitle: null, deckIsGiven: false, user: widget.user,);
    if(list is Test)
      return AddTest(test: list as Test, edit:true, deckTitle: null,deckIsGiven: false, user: widget.user,);
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

  void hideElement(list) {
      if(list is Deck) {
        DatabaseService(uid: widget.user.uid).updateDeckVisibilty(true, list.deckId);
      }

      if(list is CardModel) {
        DatabaseService(uid: widget.user.uid).updateCardVisibilty(true, list.deckId, list.cardId);
      }

      if(list is Test) {
        DatabaseService(uid: widget.user.uid).updateTestVisibilty(true, list.deckId, list.testId);
      }
  }

  void deleteElement(list) {
    if(list is Deck) {
      DatabaseService(uid: widget.user.uid).removeDeck(list.deckId);
    }

    if(list is CardModel) {
      DatabaseService(uid: widget.user.uid).removeCard(list.deckId, list.cardId);
    }

    if(list is Test) {
      DatabaseService(uid: widget.user.uid).removeTest(list.deckId, list.testId);
    }
  }
}

typedef DeckCallback = void Function(dynamic element, bool isHidden);