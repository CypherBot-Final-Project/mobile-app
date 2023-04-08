import 'package:flutter/material.dart';

Column graph_feature(){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset("assets/images/graph_feature.png"),
      const Text("Monitoring and Graph Visualize", style: TextStyle(fontSize: 20, color: Color.fromRGBO(0, 219, 199, 1))),
      const Padding(
        padding: EdgeInsets.only(top: 10),
        child: Text("We provide over 100 assets data", style: TextStyle(color: Colors.blueGrey))
      ),
      const Text("and a candlestick graph for each asset.", style: TextStyle(color: Colors.blueGrey)),
    ],
    );
}