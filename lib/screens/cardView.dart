import 'package:flashcards/Test/mockData.dart';
import 'package:flashcards/models/CardModel.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class CardView extends StatefulWidget {
  final int deckIndex;
  final int cardIndex;
  CardView(this.deckIndex, this.cardIndex);
  _CardViewState createState() => _CardViewState();
}
class _CardViewState extends State<CardView> with TickerProviderStateMixin{
  int _counter = 0;
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  List<CardModel> cards;
  AnimationController animationController;
  Animation<double> rotate;
  Animation<double> right;
  Animation<double> bottom;

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(duration: Duration(milliseconds: 1000), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    cards = MockData.getDecksList().elementAt(widget.deckIndex).cards;
    rotate = new Tween<double>(
     begin: -0.0, // specifies where the animation starts
      end: -40.0, // and where it ends
    ).animate(new CurvedAnimation(parent: animationController, curve: Curves.ease),);
    rotate.addListener((){});

    right = new Tween<double>(
     begin: 0.0,
      end: 400.0,
    ).animate(new CurvedAnimation(parent: animationController, curve: Curves.ease),);
    rotate.addListener((){});

    rotate = new Tween<double>(
     begin: 15.0,
      end: 100.0,
    ).animate(new CurvedAnimation(parent: animationController, curve: Curves.ease),);
    rotate.addListener((){});

    return Scaffold(
        appBar: AppBar(
          title: Text("Flashcards"), //TODO: Deck name dynamisch ändern
          backgroundColor: CustomColors.DeepBlue,
        ),
        backgroundColor: CustomColors.White,
        body: Column(
          children: <Widget>[
            new Transform(
              alignment: Alignment.bottomLeft,
              transform: Matrix4.skewX(50.0),
              child: new RotationTransition(
                  turns: AlwaysStoppedAnimation(-50/360),
                  child: new GestureDetector(
                    onTap: (){},
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: getFlipCard(),
                    ),
                  )),
            ),

//            RaisedButton(
//              onPressed: pressed,
//            ),
            getIconsBar(),
          ],
        )
    );
  }

  Widget getFlipCard(){
    if(widget.cardIndex != null){
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
                    child: Text(cards.elementAt(widget.cardIndex)?.front)),
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
                  child: Text(cards?.elementAt(widget.cardIndex)?.back)),
            ),
          ),
        ),
      );
    }
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
                  child: Text(cards.elementAt(_counter)?.front)),
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
                child: Text(cards?.elementAt(_counter)?.back)),
          ),
        ),
      ),
    );
  }

  Widget getIconsBar(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(width: 1,),
        Column(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.sentiment_very_satisfied, size: 50, color: CustomColors.GreenAccent,),
              onPressed: (){},
            ),
            SizedBox(height: 8,),
            Padding(
              padding: EdgeInsets.fromLTRB(14, 0, 0, 0),
              child: Text("clear", textAlign: TextAlign.center, style: TextStyle(color: CustomColors.Grey),),
            ),
          ],
        ),
        Column(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.sentiment_neutral, size: 50, color: CustomColors.OrangeIcon),
              onPressed: (){},
            ),
            SizedBox(height: 8,),
            Padding(
              padding: EdgeInsets.fromLTRB(14, 0, 0, 0),
              child: Text("unsure", textAlign: TextAlign.center, style: TextStyle(color: CustomColors.Grey),),
            ),
          ],
        ),
        Column(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.sentiment_very_dissatisfied, size: 50, color: CustomColors.TrashRed),
              onPressed: (){},
            ),
            SizedBox(height: 8,),
            Padding(
              padding: EdgeInsets.fromLTRB(14, 0, 0, 0),
              child: Text("unclear", textAlign: TextAlign.center, style: TextStyle(color: CustomColors.Grey),),
            ),
          ],
        ),
        SizedBox(width: 1,),
      ],
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

  Future<Null> _swipeAnimation() async {
    try{
      await animationController.forward();
    } on TickerCanceled{}
  }
}
