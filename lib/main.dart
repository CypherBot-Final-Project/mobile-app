import 'package:cypherbot/page/bot_feature.dart';
import 'package:cypherbot/page/cypherbot_info.dart';
import 'package:cypherbot/page/get_started.dart';
import 'package:cypherbot/page/graph_feature.dart';
import 'package:cypherbot/page/welcome.dart';
import 'package:flutter/material.dart';
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cypherbot',
      theme: ThemeData(fontFamily: "Oxygen"),
      home: const Info(),
    );
  }
}

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> with SingleTickerProviderStateMixin {
  late final TabController controller;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 5, initialIndex: _index, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(54, 63, 93, 1),
      // Building UI
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          TabBarView(controller: controller, children: <Widget>[
            welcome(),
            cypherbot_info(),
            graph_feature(),
            bot_feature(),
            get_started(context),
          ]),
          Positioned(
            bottom: 40,
            child: TabPageSelector(
              color: const Color.fromRGBO(54, 63, 93, 1),
              selectedColor: const Color.fromRGBO(0, 219, 199, 1),
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}
