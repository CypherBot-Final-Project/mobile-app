import 'package:flutter/material.dart';
import 'package:show_up_animation/show_up_animation.dart';

final items = ["1","2","3"];

class Result extends StatefulWidget {
  final String money;
  final String provider;
  const Result(this.money, this.provider, {super.key});

  @override 
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result>{
  @override
  Widget build(BuildContext context){
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
        body: Container(
          padding: EdgeInsets.only(top:20),
          
          child: Column(
            children: [
              addShowUp(
              Center(
                child: Text(
                  "You get 1100฿ ", 
                  style: TextStyle(
                    color: Colors.white , 
                    fontWeight: FontWeight.bold, 
                    fontSize: 30)
                    ),
                  )),
              addShowUp(
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(150, 20, 20, 0),
                        child: Text(
                        "10%",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 30,
                          )
                      ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top:20),
                        child: Icon(Icons.arrow_upward_outlined, color: Colors.greenAccent, size: 30,),
                        )
                      ]
                    )
                  ),
                  addShowUp(
                  Padding(
                    padding: EdgeInsets.only(top:20),
                    child: Center(
                    child: Text(
                      "Time spending: 65 sec",
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 20,
                        )
                      ),
                    ),
                  )
                  ),
                  SizedBox(
                    height: 500,
                    width: 300,
                    child: Padding(
                      padding: EdgeInsets.only(top:20),
                      child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder:(context, index) {
                        return ShowUpAnimation(
                          delayStart: Duration(seconds: 1),
                          animationDuration: Duration(seconds: 2),
                          curve: Curves.bounceIn,
                          direction: Direction.vertical,
                          offset: 0.5,
                          child: _buildContainer(items[index])
                        );
                      },
                    )
                    )
                    )
                  
              ],
            )
        ),
        ),
    );
  }

  Column _buildContainer(String index){
    return Column(
      children: [
        _buildCard(index),
        Icon(Icons.arrow_downward_rounded, color: Colors.greenAccent,)
      ],
      );
  }

  Card _buildCard(String index){
    return Card(
      color: Colors.blueGrey,
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.currency_bitcoin),
            title: Text("TK$index"),
            subtitle: Text("1000"),
          ),
        ],
      )
    );
  }

  ShowUpAnimation addShowUp(Widget widget){
    return ShowUpAnimation(
      delayStart: Duration(seconds: 1),
      animationDuration: Duration(seconds: 1),
      curve: Curves.bounceIn,
      direction: Direction.vertical,
      offset: 0.5,
      child: widget
  );
}
}

