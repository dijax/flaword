import 'package:flashcards/models/CardModel.dart';
import 'package:flashcards/models/card.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class FlipCardView extends StatefulWidget {
  final CardModel card;
  FlipCardView(this.card);
  _FlipCardViewState createState() => _FlipCardViewState();
}
class _FlipCardViewState extends State<FlipCardView>{
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30),
      child: getFlipCard(),
    );
  }

  Widget getFlipCard(){
      return FlipCard(
        key: cardKey,
        flipOnTouch: false,
        back: SizedBox(
          height: 400,
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
                    child: Text(widget.card?.back)),
              )
          ),
        ),
        front: SizedBox(
          height: 400,
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
                  child: Text(widget.card?.front)),
            ),
          ),
        ),
      );
//    return FlipCard(
//      key: cardKey,
//      flipOnTouch: false,
//      back: SizedBox(
//        height: 400,
//        child: InkWell(
//            onTap: () => cardKey.currentState.toggleCard(),
//            child: Container(
//              padding: EdgeInsets.all(20),
//              decoration: BoxDecoration(
//                  color: CustomColors.White,
//                  boxShadow: [
//                    BoxShadow(
//                      color: CustomColors.LightGrey,
//                      offset: Offset(5,5),
//                      blurRadius: 15,
//                    ),]),
//              child: Center(
//                  child: Text(cards.elementAt(_counter)?.front)),
//            )
//        ),
//      ),
//      front: SizedBox(
//        height: 400,
//        child: InkWell(
//          onTap: () => cardKey.currentState.toggleCard(),
//          child: Container(
//            padding: EdgeInsets.all(20),
//            decoration: BoxDecoration(
//              color: CustomColors.White,
//              boxShadow: [
//                BoxShadow(
//                  color: CustomColors.LightGrey,
//                  offset: Offset(5,5),
//                  blurRadius: 15,
//                ),
//              ],
//            ),
//            child: Center(
//                child: Text(cards?.elementAt(_counter)?.back)),
//          ),
//        ),
//      ),
//    );
  }

//  void pressed() {
//    setState(() {
//      if(_counter < cards.length-1) {
//        _counter++;
//        return;
//      }
//      print("done");
//    });
//  }

}
