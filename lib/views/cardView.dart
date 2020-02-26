import 'package:flashcards/models/CardModel.dart';
import 'package:flashcards/models/CardUnderstanding.dart';
import 'package:flashcards/widgets/flipCard.dart';
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
  int _cardValue = 0;
  bool indexChanged = false;
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  void initState() {
    super.initState(); //TODO ??
    if(widget.cardIndex != null) _cardValue = widget.cardIndex;
    else _cardValue = 0;
  }
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
          backgroundColor: CustomColors.black,
        ),
        backgroundColor: CustomColors.White,
        body: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
//                duration: Duration(seconds: 2),
//                curve: Curves.fastOutSlowIn,
                children: <Widget>[
                  new Swiper(
                    itemBuilder: (BuildContext context, index) {
                      return getFlipCard(index);
                    },
                    index: swiperIndex(),
                    onIndexChanged: updateCardIndex,
                    itemCount: widget.cards.length,
                    itemWidth: 300.0,
                    itemHeight: 500.0,
                    layout: SwiperLayout.DEFAULT,
                  ),
                  Positioned(
                    right: 40,
                    top: 40,
                    child: getUnderstandingIcon(),
                  ),
                ],
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
                  widget.cards.elementAt(_cardValue).cardUnderstanding = CardUnderstanding.clear;
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
              onPressed: (){
                setState(() {
                  widget.cards.elementAt(_cardValue).cardUnderstanding = CardUnderstanding.unsure;
                });
              },
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
              onPressed: (){
                setState(() {
                  widget.cards.elementAt(_cardValue).cardUnderstanding = CardUnderstanding.problematic;
                });
              },
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

  Widget getUnderstandingIcon(){
    print(_cardValue);
    print(widget.cards.elementAt(_cardValue).cardUnderstanding);
    switch(widget.cards.elementAt(_cardValue).cardUnderstanding){
      case CardUnderstanding.clear:
        return Icon(Icons.sentiment_very_satisfied, size: 30,color: CustomColors.GreenAccent,);
        break;
      case CardUnderstanding.none:
//        print("no data");
        return Icon(Icons.sentiment_neutral, size: 30,color: CustomColors.White.withOpacity(0.1),);
        break;
      case CardUnderstanding.unsure:
        return Icon(Icons.sentiment_neutral, size: 30,color: CustomColors.OrangeIcon,);
        break;
      case CardUnderstanding.problematic:
        return Icon(Icons.sentiment_very_dissatisfied, size: 30,color: CustomColors.TrashRed,);
        break;
    }
    return Icon(Icons.sentiment_neutral, size: 30,color: CustomColors.White.withOpacity(0.1),);
  }

//  void pressed() {
//    setState(() {
////      if(_counter < widget.cards.length-1) {
////        _counter++;
//        return;
////      }
//      print("done");
//    });
//  }

  void updateCardIndex(int value) {
    setState(() {
      indexChanged = true;
      _cardValue = value;
    });
  }

  swiperIndex() {
    if(!indexChanged && widget.cardIndex!=0) return widget.cardIndex;
    else return _cardValue;
  }
}