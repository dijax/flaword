import 'dart:math';

import 'package:flashcards/models/CardModel.dart';
import 'package:flashcards/screens/flipCard.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardView extends StatefulWidget {
  final List<CardModel> cards;
  final int cardIndex;
  CardView(this.cards, this.cardIndex);
  _CardViewState createState() => _CardViewState();
}
class _CardViewState extends State<CardView> with TickerProviderStateMixin{
  Color _color = CustomColors.White;

  int _counter = 0;
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

//  @override
//  void initState() {
//    super.initState();
//    _controller = AnimationController(
//      duration: const Duration(seconds: 2),
//      vsync: this,
//    );
//    _offsetAnimation = Tween<Offset>(
//      begin: Offset.zero,
//      end: const Offset(1.5, 0.0),
//    ).animate(CurvedAnimation(
//      parent: _controller,
//      curve: Curves.easeOut
//    ));
//  }
//
//  @override
//  void dispose(){
//    super.dispose();
//    _controller.dispose();
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Flashcards"), //TODO: Deck name dynamisch ändern
          backgroundColor: CustomColors.DeepBlue,
        ),
        backgroundColor: CustomColors.White,
        body: Column(
          children: <Widget>[
            Expanded(
              child: AnimatedContainer(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: _color,
                ),

                duration: Duration(seconds: 1),
                curve: Curves.fastOutSlowIn,
                child: new Swiper(
                  itemBuilder: (BuildContext context, index) {
                    return getFlipCard(index);
                  },
                  index: widget.cardIndex,
                  itemCount: widget.cards.length,
                  itemWidth: 300.0,
                  itemHeight: 500.0,

                  layout: SwiperLayout.DEFAULT,
                ),

              ),
            ),

//            RaisedButton(
//              onPressed: pressed,
//            ),
            getIconsBar(),
          ],
        )
    );
  }

  Widget getFlipCard(int index){
    if(widget.cardIndex != null){
      return FlipCardView(widget.cards.elementAt(index));
    }
    return FlipCardView(widget.cards.elementAt(index));
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
              onPressed: (){
                setState(() {
                  final random = Random();
                  _color = Color.fromRGBO(random.nextInt(256), random.nextInt(256), random.nextInt(256), 1);
                });
              },
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
      if(_counter < widget.cards.length-1) {
        _counter++;
        return;
      }
      print("done");
    });
  }

}
