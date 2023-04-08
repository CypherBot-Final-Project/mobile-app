import 'package:flutter/material.dart';

Column bot_feature(){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset("assets/images/bot.png"),
      const Text("Arbitrage Simulator",style: TextStyle(fontSize: 20, color: Color.fromRGBO(0, 219, 199, 1))),
      const Padding(
        padding: EdgeInsets.only(top: 10),
        child: Text("Derived from Defi-PoserARB,", style: TextStyle(color: Colors.blueGrey))
      ),
      const Text("The simulation that will show you", style: TextStyle(color: Colors.blueGrey)),
      const Text("the opportunity for arbitrage", style: TextStyle(color: Colors.blueGrey)),
      const Text("on the ethereum chain.", style: TextStyle(color: Colors.blueGrey)),
      const Padding(
        padding: EdgeInsets.only(top:10),
        child: Text("* Note that the bot is still under working", style: TextStyle(color: Colors.black)),
      ),
      const Text("so all the result will be mock. *", style: TextStyle(color: Colors.black)),
    ],
    );
}