import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Image"),
        ),
        body: Center(
          child: Container(
            width: 48,
            height: 48,
            padding: EdgeInsets.all(3),
            child: Image(
              image: AssetImage("images/shield.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
