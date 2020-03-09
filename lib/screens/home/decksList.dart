import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashcards/Test/mockData.dart';
import 'package:flashcards/models/DeckModel.dart';
import 'package:flashcards/models/deck.dart';
import 'package:flashcards/models/user.dart';
import 'package:flashcards/views/deckView.dart';
import 'package:flashcards/widgets/settingsMenu.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flashcards/services/database.dart';

class DecksList extends StatefulWidget {
  final User user;
  DecksList({this.user});

  @override
  _DecksListState createState() => _DecksListState();
}

class _DecksListState extends State<DecksList> with TickerProviderStateMixin{
  //TODO use the Random color generator
  int deckIndex = 0;
  ScrollController scrollController;
  AnimationController animationController;
  CurvedAnimation curvedAnimation;
//  List<DeckModel> decks = MockData.decksList.take(3).toList();


  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
  }

  @override
  Widget build(BuildContext context) {

    final decks = Provider.of<List<Deck>>(context);
    if(decks!=null){
      String id = "deck"+ (decks.length + 1).toString();
      print("id "+id);
      decks.forEach((deck){
        print(deck.title);
      });
    }

    return (decks!= null)?
      ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: decks.length,
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, position){
          return GestureDetector(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0 , 8.0),
              child: Container(
                child: (!decks.elementAt(position).hidden)? new Card(
                  child: InkWell(
                    onTap: () {
                      // TODO the DeckView anpassen und the sorting implementieren
//                      var selectedDeck = MockData.sortedDecks[position];
//                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DeckView(selectedDeck, DateTime.now())));
//                      MockData.last3Decks(position);
                    },
                    child: Container(
                      width: 250.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(12.0, 0.0, 0.0, 0.0),
                                ),
                                SettingsMenu(
                                  user: widget.user,
                                  list: decks,
                                  onSelect: (List<Object> decks, bool hidden) {
                                    setState(() {
//                                      if(hidden){MockData.decksList.elementAt(position).hidden = true;}
//                                      this.decks = decks; //TODO Settings menu erwartet ein Deckmodel und bekommt ein DEcks
                                    });
                                  },
                                  index: position,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 40.0),
                                  child: Text("${decks[position].title}", style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, fontFamily: 'Montserrat', color: CustomColors.black), textAlign: TextAlign.center,),
                                ),
                                Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                    child:Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Text("${decks[position].cardsCount.toString()}", style: TextStyle(color: CustomColors.black, fontSize: 25.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w600 ),),
                                            Padding(
                                                padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                                child: Icon(Icons.perm_media, color: CustomColors.black, size: 20.0,)
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Text("${decks[position].testsCount.toString()}", style: TextStyle(fontSize: 25.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w600 , color: CustomColors.black),),
                                            Padding(
                                                padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                                child: Icon(Icons.thumbs_up_down, color: CustomColors.black, size: 20.0,)
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: LinearProgressIndicator(
                                    value: decks[position].completion,
                                    backgroundColor: CustomColors.DeeppurlpleBackground,
                                    valueColor: AlwaysStoppedAnimation<Color>(CustomColors.PurpleDark),),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ): Card(),
                decoration: new BoxDecoration(boxShadow: [
                ]),
              ),
            ),
            onHorizontalDragEnd: (details) {
              animationController = AnimationController(
                  vsync: this, duration: Duration(
                  milliseconds: 500));
              curvedAnimation = CurvedAnimation(
                  parent: animationController, curve: Curves
                  .fastOutSlowIn);
              animationController.addListener(() {
                setState(() {
//                                currentColor = colorTween.evaluate(curvedAnimation);
                });
              });
              if(details.velocity.pixelsPerSecond.dx > 0) {
                if(deckIndex > 0) {
                  deckIndex--;
//                  colorTween = ColorTween();
                }
              } else {
                if (deckIndex < 2) {
                  deckIndex ++;
//                  colorTween = ColorTween();
                }
              }
              setState(() {
                scrollController.animateTo(deckIndex*256.0, duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
              }
              );
            }
        );
      },
    ):Container();
