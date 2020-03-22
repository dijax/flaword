import 'package:flashcards/models/deckModel.dart';
import 'package:flashcards/models/userModel.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flutter/material.dart';

class DropDownWidget extends StatefulWidget {
  final String deckTitle;
  final bool deckIsGiven;
  final UserModel user;
  final DeckCallback onSelect;
  final List<DeckModel> decks;
  final bool expand;
  const DropDownWidget({this.user, this.onSelect, this.deckIsGiven, this.deckTitle, this.decks, this.expand});

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
      return (widget.decks != null)? new Theme(
          data: (!widget.expand) ? Theme.of(context).copyWith(
          canvasColor: Colors.grey.withOpacity(0.5),
        ): Container(),
        child: DropdownButton<DeckModel>(
          isExpanded: widget.expand,
          value: _selectedDeck,
          iconSize: 28,
          elevation: 0,
          style: TextStyle(
            color: (widget.expand) ? CustomColors.black: CustomColors.White,
            fontSize: 18,
            backgroundColor: (widget.expand) ? CustomColors.White: Colors.transparent,
          ),
          onChanged: (DeckModel newValue){
            setState(() {
              _selectedDeck = newValue;
              widget.onSelect(newValue.deckId);
            });
          },
          items: widget.decks.map<DropdownMenuItem<DeckModel>>((DeckModel value) {
            return DropdownMenuItem<DeckModel>(
              value: value,
              child: Text(value.title, style: TextStyle(color: (widget.expand) ? CustomColors.DeepBlue.withOpacity(0.9): CustomColors.White, fontWeight: FontWeight.bold),),
            );
          })?.toList(),
        ),
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
  }
}

typedef DeckCallback = void Function(String deckId);