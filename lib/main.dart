import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Widget titleSection = Row(
      children: [
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              padding: const EdgeInsets.only(bottom: 15),
              child: const Text(
                "CypherBot",
                style: TextStyle(
                    color: Color.fromRGBO(0, 237, 158, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 50),
              ),
            ),
            const Text(
              "Arbitrage trading bot",
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            )
          ]),
        )
      ],
    );
    Color color = const Color.fromARGB(255, 14, 34, 53);
    return MaterialApp(
        theme: ThemeData(fontFamily: "Oxygen"),
        home: DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: titleSection,
          titleSpacing: 30,
          toolbarHeight: 200,
          backgroundColor: color,
          bottom: TabBar(
            labelStyle:
                const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(20), // Creates border
                color: Colors.greenAccent),
            tabs: const <Widget>[Tab(text: "Coins"), Tab(text: "Bot")],
          ),
        ),
        backgroundColor: color,
        body: TabBarView(
          children: [_buildCard(), const Center(child: Icon(Icons.construction, size: 200, color: Colors.white,))],
        ),
      ),
    ));
  }

  Center _buildCard() {
    return Center(
        child: Column(
      children: [
        Card(
          color: const Color.fromARGB(255, 73, 109, 128),
          shadowColor: Colors.white,
          child: ExpansionTile(
            leading: Image.network("https://assets.coingecko.com/coins/images/1/large/bitcoin.png", height: 30, width: 30,),
            title: const Text(
              'Bitcoin',
              style: TextStyle(color: Colors.white),
            ),
            iconColor: Colors.white,
            children: <Widget>[
              Image.network("https://assets.coingecko.com/coins/images/1/small/bitcoin.png"),
            ],
          ),
        ),
        Card(
          color: Color.fromARGB(255, 73, 109, 128),
          shadowColor: Colors.white,
          child: ExpansionTile(
            leading: Image.network("https://assets.coingecko.com/coins/images/279/large/ethereum.png?1595348880", height: 30, width: 30,),
            title: Text(
              'Etheruem',
              style: TextStyle(color: Colors.white),
            ),
            iconColor: Colors.white,
            children: <Widget>[
              Text('Big Bang'),
              Text('Birth of the Sun'),
              Text('Earth is Born'),
              Text("I wanna finish Project")
            ],
          ),
        ),
      ],
    ));
  }
}
