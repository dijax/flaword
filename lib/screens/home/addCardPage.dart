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
import 'package:flashcards/Test/mockData.dart';
import 'package:provider/provider.dart';

class AddCardPage extends StatefulWidget {
  final String deckId;
  final String deckTitle;
  final bool deckIsGiven;
  final CardsCallback onAddCard;
  final User user;
  const AddCardPage({this.deckTitle, this.deckIsGiven, this.user, this.deckId, this.onAddCard});

  @override
  _AddCardPageState createState() => _AddCardPageState();
}
class _AddCardPageState extends State<AddCardPage> {
  List<String> decks;
  List<Deck> decksListiii;
  String deckId;
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

    //class TitleWidget extends StatelessWidget {
////  final userId = DatabaseService().uid;
//  final User user;
//  TitleWidget({this.user});
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
////    final user = Provider.of<User>(context);
////    print("user"+ user.username);
//          return (user!= null)?Padding(
//            padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 12.0),
//            child: StreamBuilder<DocumentSnapshot>(
//              stream: DatabaseService().users.document(user.uid).snapshots(),
//              builder: (context, snapshot) {
//                if(!snapshot.hasData) {
//                  print("Error snapshot does not have data");
//                  return Container();
//                } else if (snapshot.hasData) {
//                  print("userId " + user.uid);
//                  return Text("Hello, ${snapshot.data['username']}", style: TextStyle(fontSize: 30.0, color: CustomColors.White, fontFamily: 'Montserrat', fontWeight: FontWeight.bold),);
//                } else return Container();
//              }
//            ),
//          ):Container(child: Text("user is null"),);
//  }
//}
    return Scaffold(
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
//                                  print("tiiiiii" + deckId);
                              });
                        }
                      }
                    ): DropDownWidget(
                      deckTitle: widget.deckTitle,
                      deckIsGiven: widget.deckIsGiven,
                      user: widget.user,
//                        onSelect: (String id) {},
                    ),
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
//    print("Card added");
    // TODO test if the textfield empty

    if(widget.deckIsGiven) {

      CardModel card = CardModel(deckId: widget.deckId, title: _cardTitleEC.text,
          front: _cardFrontEC.text, back: _cardBackEC.text, isHidden: false,
          cardUnderstanding: CardUnderstanding.none.toString());
      widget.onAddCard(card);
//      print("widget.deckId: " + widget.deckId);

//      DatabaseService(
//          uid: widget.user.uid).addCard(widget.deckId,
//          _cardTitleEC.text,
//          _cardBackEC.text,
//          _cardBackEC.text,
//          false,
//          CardUnderstanding.none.toString());
    }else{
//      print("deckId: " + deckId);
//      DatabaseService(
//          uid: widget.user.uid).addCard(deckId,
//          _cardTitleEC.text,
//          _cardBackEC.text,
//          _cardBackEC.text,
//          false,
//          CardUnderstanding.none.toString());
    }
    Navigator.pop(context);
  }
}

//class DropDownWidget extends StatefulWidget {
//  final String deckTitle;
//  final bool deckIsGiven;
//  final User user;
//  final DeckCallback onSelect;
//  const DropDownWidget({this.user, this.onSelect, this.deckIsGiven, this.deckTitle});
//
//  @override
//  _DropDownWidgetState createState() => _DropDownWidgetState();
//}
//
//class _DropDownWidgetState extends State<DropDownWidget> {
//
//  List<Deck> _decks;
//  final List<Deck> _decksLII=[Deck(title: "decki", ), Deck(title: "deck0")];
//
//  var _selectedDeck;
//
//
//  @override
//  void initState() {
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    _decks = Provider.of<List<Deck>>(context);
//    if(!widget.deckIsGiven){
//
//      if(_decks!=null){
////        setState(() {
////          _decksList = _decks;
////        });
////        String id = "deck"+ (_decks.length + 1).toString();
////        print("id "+id);
////        _decks.forEach((deck){
////          print(deck.title);
////        });
//        widget.onSelect(_decks);
//      }
////      return (_decks != null)? DropdownButton<Deck>(
////      isExpanded: true,
////        value: _selectedDeck,
////        iconSize: 28,
////        elevation: 0,
////        style: TextStyle(
////          color: CustomColors.NearlyBlack,
////          fontSize: 18,
////          backgroundColor: Colors.white,
////        ),
////        onChanged: (Deck newValue){
////
////          setState(() {
////            _selectedDeck = newValue;
////            widget.onSelect(_decks);
////          });
////        },
////        items: _decks.map<DropdownMenuItem<Deck>>((Deck value) {
////          return DropdownMenuItem<Deck>(
////            value: value,
////            child: Text(value.title, style: TextStyle(color: CustomColors.DeepBlue.withOpacity(0.9), fontWeight: FontWeight.bold),),
////          );
////        })?.toList(),
////      ):Container();
////    } else{
////      return DropdownButton<String>(
////        isExpanded: true,
////        value: null,
////        iconSize: 28,
////        elevation: 0,
////        style: TextStyle(
////          color: CustomColors.NearlyBlack,
////          fontSize: 18,
////          backgroundColor: Colors.white,
////        ),
////        onChanged: (String newValue){
////        },
////        items: [widget.deckTitle].map<DropdownMenuItem<String>>((String value) {
////          return DropdownMenuItem<String>(
////            value: value,
////            child: Text(value, style: TextStyle(color: CustomColors.DeepBlue.withOpacity(0.9), fontWeight: FontWeight.bold),),
////          );
////        })?.toList(),
////      );
////    }
//  }
////  List<Deck> getDecks(){
////    return Provider.of<List<Deck>>(context);
////  }
//    return Container();
//  }
//}


typedef CardsCallback = void Function(CardModel card);