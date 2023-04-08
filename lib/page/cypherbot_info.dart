import 'package:flutter/material.dart';

Column cypherbot_info(){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset("assets/images/what.png"),
      const Text("What is Cypherbot?" ,style: TextStyle(fontSize: 20, color: Color.fromRGBO(0, 219, 199, 1))),
      const Padding(
        padding: EdgeInsets.only(top: 10),
        child: Text("Mobile application for monitoring", style: TextStyle(color: Colors.blueGrey))),

      const Text("cryptocurrency price and arbitrage", style: TextStyle(color: Colors.blueGrey)),
      const Text("simulation.", style: TextStyle(color: Colors.blueGrey))

    ],
    );
}