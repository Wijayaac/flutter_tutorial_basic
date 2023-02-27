import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int counter = 1;
  List<Widget> widgets = [];

  // _MyAppState() {
  //   for (var i = 0; i < 15; i++) {
  //     widgets.add(Text(
  //       "Data on-" + i.toString(),
  //       style: TextStyle(fontSize: 50),
  //     ));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("List view"),
        ),
        body: ListView(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widgets.add(Text(
                        "Data on-" + this.counter.toString(),
                        style: TextStyle(fontSize: 24),
                      ));
                      counter++;
                    });
                  },
                  child: Text("Add Data")),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widgets.removeLast();
                      counter--;
                    });
                  },
                  child: Text("Delete Data")),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widgets,
          )
        ]),
      ),
    );
  }
}
