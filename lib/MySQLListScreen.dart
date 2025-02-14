import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/students.dart';  // Import the User model

class MySQLListScreen extends StatefulWidget {
  @override
  _MySQLListScreenState createState() => _MySQLListScreenState();
}

class _MySQLListScreenState extends State<MySQLListScreen> {
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse("https://mrsmbetongsarawak.edu.my/emerit/api/get_data.php"));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      setState(() {
        users = jsonResponse.map((data) => User.fromJson(data)).toList();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Users List")),
      body: users.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(child: Text(users[index].id.toString())),
            title: Text(users[index].name),
            subtitle: Text(users[index].college_number),
          );
        },
      ),
    );
  }
}