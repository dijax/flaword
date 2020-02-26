import 'package:flashcards/models/DeckModel.dart';
import 'package:flashcards/views/deckView.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flutter/material.dart';
import 'package:flashcards/Test/mockData.dart';

class DecksPage extends StatefulWidget {
  @override
  _DecksPageState createState() => _DecksPageState();
}

class _DecksPageState extends State<DecksPage> {
  List<DeckModel> decks = MockData.getDecksList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text("Decks",),
//        backgroundColor: Colors.black,
//      ),
      body: Container(
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
        padding: EdgeInsets.fromLTRB(10, 80, 10, 10),
        width: MediaQuery.of(context).size.width,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) => GestureDetector(
                        onTap: () {
                          MockData.setVisitDate(index, DateTime.now());
                          print(DateTime.now());
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => DeckView(decks[index], DateTime.now())));
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
                                    Container(
                                      width: 65,
                                      height: 65,
                                      child: Icon(Icons.library_books, color: Colors.black,),
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
                                    SizedBox(height: 10,),
                                    Text("${decks[index].deckTitle.toString().toUpperCase()}",
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: CustomColors.PurpleDark,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    SizedBox(height: 8,),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 40.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "${decks[index].cards.length.toString()} flashcards",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            "${decks[index].tests.length.toString()} tests",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
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
                              margin: EdgeInsets.all(10),
                              height: 150.0,
                            ),
                          ],
                        )
                      ),
                  childCount: 3
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}