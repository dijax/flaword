import 'package:flashcards/models/CardUnderstanding.dart';
import 'package:flashcards/models/cardModel.dart';
import 'package:flashcards/models/userModel.dart';
import 'package:flashcards/services/database.dart';
import 'package:flashcards/screens/home/widgets/flipCard.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardView extends StatefulWidget {
  final UserModel user;
  final List<CardModel> cards;
  final int cardIndex;
  CardView({this.cards, this.cardIndex, this.user});
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CardView> with TickerProviderStateMixin{
  int _cardValue = 0;
  String title;
  bool indexChanged = false;
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  void initState() {
    super.initState();
    if(widget.cardIndex != null) _cardValue = widget.cardIndex;
    else _cardValue = 0;
    title = widget.cards[_cardValue].title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title), //TODO: Deck name dynamisch ändern
          backgroundColor: CustomColors.black,
        ),
        backgroundColor: CustomColors.White,
        body: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
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
                DatabaseService(uid: widget.user.uid, deck_Id: widget.cards[_cardValue].deckId)
                    .updateCardUnderstanding(widget.cards[_cardValue].cardId, CardUnderstanding.clear);
                setState(() {
                  widget.cards[_cardValue].setCardUnderstanding(CardUnderstanding.clear);
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
                DatabaseService(uid: widget.user.uid, deck_Id: widget.cards[_cardValue].deckId)
                    .updateCardUnderstanding(widget.cards[_cardValue].cardId, CardUnderstanding.unsure);
                setState(() {
                  widget.cards[_cardValue].setCardUnderstanding(CardUnderstanding.unsure);
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
                DatabaseService(uid: widget.user.uid, deck_Id: widget.cards[_cardValue].deckId)
                    .updateCardUnderstanding(widget.cards[_cardValue].cardId, CardUnderstanding.problematic);
                setState(() {
                  widget.cards[_cardValue].setCardUnderstanding(CardUnderstanding.problematic);
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
    CardUnderstanding cardUnderstanding = enumFromString(widget.cards.elementAt(_cardValue).cardUnderstanding);
    switch(cardUnderstanding){
      case CardUnderstanding.clear:
        return Icon(Icons.sentiment_very_satisfied, size: 30,color: CustomColors.GreenAccent,);
        break;
      case CardUnderstanding.none:
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

  void updateCardIndex(int value) {
    setState(() {
      indexChanged = true;
      _cardValue = value;
      title = widget.cards[_cardValue].title;
    });
  }

  swiperIndex() {
    if(!indexChanged && widget.cardIndex!=0) return widget.cardIndex;
    else return _cardValue;
  }
}
