import 'package:cypherbot/graph/bar.dart';
import 'package:cypherbot/graph/line.dart';
import 'package:cypherbot/services/cypher_database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});
  @override
  State<StatefulWidget> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  late List stats;
  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;
  late List<FlSpot> spots;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshStats();
    final barGroup1 = makeGroupData(0, 0, 0);
    final barGroup2 = makeGroupData(1, 0, 0);
    final barGroup3 = makeGroupData(2, 0, 0);
    final barGroup4 = makeGroupData(3, 0, 0);
    final barGroup5 = makeGroupData(4, 0, 0);
    final barGroup6 = makeGroupData(5, 0, 0);
    final barGroup7 = makeGroupData(6, 0, 0);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];
    final spot = [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
    ],
    rawBarGroups = items;
    showingBarGroups = rawBarGroups;
    spots = spot;

  }

  int checkDate(String day) {
    if (day == "Monday"){
      return 0;
    }
    else if (day == "Tuesday"){
      return 1;
    }
    else if (day == "Wednesday"){
      return 2;
    }
    else if (day == "Thursday"){
      return 3;
    }
    else if (day == "Friday"){
      return 4;
    }
    else if (day == "Saturday"){
      return 5;
    }
    else if (day == "Sunday"){
      return 6;
    }
    else{
      return 7;
    }
  }

  Future refreshStats() async {
    setState(() => isLoading = true);

    var items = [
      makeGroupData(0,0,0),
      makeGroupData(1,0,0),
      makeGroupData(2,0,0),
      makeGroupData(3,0,0),
      makeGroupData(4,0,0),
      makeGroupData(5,0,0),
      makeGroupData(6,0,0),
    ];
    List<FlSpot> spot = [];

    var now = DateTime.now();
    var day = checkDate(DateFormat("EEEE").format(now)) * -1;
    var start = now.add(Duration(days: day));


    stats = await CypherDatabase.instance.readChart();
    // stats = await CypherDatabase.instance.readAllStats();
    for (var stat in stats){
      var time = DateTime.parse(stat["createAt"]);
      var month = time.month;
      var date = time.day;
      var y = month + (day * 0.01);
      var weekday = DateFormat("EEEE").format(time);
      if (time.compareTo(now) <= 0 && time.compareTo(start) >= 0){
        items[checkDate(weekday)] = makeGroupData(checkDate(weekday), stat["initialMoney"]/1000000000, (stat["initialMoney"]+stat["profit"])/1000000000);
      }
      spot.add(FlSpot(y, stat["profit"]/10000000000));

    }
    showingBarGroups = items;
    spots = spot;

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(54, 63, 93, 1),
          // title: Text("${widget.money}, ${widget.provider}"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        backgroundColor: Color.fromRGBO(54, 63, 93, 1),
        body: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            barChart(showingBarGroups),
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Center(child:Text("Cumulative profit", style: TextStyle(color: Colors.white)),),
            ),
            lineChart(spots),
          ],
          )
          ));
  }
  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: Colors.blueGrey,
          width: 7,
        ),
        BarChartRodData(
          toY: y2,
          color: Colors.greenAccent,
          width: 7,
        ),
      ],
    );
  }
}