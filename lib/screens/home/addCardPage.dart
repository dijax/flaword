import 'package:flashcards/models/CardUnderstanding.dart';
import 'package:flashcards/models/deck.dart';
import 'package:flashcards/models/user.dart';
import 'package:flashcards/services/database.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flashcards/Test/mockData.dart';
import 'package:provider/provider.dart';

class AddCardPage extends StatefulWidget {
  final String deckId;
  final String deckTitle;
  final bool deckIsGiven;
  final User user;
  const AddCardPage({this.deckTitle, this.deckIsGiven, this.user, this.deckId});

  @override
  _AddCardPageState createState() => _AddCardPageState();
}
class _AddCardPageState extends State<AddCardPage> {
  List<String> decks;
  String deckId = "";
  String dropDownValue;
  TextEditingController _cardTitleEC = TextEditingController();
  TextEditingController _cardDesEC = TextEditingController();
  TextEditingController _cardFrontEC = TextEditingController();
  TextEditingController _cardBackEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if(widget.deckIsGiven){
      dropDownValue = widget.deckTitle;
    } else{
//      dropDownValue = MockData.decksList[0].deckTitle;
    }
    return StreamProvider<List<Deck>>.value(
      value: DatabaseService(uid: widget.user.uid).decks,
      child: Scaffold(
        backgroundColor: CustomColors.black,
        appBar: AppBar(
          title: Text('Add Card'),
          actions: <Widget>[
            FlatButton(
              onPressed: addCard,
              child: Row(
                children: <Widget>[
                  Text("Done", style: TextStyle(color: CustomColors.PurpleDark, fontSize: 18),),
                  Icon(Icons.done, color: CustomColors.PurpleDark,),
                ],
              ),
            ),
          ],
          backgroundColor: CustomColors.black,
        ),
        body: SingleChildScrollView(
          child: Container(
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
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 150),
              decoration: BoxDecoration(color: CustomColors.White),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: _cardTitleEC,
                      decoration: InputDecoration(
                        labelText: 'Enter a card title',
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: CustomColors.DeepBlue, width: 1.5),
                          borderRadius: BorderRadius.circular(25.0),
                        ),),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    child: TextField(
                      controller: _cardDesEC,
                      decoration: InputDecoration(
                        labelText: 'Enter a card description',
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: CustomColors.DeepBlue, width: 2.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: new BorderRadius.only(
                          topLeft:  const  Radius.circular(10.0),
                          topRight: const  Radius.circular(10.0),),
                        color: Colors.white,
                        border: Border.all(color: CustomColors.DeepBlue,),
                      ),
                      padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
//                      child:(!widget.deckIsGiven)? DropDownWidget(
//                        deckTitle: widget.deckTitle,
//                        deckIsGiven : widget.deckIsGiven,
//                          user: widget.user,
//                          onSelect:(String id) {
//                            setState(() {
//                              deckId = id;
//                            });
//                          }): DropDownWidget(
//                        deckTitle: widget.deckTitle,
//                        deckIsGiven: widget.deckIsGiven,
//                        user: widget.user,
//                        onSelect: (String id) {},
//                      ),
                      child: ContWidget(deckTitle: widget.deckTitle, deckIsGiven: widget.deckIsGiven, user: widget.user, onSelected: (String id) {
                        setState(() {
                          deckId = id;
//                          print("hada li ghayrje3 fle5er"+ deckId);
                        });
                      }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    child: TextField(
                      controller: _cardFrontEC,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        labelText: 'Card front',
                        focusedBorder:OutlineInputBorder(
                          borderSide: const BorderSide(color: CustomColors.DeepBlue, width: 2.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    child: TextField(
                      controller: _cardBackEC,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        labelText: 'Card back',
                        focusedBorder:OutlineInputBorder(
                          borderSide: const BorderSide(color: CustomColors.DeepBlue, width: 2.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                  ),
//                Material(
//                  child: InkWell(
//                    onTap: addCard, // TODO: add Card either for a chosen deck or a new one
//                    child: Container(
//                      width: 150,
//                      child: Center(
//                        child: Column(
//                          children: <Widget>[
//                            Icon(Icons.check_circle, size: 30, color: CustomColors.PurpleDark,),
//                            SizedBox(height: 5,),
//                            Text(
//                              'Done',
//                              style: TextStyle(
//                                color: CustomColors.PurpleDark,
//                                fontSize: 20,
//                                fontFamily: 'Poppins',
//                                fontWeight: FontWeight.w500,
//                              ),
//                            ),
//                          ],
//                        ),
//                      ),
//                    ),
//                  ),
//                ),
                ],
              ), //bottomNavigationBar: BottomNavBar(),
            ),
          ),
        )
      ),
    );
  }

  getDecks() {
    decks = new List();
    if(widget.deckIsGiven){
      decks.add(widget.deckTitle);
    }
//    else MockData.decksList.forEach((element) => decks.add(element.deckTitle));
    return decks;
  }

  void addCard() {
    print("Card added");
    if(widget.deckIsGiven) {
      print("widget.deckId: " + widget.deckId);
      DatabaseService(
          uid: widget.user.uid).addCard(widget.deckId,
          _cardTitleEC.text,
          _cardBackEC.text,
          _cardBackEC.text,
          false,
          CardUnderstanding.none.toString());
      DatabaseService(uid: widget.user.uid, deck_Id:  widget.deckId).updateCardsCount(true);
    }else{
      print("deckId: " + deckId);
      DatabaseService(
          uid: widget.user.uid, deck_Id: deckId).addCard(deckId,
          _cardTitleEC.text,
          _cardBackEC.text,
          _cardBackEC.text,
          false,
          CardUnderstanding.none.toString());
      DatabaseService(uid: widget.user.uid, deck_Id: deckId).updateCardsCount(true);
    }
    Navigator.pop(context);
  }
}

class DropDownWidget extends StatefulWidget {
  final String deckTitle;
  final bool deckIsGiven;
  final User user;
  final List<Deck> decks;
  final DeckCallback onSelectDeck;
  const DropDownWidget({this.user, this.onSelectDeck, this.deckIsGiven, this.deckTitle, this.decks});

  @override
  _DropDownWidgetState createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  Deck _selectedDeck;

  @override
  void initState() {
    super.initState();
    _selectedDeck = widget.decks.first;
  }

  @override
  Widget build(BuildContext context) {
    if(!widget.deckIsGiven){
      return (widget.decks!= null)? DropdownButton<Deck>(
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
            widget.onSelectDeck(newValue.deckId);
            _selectedDeck = newValue;
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
  }
  List<Deck> getDecks(){
    return Provider.of<List<Deck>>(context);
  }
}

typedef DeckCallback = void Function(String deckId);


class ContWidget extends StatefulWidget {
  final String deckTitle;
  final bool deckIsGiven;
  final User user;
  final DDCallback onSelected;
  const ContWidget({this.user, this.onSelected, this.deckIsGiven, this.deckTitle});

  @override
  _ContWidgetState createState() => _ContWidgetState();
}

class _ContWidgetState extends State<ContWidget> {
  String did;
  @override
  Widget build(BuildContext context) {
    var _decks = Provider.of<List<Deck>>(context);
    return ( _decks != null) ? DropDownWidget(deckTitle: widget.deckTitle,
        user: widget.user, deckIsGiven: widget.deckIsGiven, decks: _decks, /*onSelect: (String id){
          setState(() {
            did = id;
            print("did" + did);
            widget.onSelected(did);
          });
      },*/)
        : Container();
  }
}

typedef DDCallback = void Function(String deckId);