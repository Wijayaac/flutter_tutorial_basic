import 'package:flutter/material.dart';
import 'package:flutter_tutorial_basic/add_todo_page.dart';
import 'package:flutter_tutorial_basic/todo_modal.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> todoList = [];

  _HomePageState() {
    Todo.getTodos().then((todos) {
      for (var todo in todos) {
        todoList.add(Container(
          width: 500,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          color: Colors.grey[100],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("id : ${todo.id}"),
              Text("Title : ${todo.title}"),
              Text("Description : ${todo.description}"),
            ],
          ),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[Column(children: todoList)],
          ),
          Align(
            alignment: Alignment(0.9, 0.95),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AddTodoPage();
                  }));
                },
                child: Image(image: AssetImage("images/add.png"))),
          )
        ],
      ),
    );
  }
}
