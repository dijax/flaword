import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashcards/models/DeckModel.dart';
import 'package:flashcards/models/deck.dart';
import 'package:flashcards/models/user.dart';
import 'package:flashcards/services/database.dart';
import 'package:flashcards/views/deckView.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flashcards/widgets/settingsMenu.dart';
import 'package:flutter/material.dart';
import 'package:flashcards/Test/mockData.dart';
import 'package:provider/provider.dart';
import 'package:wave_progress_widget/wave_progress.dart';

class DecksPage extends StatefulWidget{
  final User user;
  DecksPage({this.user});

  @override
  _DecksPageState createState() => _DecksPageState();
}

class _DecksPageState extends State<DecksPage> with TickerProviderStateMixin{
  List<DeckModel> decks = MockData.getDecksList();

  @override void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<Deck>>.value(
      value: DatabaseService(uid: widget.user.uid).decks,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Decks",),
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(child: DecksList(user: widget.user,)),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}


class DecksList extends StatefulWidget {
  final User user;
  DecksList({this.user});

  @override
  _DecksListState createState() => _DecksListState();
}

class _DecksListState extends State<DecksList> {
  @override
  Widget build(BuildContext context) {
    var _progress = 50.0;
    final decks = Provider.of<List<Deck>>(context);
    return (decks!= null) ? Container(
      color: Colors.transparent,
//        decoration: BoxDecoration(
//          image: DecorationImage(
//            image: ExactAssetImage('assets/graphics/mountain.jpg'),
//            fit: BoxFit.cover,
//            colorFilter: ColorFilter.mode(
//                Colors.black.withOpacity(0.6),
//                BlendMode.dstIn
//            ),
//          ),
//
//        ),

      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: decks.length,
//    controller: scrollController,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index){
              return GestureDetector(
                  onTap: () {
                    MockData.setVisitDate(index, DateTime.now());
                    print(DateTime.now());
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => DeckView(deck:decks[index], visitDate:DateTime.now(), user: widget.user,)));
                  }, //TODO: the deck widget to implement
                  child: Stack(
                    children: <Widget>[

//                            Container(
//                              width: 382,
//                              height: 150,
//                              color: CustomColors.White,
//                            ),
//                            Container(
//                              width: 382,
//                              height: 155,
//                              color: CustomColors.White,
//                            ),
                      Container(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                    child: Icon(Icons.sentiment_neutral, color: CustomColors.White,),
                                  ),
                                  Container(
                                    width: 65,
                                    height: 65,
                                    child: WaveProgress(40, CustomColors.White, CustomColors.PurpleDark, _progress),
                                    decoration: const BoxDecoration(
                                      color: CustomColors.White,
                                      borderRadius: BorderRadius.all(Radius.circular(50.0),),
                                      boxShadow: [
                                        BoxShadow(
                                          color: CustomColors.LightGrey,
                                          offset: Offset(5,5),
                                          blurRadius: 15,
                                        )
                                      ],
                                    ),
                                  ),
                                  SettingsMenu(
                                    user: widget.user,
                                    list: decks,
                                    onSelect: (List<Object> newDecks, bool hidden) {
                                      setState(() {
//                                              if(hidden){decks.elementAt(index).hidden = true;}
//                                              decks = newDecks;
                                      });
                                    },
                                    index: index,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Text("${decks[index].title.toString().toUpperCase()}",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: CustomColors.PurpleDark,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              SizedBox(height: 8,),
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 40.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "${decks[index].cardsCount.toString()} flashcards",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            "${decks[index].testsCount.toString()} tests",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 0.0,
                              spreadRadius: 0.0,
                              offset: Offset(0.0,0.0),
                            ),
                          ],
                          color: Colors.white,
                        ),
                        margin: EdgeInsets.all(20),
                        height: 150.0,
                      ),
//                            padding: EdgeInsets.fromLTRB(120, 10, 20, 0),
                    ],
                  )
              );}
        ),

    ):Container();
  }
}