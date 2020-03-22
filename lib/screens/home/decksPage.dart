import 'package:flashcards/models/deckModel.dart';
import 'package:flashcards/models/userModel.dart';
import 'package:flashcards/screens/home/views/deckView.dart';
import 'package:flashcards/screens/home/widgets/settingsMenu.dart';
import 'package:flashcards/services/database.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wave_progress_widget/wave_progress.dart';

class DecksPage extends StatefulWidget{
  final UserModel user;
  DecksPage({this.user});

  @override
  _DecksPageState createState() => _DecksPageState();
}

class _DecksPageState extends State<DecksPage> with TickerProviderStateMixin{

  @override void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<DeckModel>>.value(
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
  final UserModel user;
  DecksList({this.user});

  @override
  _DecksListState createState() => _DecksListState();
}

class _DecksListState extends State<DecksList> {
  @override
  Widget build(BuildContext context) {
    final decks = Provider.of<List<DeckModel>>(context);
    return (decks!= null) ? Container(
      color: Colors.transparent,
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: decks.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index){
              return (!decks[index].isHidden)?GestureDetector(
                  onTap: () {
                    print(DateTime.now());
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => DeckView(deckId:decks[index].deckId,deckTitle: decks[index].title, visitDate:DateTime.now(), user: widget.user,)));
                  }, //TODO: the deck widget to implement
                  child: Stack(
                    children: <Widget>[
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
                                    child: WaveProgress(40, CustomColors.White, CustomColors.PurpleDark, decks[index].completion),
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
                                    list: decks[index],
                                    onSelect: (dynamic element, bool isHidden) {
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
                    ],
                  )
              ):Container();}
        ),
    ):Container();
  }
}