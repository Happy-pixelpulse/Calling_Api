import 'package:clling_api/user_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<UserDetails> users = [];

  @override
  void initState() {
    super.initState();
    fetchUser();
  }
  List<UserDetails> parseUserDetails(dynamic responseBody) {
    final parsed =
    (responseBody as List).cast<Map<String, dynamic>>();

    return parsed.map<UserDetails>((json) => UserDetails.fromJson(json)).toList();
  }
  void fetchUser() async {
    const url = 'https://reqres.in/api/login';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    print(body);
    final json = jsonDecode(body);

    setState(() {
     users = parseUserDetails(json['data']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users List'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(users[index].name +
                '    ' +
                users[index].year.toString()),
            subtitle: Text(users[index].color),
          );
        },
      ),
    );
  }
}
