import 'package:flutter/material.dart';
import 'package:candlesticks/candlesticks.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<List> fetchCandle(String name) async {
  final response = await http.get(Uri.parse("https://api.coingecko.com/api/v3/coins/$name/ohlc?vs_currency=thb&days=7"));
  if (response.statusCode == 200){
    List datas = json.decode(response.body);
    return datas;
  }
  else{
    throw("Failed to create Graph");
  }
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
      home: Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ), 
      ),
      backgroundColor: const Color.fromARGB(255, 14, 34, 53),
      body: FutureBuilder(
        
        future: futureGraph,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
          List datas = snapshot.data!;
          return createGraph(datas);
          }
          else{
            return const CircularProgressIndicator();
          }
        },
        ),
    )
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