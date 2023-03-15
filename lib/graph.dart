import 'package:flutter/material.dart';
import 'package:candlesticks/candlesticks.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<List> fetchCandle(String name) async {
  List datas = [];
  List<int> days = [1,7,30,365];
  for (var i = 0; i < days.length; i++){
    int day = days[i];
    final response = await http.get(Uri.parse("https://api.coingecko.com/api/v3/coins/$name/ohlc?vs_currency=thb&days=$day"));
      if (response.statusCode == 200){
      List data = json.decode(response.body);
      datas.add(data);
    }
    else{
      throw("Failed to create Graph");
    }
  }
  return datas;
}

class Graph extends StatefulWidget {
  final String name;
  const Graph({super.key, required this.name});
  @override 
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  late Future<List> futureGraph;
  @override 
  void initState(){
    super.initState();
    futureGraph = fetchCandle(widget.name);
  }

  @override 
  Widget build(BuildContext context){
    return MaterialApp(
      theme: ThemeData.dark(),
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
          leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ), 
          bottom: const TabBar(
            tabs:  <Widget>[Tab(text:"1d"), Tab(text:"1w") , Tab(text:"1m") , Tab(text:"1y")],
            )
        ),
        backgroundColor: const Color.fromARGB(255, 14, 34, 53),
        body: FutureBuilder(
          future: futureGraph,
          builder:(context, snapshot) {
            if (snapshot.hasData){
              List allData = snapshot.data!;
              return TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [createGraph(allData[0]), createGraph(allData[1]), createGraph(allData[2]), createGraph(allData[3])]);
            }
            else{
              return const Center(child: CircularProgressIndicator(color:  Colors.greenAccent));
            }
          },)
      ))
    );

  }
  Candlesticks createGraph(datas){
    List<Candle> candles = [];
    for (var i = datas.length - 1; i >= 0; i--){
      List data = datas[i];
      DateTime time = DateTime.fromMillisecondsSinceEpoch(data[0]);
      double open = data[1].toDouble();
      double high = data[2].toDouble();
      double low = data[3].toDouble();
      double close = data[4].toDouble();
      Candle candle = Candle(date: time, open: open,high: high, low: low, close: close, volume: close-open);
      candles.add(candle);
    }
    return Candlesticks(candles: candles);
  }
}