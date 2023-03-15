import 'package:flutter/material.dart';

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
      home: Scaffold(
        appBar: AppBar(
          title: Text("${widget.money}, ${widget.provider}"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          )
        ),
    );
  }
}

