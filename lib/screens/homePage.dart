import 'package:flashcards/Test/mockData.dart';
import 'package:flashcards/models/DeckModel.dart';
import 'package:flashcards/screens/settingsMenu.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  //TODO use the Random color generator
  final appColors = [Color.fromRGBO(231, 129, 109, 1.0),Color.fromRGBO(99, 138, 223, 1.0),Color.fromRGBO(111, 194, 173, 1.0)];
  int cardIndex = 0;
  ScrollController scrollController;
  var currentColor = Color.fromRGBO(231, 129, 109, 1.0);

  AnimationController animationController;
  ColorTween colorTween;
  CurvedAnimation curvedAnimation;
  List<DeckModel> decks = MockData.getDecksList();

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.DeepBlue,
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 10.0),
                    child: Icon(Icons.account_circle, size: 45.0, color: CustomColors.BlueCiel,),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 12.0),
                    child: Text("Hello, Dija.", style: TextStyle(fontSize: 30.0, color: CustomColors.BlueCiel, fontFamily: 'Montserrat', fontWeight: FontWeight.bold),),
                  ),
                  Text("Nice to see you again.", style:  TextStyle(fontSize: 16.0, color: Colors.white, fontFamily: 'Montserrat')),
                  Text("Keep the good work, keep learning.", style: TextStyle(fontSize: 16.0, color: Colors.white, fontFamily: 'Montserrat'),),
                ],
              ),
            ),
            Column(
              crossAxisAlignment:  CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 36.0, 24.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                    Text("Last used Decks", style: TextStyle(fontSize: 16.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w500, color: CustomColors.PurpleLight),),
                  ],)
                ),
                Container(
                  height: 300.0,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: decks.length,
                    controller: scrollController,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, position){
                      return GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0 , 8.0),
                            child: Container(
                              child: new Card(
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
//                                              child: Icon(Icons.fullscreen, color: Colors.black,),
                                            ),
                                            SettingsMenu(
                                                onDeckSelect: (List<DeckModel> decks) {
                                                  setState(() {
                                                    this.decks = decks;
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
                                              child: Text("${decks[position].deckTitle}", style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, fontFamily: 'Montserrat'), textAlign: TextAlign.center,),
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                                child:Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: <Widget>[
                                                        Text("${decks[position].cards.length.toString()}", style: TextStyle(color: CustomColors.BlueCiel, fontSize: 25.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w600 ),),
                                                        Padding(
                                                            padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                                            child: Icon(Icons.perm_media, color: CustomColors.BlueCiel, size: 20.0,)
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: <Widget>[
                                                        Text("${decks[position].tests.length.toString()}", style: TextStyle(fontSize: 25.0, fontFamily: 'Montserrat', fontWeight: FontWeight.w600 , color: CustomColors.BlueCiel),),
                                                        Padding(
                                                            padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                                                            child: Icon(Icons.thumbs_up_down, color: CustomColors.BlueCiel, size: 20.0,)
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: LinearProgressIndicator(
                                                value: decks[position].deckCompletion,
                                                backgroundColor: CustomColors.DeeppurlpleBackground,
                                                valueColor: AlwaysStoppedAnimation<Color>(CustomColors.PurpleLight),),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
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
                                currentColor = colorTween.evaluate(curvedAnimation);
                              });
                            });
                            if(details.velocity.pixelsPerSecond.dx > 0) {
                              if(cardIndex > 0) {
                                cardIndex--;
                                colorTween = ColorTween(begin: currentColor, end: appColors[cardIndex]);
                              }
                            } else {
                              if (cardIndex < 2) {
                                cardIndex ++;
                                colorTween = ColorTween(begin: currentColor, end: appColors[cardIndex]);
                              }
                            }
                            setState(() {
                              scrollController.animateTo(cardIndex*256.0, duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
                            }
                            );
                          }
                      );
                    },
                  ),
                )
              ],
            )
          ]
      ),
    );
  }
}