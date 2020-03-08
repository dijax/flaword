import 'package:flashcards/models/user.dart';
import 'package:flashcards/utils/customColors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticsPage extends StatefulWidget {
  final User user;
  StatisticsPage({this.user});

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage>{
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      backgroundColor: Colors.black,
      zoomPanBehavior: ZoomPanBehavior(enablePanning: true),
      title: ChartTitle(
        text: 'Statistics',
        textStyle: ChartTextStyle(color: CustomColors.NotWhite),
        alignment: ChartAlignment.center,
        borderColor: Colors.transparent,
        borderWidth: 30
      ),
      legend: Legend(
        position: LegendPosition.bottom,
        borderColor: Colors.white,
        borderWidth: 0
      ),
      primaryXAxis: NumericAxis(
        visibleMinimum: 300,
        visibleMaximum: 500,
        title: AxisTitle(
          text: 'Learning',
          textStyle: ChartTextStyle(color: Colors.white),
          alignment: ChartAlignment.center,
        ),
      ),
      primaryYAxis: NumericAxis(
        labelStyle: ChartTextStyle(color: Colors.white),
//        title: AxisTitle(
//          text: 'Hours',
//          textStyle: ChartTextStyle(color: Colors.white),
//          alignment: ChartAlignment.center,
//        ),
      ),
      series: getRandomData(),
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

