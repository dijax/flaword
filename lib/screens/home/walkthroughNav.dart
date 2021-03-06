import 'package:dots_indicator/dots_indicator.dart';
import 'package:flashcards/models/CardUnderstanding.dart';
import 'package:flashcards/models/deckModel.dart';
import 'package:flashcards/models/userModel.dart';
import 'package:flashcards/screens/home/completionStatistics.dart';
import 'package:flashcards/screens/home/statisticsPage.dart';
import 'package:flashcards/services/database.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flutter/material.dart';
class WalkthroughNav extends StatefulWidget {
  final UserModel user;

  const WalkthroughNav({Key key, this.user}) : super(key: key);
  @override
  _WalkthroughNavState createState() => _WalkthroughNavState();
}

class _WalkthroughNavState extends State<WalkthroughNav> {
  double _currentIndexPage;
  int _pageLength;
  List<DeckModel> decks = new List();
  List<ChartData> chartData = new List();
  List<int> clUnPrNo = new List(4);

  double _currentPosition = 0.0;

  @override
  void initState() {
    _currentIndexPage = 0;
    _pageLength = 2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const decorator = DotsDecorator(
      activeColor: CustomColors.White,
      activeSize: Size.square(15.0),
      activeShape: BeveledRectangleBorder(),
    );
    return Scaffold(
      backgroundColor: CustomColors.black,
      appBar: AppBar(
        title: Text("Statistics"),
        backgroundColor: CustomColors.black,
      ),
        body: Stack(
          children: <Widget>[
            PageView(
              children: <Widget>[
                StatisticsPage(user: widget.user,),
//                StreamBuilder<QuerySnapshot>(
//                    stream: DatabaseService(uid: widget.user.uid).deckCollection.document(widget.user.uid).collection("decks").snapshots(),
//                    builder: (context, snapshot) {
//                      decks = new List();
//                      if(snapshot.hasError)return Container();
//                      else if(snapshot.data == null)return Container();
//                      else {
//                        snapshot.data.documents.forEach((doc){
//                          decks.add(DeckModel().fromSnapshot(doc));
//                        });
//                        return CompletionStatisticsPage(decks: decks);
//                      }
//                    }
//                ),
//                CompletionStatisticsPage(user: widget.user,),
              FutureBuilder(
                future: DatabaseService(uid: widget.user.uid).getDecks(),
                builder: (_ , snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Text("Loading..."),
                    );
                  }else {
                    decks.clear();
                    for(int i = 0; i<snapshot.data.length; i++){
                      DeckModel deck = DeckModel().fromSnapshot(snapshot.data[i]);
                      decks.add(deck);
                    }
                    int clear = 0;
                    int problematic = 0;
                    int unsure = 0;
                    int none = 0;
                    decks.forEach((deck){
                      DatabaseService(uid: widget.user.uid).getCards(deck.deckId).then((snapshot){
                        for(int i= 0; i<snapshot.length; i++) {
                          if (snapshot[i]["cardUnderstanding"] == CardUnderstanding.clear.toString()){
                            clear ++;
                          }
                          if (snapshot[i]["cardUnderstanding"] == CardUnderstanding.none.toString()){
                            none ++;
                          }
                          if (snapshot[i]["cardUnderstanding"] == CardUnderstanding.problematic.toString()){
                            problematic ++;
                          }
                          if (snapshot[i]["cardUnderstanding"] == CardUnderstanding.unsure.toString()){
                            unsure ++;
                          }
                          chartData = [
                            ChartData('clear cards', clear.toDouble()),
                            ChartData('unsure cards', unsure.toDouble()),
                            ChartData('problematic cards', problematic.toDouble()),
                            ChartData('Others', none.toDouble())];
                        }
                      });

                    });

                  }
////                  return Container();
//                return (decks != null ) ? FutureBuilder(
//
//                ):Container();
                  return (decks!= null) ? CompletionStatisticsPage(user: widget.user, decks: decks, chartData: chartData,):Container();
                },
              ),
              ],
              onPageChanged: (value) {
                setState(() => _currentIndexPage = value.toDouble());
              },
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.75,
              left: MediaQuery.of(context).size.width * 0.5,
              child: Center(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: new DotsIndicator(
                    dotsCount: _pageLength,
                    position: _currentIndexPage,
                    decorator: decorator,
                  ),
                ),
              ),
            )
          ],
        ));
  }

    String getCurrentPositionPretty() {
      return (_currentPosition + 1.0).toStringAsPrecision(2);
    }
  }