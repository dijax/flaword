import 'package:flashcards/models/deck.dart';
import 'package:flashcards/models/user.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flutter/material.dart';

class DropDownWidget extends StatefulWidget {
  final String deckTitle;
  final bool deckIsGiven;
  final User user;
  final DeckCallback onSelect;
  final List<Deck> decks;
  const DropDownWidget({this.user, this.onSelect, this.deckIsGiven, this.deckTitle, this.decks});

  @override
  _DropDownWidgetState createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  var _selectedDeck;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(!widget.deckIsGiven){

      if(widget.decks!=null){
//        setState(() {
//          _decksList = _decks;
//        });
//        String id = "deck"+ (_decks.length + 1).toString();
//        print("id "+id);
//        _decks.forEach((deck){
//          print(deck.title);
//        });
//        widget.onSelect(_decks);
//    }
      }
      return (widget.decks != null)? DropdownButton<Deck>(
        isExpanded: true,
        value: _selectedDeck,
        iconSize: 28,
        elevation: 0,
        style: TextStyle(
          color: CustomColors.NearlyBlack,
          fontSize: 18,
          backgroundColor: Colors.white,
        ),
        onChanged: (Deck newValue){
          setState(() {
            _selectedDeck = newValue;
            widget.onSelect(newValue.deckId);
          });
        },
        items: widget.decks.map<DropdownMenuItem<Deck>>((Deck value) {
          return DropdownMenuItem<Deck>(
            value: value,
            child: Text(value.title, style: TextStyle(color: CustomColors.DeepBlue.withOpacity(0.9), fontWeight: FontWeight.bold),),
          );
        })?.toList(),
      ):Container();
    } else{
      return DropdownButton<String>(
        isExpanded: true,
        value: widget.deckTitle,
        iconSize: 28,
        elevation: 0,
        style: TextStyle(
          color: CustomColors.NearlyBlack,
          fontSize: 18,
          backgroundColor: Colors.white,
        ),
        onChanged: (String newValue){
        },
        items: [widget.deckTitle].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value, style: TextStyle(color: CustomColors.DeepBlue.withOpacity(0.9), fontWeight: FontWeight.bold),),
          );
        })?.toList(),
      );
    }
//  List<Deck> getDecks(){
//    return Provider.of<List<Deck>>(context);
//  }
  }
}


typedef DeckCallback = void Function(String deckId);