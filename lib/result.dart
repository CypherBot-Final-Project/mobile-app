import 'package:cypherbot/services/cypher_database.dart';
import 'package:flutter/material.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'model/stat.dart';

Future<Map<String, dynamic>> fetchData(String money, String provider) async {
  String uri = "https://cypherbot-backup.up.railway.app/arbitrage?money=$money&provider=$provider";
  final response = await http.post(
      Uri.parse(uri));
  Map<String, dynamic> datas = json.decode(response.body);
  return datas;
}

class Result extends StatefulWidget {
  final String money;
  final String provider;
  const Result(this.money, this.provider, {super.key});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  late Future<Map<String, dynamic>> futureData;
  late Stat stats;
  @override
  void initState() {
    super.initState();
    futureData = fetchData(widget.money, widget.provider);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "Oxygen"),
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
          body: FutureBuilder(
            future: futureData,
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                Map<String, dynamic> data = snapshot.data!;
                String total_profit = data["total_profit"].toStringAsFixed(5);
                String total_percentage = data["total_percentage"].toStringAsFixed(2);
                String time_spending = data["time_spending"].toStringAsFixed(1);
                stats = Stat(provider: widget.provider, createAt: DateTime.now(), profit: data["total_profit"], initialMoney: double.parse(widget.money) );
                List list_token = data["list_token"];
                return Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        addShowUp(Center(
                          child: Text("You get $total_profit฿ ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30)),
                        )),
                        addShowUp(Row(children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(150, 20, 0 , 0),
                            child: Text("$total_percentage%",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 30,
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 30),
                            child: Icon(
                              Icons.arrow_drop_up,
                              color: Colors.greenAccent,
                              size: 55,
                            ),
                          )
                        ])),
                        addShowUp(Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Center(
                            child: Text("Time spending: $time_spending sec",
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 20,
                                )),
                          ),
                        )),
                        SizedBox(
                            height: 500,
                            width: 300,
                            child: Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: ListView.builder(
                                  itemCount: list_token.length,
                                  itemBuilder: (context, index) {
                                    return ShowUpAnimation(
                                        delayStart: Duration(seconds: 1),
                                        animationDuration: Duration(seconds: 2),
                                        curve: Curves.bounceIn,
                                        direction: Direction.vertical,
                                        offset: 0.5,
                                        child: _buildContainer(list_token[index], (index == list_token.length -1)));
                                  },
                                )))
                      ],
                    ));
              }
              else{
                return const Center(child:CircularProgressIndicator(color:  Colors.greenAccent));
              }
            }),
          )),
    );
  }

  Column _buildContainer(Map<String, dynamic> item, bool end) {
    if (end){
      return Column(
      children: [
        _buildCard(item),
        Icon(
          Icons.arrow_downward_rounded,
          color: Colors.greenAccent,
        ),
        ElevatedButton(
          onPressed: (() {
            _save(stats);
          }), 
          style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Colors.greenAccent),
                ),
                child: Text("Save Result",
                    style: TextStyle(color: Color.fromARGB(255, 14, 34, 53))),
        )
      ],
    );
    }
    return Column(
      children: [
        _buildCard(item),
        Icon(
          Icons.arrow_downward_rounded,
          color: Colors.greenAccent,
        )
      ],
    );
  }
  void _save (Stat stat) async{
    await CypherDatabase.instance.createStat(stat);
    Navigator.of(context).pop();

  }

  Card _buildCard(Map<String, dynamic> item) {
    return Card(
        color: Colors.blueGrey,
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.currency_bitcoin),
              title: Text(item["token_name"]),
              subtitle: Text("${item["value"].toString()}฿"),
            ),
          ],
        ));
  }

  ShowUpAnimation addShowUp(Widget widget) {
    return ShowUpAnimation(
        delayStart: Duration(seconds: 1),
        animationDuration: Duration(seconds: 1),
        curve: Curves.bounceIn,
        direction: Direction.vertical,
        offset: 0.5,
        child: widget);
  }
}
