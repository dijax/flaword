import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashcards/models/deckModel.dart';
import 'package:flashcards/models/userModel.dart';
import 'package:flashcards/screens/home/widgets/dropDownWidget.dart';
import 'package:flashcards/services/database.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CompletionStatisticsPage extends StatefulWidget {
  final UserModel user;
  final List<DeckModel> decks;
  final List<int> clUnPrNo;
  CompletionStatisticsPage ({this.user, this.decks, this.clUnPrNo});

  @override
  _CompletionStatisticsPageState createState() => _CompletionStatisticsPageState();
}

class _CompletionStatisticsPageState extends State<CompletionStatisticsPage>{
  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('clear cards', 25),
      ChartData('unsure cards', 38),
      ChartData('problematic cards', 34),
      ChartData('Others', 52)
    ];
    String deckId;

    var _queryCat;
    var _category;
    var dropDown;
    return Stack(
      children: <Widget>[
        Center(
            child: SfCircularChart(
                legend: Legend(
                  isVisible: true,
                  position: LegendPosition.left,
                  iconHeight: 30,
                  iconWidth: 30,
                  borderWidth: 30,
                  textStyle: ChartTextStyle(color: CustomColors.White),
                ),
                series: <CircularSeries>[
                  RadialBarSeries<ChartData, String>(
                      dataSource: chartData,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      // Corner style of radial bar segment
                      cornerStyle: CornerStyle.bothCurve,
                      trackColor: CustomColors.NearlyBlack,
                      trackBorderColor: CustomColors.PurpleIcon,
                      dataLabelSettings: DataLabelSettings(
                        // Renders the data label
                        isVisible: true,
                      )
                  )
                ]
            )
        ),
        Positioned(
          left : MediaQuery.of(context).size.width * 0.40,
          child: widget.decks!= null ? DropDownWidget(
              expand: false,
              decks: widget.decks,
              deckTitle: "",
              deckIsGiven : false,
              user: widget.user,
              onSelect:(String id) {
                deckId = id;
              }): Container(),
//          child: StreamBuilder<QuerySnapshot>(
//              stream: DatabaseService(uid: widget.user.uid).deckCollection.document(widget.user.uid).collection("decks").snapshots(),
//              builder: (context, snapshot) {
//                List<DeckModel> decks = new List();
//                if(snapshot.hasError)return Container();
//                else if(snapshot.data == null)return Container();
//                else {
//                  snapshot.data.documents.forEach((doc){
//                    decks.add(DeckModel().fromSnapshot(doc));
//                  });
//                  return DropDownWidget(
//                    expand: false,
//                      decks: decks,
//                      deckTitle: "",
//                      deckIsGiven : false,
//                      user: widget.user,
//                      onSelect:(String id) {
//                        deckId = id;
//                      }
//                  );
//                }
//              }
//          ),
        ),
      ],
    );
  }


  static List<SplineSeries<OrdinalSales, num>> getRandomData() {
    final dynamic chartData = <OrdinalSales>[
      OrdinalSales(100, 10),
      OrdinalSales(200, 20),
      OrdinalSales(300, 40),
      OrdinalSales(400, 30),
      OrdinalSales(500, 45),
      OrdinalSales(600, 50),
      OrdinalSales(700, 38),
      OrdinalSales(800, 10)
    ];

    return <SplineSeries<OrdinalSales, num>>[
      SplineSeries<OrdinalSales, num>(
          dataSource: chartData,
          color: const Color.fromRGBO(255, 0, 102, 1),
          xValueMapper: (OrdinalSales sales, _) => sales.year,
          yValueMapper: (OrdinalSales sales, _) => sales.sales,
          markerSettings: MarkerSettings(isVisible: true)),
    ];
  }
}

class SalesData {

  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

class OrdinalSales {
  OrdinalSales(this.year, this.sales);
  final num year;
  final int sales;
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color color;
}