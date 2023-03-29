import 'package:cypherbot/graph/bar.dart';
import 'package:cypherbot/graph/line.dart';
import 'package:cypherbot/services/cypher_database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'model/stat.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});
  @override
  State<StatefulWidget> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  late List<Stat> stats;
  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;
  bool isLoading = false;

  @override
  void initState() {

    refreshStats();
    
    super.initState();
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

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;

  }

  @override
  void dispose() {
    CypherDatabase.instance.close();

    super.dispose();
  }
  Future refreshStats() async {
    setState(() => isLoading = true);

    stats = await CypherDatabase.instance.readAllStats();
    for (var stat in stats){
      print(stat.profit);
    }

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