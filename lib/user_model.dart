import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  String id;
  String name;

  User({this.id, this.name});

  factory User.createUser(Map<String, dynamic> object) {
    return User(
        id: object['id'].toString(),
        name: object['first_name'] + " " + object['last_name']);
  }

  static Future<User> connectToAPI(String id) async {
    String apiURL = "https://reqres.in/api/users/" + id;

    var apiResult = await http.get(apiURL);
    var resultJson = await json.decode(apiResult.body);
    var userData = (resultJson as Map<String, dynamic>)['data'];
    return User.createUser(userData);
  }

  static Future<List<User>> getUsers(String page) async {
    String apiURL = "https://reqres.in/api/users?page=" + page;

    var apiResult = await http.get(apiURL);
    var resultJson = await json.decode(apiResult.body);
    List<dynamic> usersData = (resultJson as Map<String, dynamic>)['data'];

    List<User> users = [];
    for (int i = 0; i < usersData.length; i++) {
      users.add(User.createUser(usersData[i]));
    }

    return users;
  }
}
