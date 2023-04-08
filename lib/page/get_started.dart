import 'package:cypherbot/landing.dart';
import 'package:flutter/material.dart';

Column get_started(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset("assets/images/start.png"),
      const Text("And now you're ready!" ,style: TextStyle(fontSize: 20, color: Color.fromRGBO(0, 219, 199, 1))),
      const Padding(
        padding: EdgeInsets.only(top:10),
        child: Text("If you enjoy using our app, please give it a review", style: TextStyle(color: Colors.blueGrey)),
        ),
      const Text("and ratings ;). It's mean a lot to us.", style: TextStyle(color: Colors.blueGrey)),
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ElevatedButton(
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Landing()),
          )
        },
        style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(Color.fromRGBO(0, 219, 199, 1)),
        ),
        child: const Text("Get Started!",
            style: TextStyle(color: Color.fromARGB(255, 14, 34, 53))),
      )
      ),
      
    ],
  );
}
