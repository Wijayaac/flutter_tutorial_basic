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
  String output = "No user lists";

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
            Text(output),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      User.getUsers("1").then((users) {
                        output = "";
                        for (int i = 0; i < users.length; i++) {
                          output = output + "[ " + users[i].name + " ]";
                        }
                        setState(() {});
                      });
                    },
                    child: Text(
                      "Get all users",
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
