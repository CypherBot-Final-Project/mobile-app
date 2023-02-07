import 'package:flutter/material.dart';

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

    Widget menuSection = Row();
    Widget boxSection = Row();
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
          children: [_buildCard(), Center(child: Icon(Icons.construction, size: 200, color: Colors.white,))],
        ),
      ),
    ));
  }

  Center _buildCard() {
    return Center(
        child: Column(
      children: [
        Card(
          color: Color.fromARGB(255, 73, 109, 128),
          shadowColor: Colors.white,
          child: ExpansionTile(
            leading: const Icon(Icons.currency_bitcoin, color: Colors.white,),
            title: const Text(
              'Bitcoin',
              style: TextStyle(color: Colors.white),
            ),
            iconColor: Colors.white,
            children: <Widget>[
              Image.asset("assets/images/graph.png"),
            ],
          ),
        ),
        const Card(
          color: Color.fromARGB(255, 73, 109, 128),
          shadowColor: Colors.white,
          child: ExpansionTile(
            leading: Icon(Icons.diamond, color: Colors.white,),
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
