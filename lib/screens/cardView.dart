import 'package:flashcards/Test/mockData.dart';
import 'package:flashcards/models/CardModel.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class CardView extends StatefulWidget {
  final int index;
  CardView(this.index);
  _CardViewState createState() => _CardViewState();
}
class _CardViewState extends State<CardView> {
  int _counter = 0;
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  List<CardModel> cards;

  @override
  Widget build(BuildContext context) {
    cards = MockData.getDecksList().elementAt(widget.index).cards;
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Flashcards"), //TODO: Deck name dynamisch ändern
          backgroundColor: CustomColors.DeepBlue,
        ),
        backgroundColor: CustomColors.White,
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: FlipCard(
                key: cardKey,
                flipOnTouch: false,
                front: SizedBox(
                  height: 300,
                  child: InkWell(
                      onTap: () => cardKey.currentState.toggleCard(),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: CustomColors.White,
                            boxShadow: [
                              BoxShadow(
                                color: CustomColors.LightGrey,
                                offset: Offset(5,5),
                                blurRadius: 15,
                              ),]),
                        child: Center(
                            child: Text(cards.elementAt(_counter).front)),
                      )
                  ),
                ),
                back: SizedBox(
                  height: 300,
                  child: InkWell(
                    onTap: () => cardKey.currentState.toggleCard(),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: CustomColors.White,
                        boxShadow: [
                          BoxShadow(
                            color: CustomColors.LightGrey,
                            offset: Offset(5,5),
                            blurRadius: 15,
                          ),
                        ],
                      ),
                      child: Center(
                          child: Text(cards.elementAt(_counter).back)),
                    ),
                  ),
                ),
              ),
            ),
            RaisedButton(
              onPressed: pressed,
            ),
          ],
//
        )
    );
  }

  void pressed() {
    setState(() {
      if(_counter < cards.length-1) {
        _counter++;
        return;
      }
      print("done");
    });
  }
}
