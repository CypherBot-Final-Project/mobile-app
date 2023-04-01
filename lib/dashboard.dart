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
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshStats();
    final barGroup1 = makeGroupData(0, 5, 12);
    final barGroup2 = makeGroupData(1, 16, 12);
    final barGroup3 = makeGroupData(2, 18, 5);
    final barGroup4 = makeGroupData(3, 20, 16);
    final barGroup5 = makeGroupData(4, 17, 6);
    final barGroup6 = makeGroupData(5, 19, 1.5);
    final barGroup7 = makeGroupData(6, 10, 1.5);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    showingBarGroups = items;

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
      makeGroupData(0,0,0),
      makeGroupData(0,0,0),
      makeGroupData(0,0,0),
      makeGroupData(0,0,0),
      makeGroupData(0,0,0),
      makeGroupData(0,0,0),
    ];

    var now = DateTime.now();
    var start = now.add(const Duration(days: -6));


    stats = await CypherDatabase.instance.readBarChart();
    // stats = await CypherDatabase.instance.readAllStats();
    for (var stat in stats){
      var time = DateTime.parse(stat["createAt"]); 
      var weekday = DateFormat("EEEE").format(time);
      if (time.compareTo(now) <= 0 && time.compareTo(start) >= 0){
        items[checkDate(weekday)] = makeGroupData(checkDate(weekday), stat["initialMoney"]/1000000000, (stat["initialMoney"]+stat["profit"])/1000000000);
      }
    }
    showingBarGroups = items;

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 14, 34, 53),
          // title: Text("${widget.money}, ${widget.provider}"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 14, 34, 53),
        body: Column(
          children: [
            barChart(showingBarGroups),
            lineChart()
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