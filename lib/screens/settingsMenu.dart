import 'package:flashcards/Test/mockData.dart';
import 'package:flashcards/models/DeckModel.dart';
import 'package:flashcards/models/settings.dart';
import 'package:flashcards/screens/addDeckPage.dart';
import 'package:flutter/material.dart';

class SettingsMenu extends StatefulWidget {
  final DeckCallback onDeckSelect;
  final int index;
  const SettingsMenu({this.onDeckSelect, this.index});
  @override
  _SettingsMenuState createState() => _SettingsMenuState();
}

class _SettingsMenuState extends State<SettingsMenu> {
  final GlobalKey _menuKey = new GlobalKey();
  List<DeckModel> decks = MockData.getDecksList();

  @override
  Widget build(BuildContext context) {
    final button = new PopupMenuButton(
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
        ); //TODO: implement the settings
//    final tile =
//    new ListTile(title: new Text(''), trailing: button, onTap: () {
//      // This is a hack because _PopupMenuButtonState is private.
//      dynamic state = _menuKey.currentState;
//      state.showButtonMenu();
//    });
     return new Container(
       child: button,
     );
  }

  menuItemClicked(key) {
    // TODO: Implement the settings
    switch(key) {
      case Settings.Edit:
        print("Edit has been pressed");
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddDeckPage()));
        break;
      case Settings.Hide:
        print("Hide has been pressed");
        decks.removeAt(widget.index);
        widget.onDeckSelect(decks);
        break;
      case Settings.Delete:
        print("Delete has been pressed");
        decks.removeAt(widget.index);
        widget.onDeckSelect(decks);
        break;
    }
  }

}

typedef DeckCallback = void Function(List<DeckModel> decks);