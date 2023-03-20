import 'dart:async';
import 'dart:convert';
import 'package:cypherbot/dashboard.dart';
import 'package:cypherbot/graph.dart';
import 'package:cypherbot/result.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cypherbot/model/asset.dart';

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


void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List> futureData;
  String dropdownvalue = "dydx";
  final money = TextEditingController();
  var items = ["dydx", "uniswaps"];
  

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
              "Arbitrage simulation bot",
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
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
            padding: const EdgeInsets.all(15),
            labelStyle:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(10), // Creates border
                color: Colors.greenAccent),
            tabs: const <Widget>[Tab(text: "Coins"), Tab(text: "Bot")],
          ),
        ),
        backgroundColor: color,
        body: TabBarView(
          
          children: [
            Container(
              padding: const EdgeInsets.all(10), child: _cardContainer()
            ), 
            Container(
              
              child: Builder(builder: (context) => botScreen(context),)
            )
          ],
        ),
      ),
    ));
  }

  Center _cardContainer() {
    return Center(
        child: FutureBuilder(
        future: futureData,
        builder: ((context, snapshot) {
          if (snapshot.hasData){
            List assets = snapshot.data!;
            return ListView.builder(
              itemCount: assets.length,
              itemBuilder: ((context, index) {
                Asset asset = Asset.fromJson(assets[index]);
                return _buildCard(asset, context);
              })
              );
            }
          else{
            return const CircularProgressIndicator(color:  Colors.greenAccent);
          }
          }
        )
        ));
  }

  Card _buildCard(Asset asset, BuildContext context){
    double marketCap = asset.marketCap;
    double totalVolume = asset.totalVolume;
    double circulatingSupply = asset.circulatingSupply;
    double high24hr = asset.high24hr;
    double low24hr = asset.low24hr;
    int marketCapRank = asset.marketCapRank;
    double priceChange24hr = asset.priceChange24hr;
    return Card(
          color: Colors.blueGrey,
          shadowColor: Colors.white,
          child: ExpansionTile(
            leading: Image.network(asset.image, height: 30, width: 30,),
            title: Text(
              asset.name,
              style: const TextStyle(color: Colors.white),
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
              ElevatedButton(
                onPressed: (){
                  Navigator.push( context,
                  MaterialPageRoute(builder: (context) => Graph(name: asset.id)),
                  );
                }, 
                child: const Text("see graph"))
            ],
          ),
        );
  }

  Center botScreen(BuildContext context) {
  return Center(
      child: Column(
    children: [
      const Icon(Icons.android, size: 100, color: Colors.white),
      Row(children: [
        Padding(
            padding: EdgeInsets.fromLTRB(50, 0, 40, 0),
            child: Text(
              "Money: ",
              style: TextStyle(color: Colors.white, fontSize: 20),
              textAlign: TextAlign.center,
            )),
        SizedBox(
          height: 40,
          width: 200,
          child: TextField(
            style: TextStyle(color: Colors.greenAccent),
            controller: money,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.currency_exchange),
              contentPadding: EdgeInsets.all(5),
              filled: true,
              fillColor: Colors.blueGrey,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.greenAccent)),
            ),
          ),
        )
      ]),
      Padding(
        padding: EdgeInsets.only(top: 20),
        child: Row(children: [
          Padding(
              padding: EdgeInsets.fromLTRB(50, 0, 30, 0),
              child: Text(
                "Provider: ",
                style: TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.center,
              )),
          Container(
              height: 40,
              width: 200,
              decoration: BoxDecoration(color: Colors.greenAccent),
              child: DropdownButton(
                items: items.map((String items) {
                  return DropdownMenuItem(
                    alignment: AlignmentDirectional.center,
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                value: dropdownvalue,
                onChanged: (value) => {
                  setState(()=> {
                    dropdownvalue = value!
                  })
                },
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down),
              
              ))
        ]),
      ),
      Padding(
          padding: EdgeInsets.only(top: 40),
          child: SizedBox(
              height: 50,
              width: 300,
              child: ElevatedButton(
                onPressed: () => {
                  Navigator.push( context,
                  MaterialPageRoute(builder: (context) => Result(money.text, dropdownvalue)),
                  )
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Colors.greenAccent),
                ),
                child: Text("Start Arbitrage",
                    style: TextStyle(color: Color.fromARGB(255, 14, 34, 53))),
              ))),
      Padding(
          padding: EdgeInsets.only(top: 20),
          child: SizedBox(
              height: 50,
              width: 300,
              child: ElevatedButton(
                onPressed: () => {
                  Navigator.push( context,
                  MaterialPageRoute(builder: (context) => DashBoard()),
                  )
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Colors.blueGrey),
                ),
                child: Text("View my stat",
                    style: TextStyle(color: Colors.greenAccent)),
              )))
            ],
          ));
        }
}