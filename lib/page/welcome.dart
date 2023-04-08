import 'package:flutter/material.dart';

Column welcome() {
  return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/images/icon.png"),
        Text("Welcome to Cypherbot", style: TextStyle(fontSize: 20, color: Color.fromRGBO(0, 219, 199, 1))),
      ]
    );
}