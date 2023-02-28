import 'package:flutter/material.dart';
import 'package:flutter_tutorial_basic/post_result_model.dart';
import 'package:flutter_tutorial_basic/user_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PostResult postResult = null;
  User user = null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("HTTP API")),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text((user != null)
                // ignore: prefer_interpolation_to_compose_strings
                ? user.id + " | " + user.name
                : "Data not available"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      PostResult.connectToAPI("Wijaya", "Engineer")
                          .then((value) {
                        this.postResult = value;
                        setState(() {});
                      });
                    },
                    child: Text(
                      "POST",
                    )),
                ElevatedButton(
                    onPressed: () {
                      User.connectToAPI("5").then((value) {
                        this.user = value;
                        setState(() {});
                      });
                    },
                    child: Text(
                      "GET User",
                    )),
              ],
            )
          ],
        )),
      ),
    );
  }
}