//    return ListView.builder(
//      physics: NeverScrollableScrollPhysics(),
//      itemCount: decks.length,
//      controller: scrollController,
//      scrollDirection: Axis.horizontal,
//      itemBuilder: (context, position){
//        return GestureDetector(
//            child: Padding(
//              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0 , 8.0),
//              child: Container(
//                child: (!decks.elementAt(position).hidden)? new Card(
//                  child: InkWell(
//                    onTap: () {
//                      var decksFromDB = Provider.of<List<Deck>>(context, listen: false);
//                      decksFromDB.forEach((deck){print(deck.title);});
//                      var selectedDeck = MockData.sortedDecks[position];
//                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DeckView(selectedDeck, DateTime.now())));
//                      MockData.last3Decks(position);
//                    },
//                    child: Container(
//                      width: 250.0,
//                      child: Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        children: <Widget>[
//                          Padding(
//                            padding: const EdgeInsets.all(8.0),
//                            child: Row(
//                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                              children: <Widget>[
//                                Padding(
//                                  padding: const EdgeInsets.fromLTRB(12.0, 0.0, 0.0, 0.0),
//                                ),
//                                SettingsMenu(
//                                  list: decks,
//                                  onSelect: (List<Object> decks, bool hidden) {
//                                    setState(() {
//                                      if(hidden){MockData.decksList.elementAt(position).hidden = true;}
//                                      this.decks = decks;
//                                    });
//                                  },
//                                  index: position,
//                                ),
//                              ],
//                            ),
//                          ),
//                          Padding(
//                            padding: const EdgeInsets.all(8.0),
//                            child: Column(
//                              crossAxisAlignment: CrossAxisAlignment.center,
//                              mainAxisAlignment: MainAxisAlignment.start,
//                              children: <Widget>[
//                                Padding(
//                                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 40.0),
//                                  child: Text("${MockData.sortedDecks[position].deckTitle}", style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, fontFamily: 'Montserrat', color: CustomColors.black), textAlign: TextAlign.center,),
//                                ),
//                                Padding(
//                                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//                                    child:Row(
//                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                      children: <Widget>[
//                                        Row(
//                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                          children: <Widget>[
//                                            Text("${decks[position].cards.length.toString()}", style: TextStyle(color: CustomColors.black, fontSize: 25.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w600 ),),
//                                            Padding(
//                                                padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
//                                                child: Icon(Icons.perm_media, color: CustomColors.black, size: 20.0,)
//                                            ),
//                                          ],
//                                        ),
//                                        Row(
//                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                          children: <Widget>[
//                                            Text("${decks[position].tests.length.toString()}", style: TextStyle(fontSize: 25.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w600 , color: CustomColors.black),),
//                                            Padding(
//                                                padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
//                                                child: Icon(Icons.thumbs_up_down, color: CustomColors.black, size: 20.0,)
//                                            ),
//                                          ],
//                                        ),
//                                      ],
//                                    )
//                                ),
//                                Padding(
//                                  padding: const EdgeInsets.all(8.0),
//                                  child: LinearProgressIndicator(
//                                    value: decks[position].deckCompletion,
//                                    backgroundColor: CustomColors.DeeppurlpleBackground,
//                                    valueColor: AlwaysStoppedAnimation<Color>(CustomColors.PurpleDark),),
//                                ),
//                              ],
//                            ),
//                          )
//                        ],
//                      ),
//                    ),
//                  ),
//                  shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(10.0),
//                  ),
//                ): Card(),
//                decoration: new BoxDecoration(boxShadow: [
//                ]),
//              ),
//            ),
//            onHorizontalDragEnd: (details) {
//              animationController = AnimationController(
//                  vsync: this, duration: Duration(
//                  milliseconds: 500));
//              curvedAnimation = CurvedAnimation(
//                  parent: animationController, curve: Curves
//                  .fastOutSlowIn);
//              animationController.addListener(() {
//                setState(() {
////                                currentColor = colorTween.evaluate(curvedAnimation);
//                });
//              });
//              if(details.velocity.pixelsPerSecond.dx > 0) {
//                if(deckIndex > 0) {
//                  deckIndex--;
////                  colorTween = ColorTween();
//                }
//              } else {
//                if (deckIndex < 2) {
//                  deckIndex ++;
////                  colorTween = ColorTween();
//                }
//              }
//              setState(() {
//                scrollController.animateTo(deckIndex*256.0, duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
//              }
//              );
//            }
//        );
//      },
//    );
  }
}
