import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Asset> fetchAsset() async {
  final response = await http
      .get(Uri.parse('https://api.coingecko.com/api/v3/coins/markets?vs_currency=thb'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    Iterable l = json.decode(response.body);
    return Asset.fromJson(l.first);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Asset {
  String name;
  String image;
  late int marketCap;
  late int totalVolume; 
  late double circulatingSupply; 
  late int high24hr;
  late int low24hr;
  late int marketCapRank;
  late double priceChange24hr;

  Asset({
      required this.name,
      required this.image,
      required this.marketCap,
      required this.totalVolume, 
      required this.circulatingSupply, 
      required this.high24hr,
      required this.low24hr,
      required this.marketCapRank,
      required this.priceChange24hr,
  });
  factory Asset.fromJson(Map<String, dynamic> json){
    return Asset(
      name: json['name'],
      image: json['image'],
      marketCap: json['market_cap'],
      totalVolume: json['total_volume'],
      circulatingSupply: json['circulating_supply'],
      high24hr: json['high_24h'],
      low24hr: json['low_24h'],
      marketCapRank: json['market_cap_rank'],
      priceChange24hr: json['price_change_24h'],
    );
  }
  
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Asset> futureAsset;

  @override
  void initState() {
    super.initState();
    futureAsset = fetchAsset();
  }

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
          children: [_buildCard(), Center(child: FutureBuilder<Asset>(
            future: futureAsset,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.name);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),)],
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
          color: const Color.fromARGB(255, 73, 109, 128),
          shadowColor: Colors.white,
          child: ExpansionTile(
            leading: Image.network("https://assets.coingecko.com/coins/images/279/large/ethereum.png?1595348880", height: 30, width: 30,),
            title: const Text(
              'Etheruem',
              style: TextStyle(color: Colors.white),
            ),
            iconColor: Colors.white,
            children: const <Widget>[
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