import 'dart:convert';
import 'package:http/http.dart' as http;

class Todo {
  String id;
  String title;
  String description;

  Todo({this.id, this.title, this.description});

  factory Todo.createTodo(Map<String, dynamic> object) {
    return Todo(
      id: object['id'].toString(),
      title: object['title'],
      description: object['description'],
    );
  }

  static const apiURL = 'http://10.0.2.2:5000';
  static Future<List<Todo>> getTodos() async {
    final url = Uri.parse("$apiURL/todos");

    var apiResult = await http.get(url);
    var resultJson = await json.decode(apiResult.body);

    List<Todo> todos = [];
    for (int i = 0; i < resultJson.length; i++) {
      todos.add(Todo.createTodo(resultJson[i]));
    }

    return todos;
  }
}
