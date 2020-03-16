import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashcards/models/CardUnderstanding.dart';
import 'package:flashcards/models/card.dart';
import 'package:flashcards/models/deck.dart';
import 'package:flashcards/models/user.dart';
import 'package:flashcards/services/database.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flashcards/widgets/dropDownWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddCardPage extends StatefulWidget {
  final String deckId;
  final CardModel card;
  final bool edit;
  final String deckTitle;
  final bool deckIsGiven;
  final CardsCallback onAddCard;
  final User user;
  const AddCardPage({this.deckTitle, this.deckIsGiven, this.user, this.card, this.edit, this.deckId, this.onAddCard});

  @override
  _AddCardPageState createState() => _AddCardPageState();
}
class _AddCardPageState extends State<AddCardPage> {
  String deckId;
//  String dropDownValue;
  TextEditingController _cardTitleEC = TextEditingController();
  TextEditingController _cardDesEC = TextEditingController();
  TextEditingController _cardFrontEC = TextEditingController();
  TextEditingController _cardBackEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if(widget.edit){
      _cardTitleEC.text = widget.card.title;
      _cardDesEC.text = widget.card.description;
      _cardFrontEC.text = widget.card.front;
      _cardBackEC.text = widget.card.back;
    }

    return Scaffold(
        backgroundColor: CustomColors.black,
        appBar: AppBar(
          title: (!widget.edit) ? Text('Add Card') : Text('Edit Card'),
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
              padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
              decoration: BoxDecoration(
                  color: CustomColors.White,
                  borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(20.0),
                    bottomRight: const Radius.circular(20.0),)
              ),
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
                        ),
                      ),
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
                  (!widget.edit)?Padding(
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
                      child:(!widget.deckIsGiven)? StreamBuilder<QuerySnapshot>(
                          stream: DatabaseService(uid: widget.user.uid).deckCollection.document(widget.user.uid).collection("decks").snapshots(),
                          builder: (context, snapshot) {
                            List<Deck> decks = new List();
                            if(snapshot.hasError)return Container();
                            else if(snapshot.data == null)return Container();
                            else {
                              snapshot.data.documents.forEach((doc){
                                decks.add(Deck().fromSnapshot(doc));
                              });
                              return DropDownWidget(
                                  decks: decks,
                                  deckTitle: widget.deckTitle,
                                  deckIsGiven : widget.deckIsGiven,
                                  user: widget.user,
                                  onSelect:(String id) {
                                    deckId = id;
                                  }
                              );
                            }
                          }
                      ): DropDownWidget(
                        deckTitle: widget.deckTitle,
                        deckIsGiven: widget.deckIsGiven,
                        user: widget.user,
//                        onSelect: (String id) {},
                      ),
                    ),
                  ):Container(),
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
                ],
              ), //bottomNavigationBar: BottomNavBar(),
            ),
          ),
        )
    );
  }

  void addCard() {
    if(_cardBackEC.text.trim().isNotEmpty && _cardFrontEC.text.trim().isNotEmpty && _cardTitleEC.text.trim().isNotEmpty) {
      if(widget.edit){
        DatabaseService(uid:widget.user.uid).updateCard(widget.card.cardId,
            widget.card.deckId,_cardTitleEC.text, _cardDesEC.text, _cardFrontEC.text, _cardBackEC.text);
      }else{
        if(widget.deckIsGiven) {
          CardModel card = CardModel(deckId: widget.deckId, title: _cardTitleEC.text,
              front: _cardFrontEC.text, back: _cardBackEC.text, isHidden: false,
              cardUnderstanding: CardUnderstanding.none.toString());
          widget.onAddCard(card);
        }else{
          DatabaseService(
            // give the cardId only if the Deck not saved yet
              uid: widget.user.uid).addCard(/*null, */deckId,
              _cardTitleEC.text,
              _cardBackEC.text,
              _cardFrontEC.text,
              false,
              CardUnderstanding.none.toString());
        }
      }
      Navigator.pop(context);
    } else {
      print("card title, card front oder card back fehlen");
    }
  }
}

typedef CardsCallback = void Function(CardModel card);