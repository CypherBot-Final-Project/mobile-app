import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List> fetchData() async {
  final response = await http
      .get(Uri.parse('https://api.coingecko.com/api/v3/coins/markets?vs_currency=thb'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List result = json.decode(response.body);
    return result;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}


class Asset {
  String name;
  String image;
  late double marketCap;
  late double totalVolume; 
  late double circulatingSupply; 
  late double high24hr;
  late double low24hr;
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
      marketCap: json['market_cap'].toDouble(),
      totalVolume: json['total_volume'].toDouble(),
      circulatingSupply: json['circulating_supply'].toDouble(),
      high24hr: json['high_24h'].toDouble(),
      low24hr: json['low_24h'].toDouble(),
      marketCapRank: json['market_cap_rank'],
      priceChange24hr: json['price_change_24h'].toDouble(),
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
  late Future<List> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
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
          children: [_cardContainer(), Center(child: Icon(Icons.construction, size: 200, color: Colors.white,))],
        ),
      ),
    ));
  }

  Center _cardContainer() {
      
    return Center(
        child: FutureBuilder(
        future: futureData,
        builder: ((context, snapshot) {
          List assets = snapshot.data!;
          return ListView.builder(
            itemCount: assets.length,
            itemBuilder: ((context, index) {
              Asset asset = Asset.fromJson(assets[index]);
              return _buildCard(asset.name, asset.image, asset.marketCap, asset.totalVolume, asset.circulatingSupply, asset.high24hr, asset.low24hr,asset.marketCapRank, asset.priceChange24hr);
            })
            );
        })
        ));
  }

  Card _buildCard(String name, String image ,double marketCap, double totalVolume, double circulatingSupply, double high24hr, double low24hr, int marketCapRank, double priceChange24hr){
    return Card(
          color: const Color.fromARGB(255, 73, 109, 128),
          shadowColor: Colors.white,
          child: ExpansionTile(
            leading: Image.network(image, height: 30, width: 30,),
            title: Text(
              name,
              style: TextStyle(color: Colors.white),
            ),
            iconColor: Colors.white,
            children: <Widget>[
              Text("Market Capital: $marketCap"),
              Text("Total Volume: $totalVolume"),
              Text("Circulating Supply: $circulatingSupply"),
              Text("High price in 24hrs: $high24hr"),
              Text("Low price in 24hrs: $low24hr"),
              Text("Market Capital Rank: $marketCapRank"),
              Text("Prince change in 24hrs: $priceChange24hr"),
            ],
          ),
        );
  }


}