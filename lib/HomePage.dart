import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> users = [];

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  void fetchUser() async {
    print('fetch user list');
    const url = 'https://reqres.in/api/login';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    print(body);
    final json = jsonDecode(body);
    setState(() {
      users = json['data'];
    });
    print('Task done');
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
            title: Text(users[index]['name'] +
                '    ' +
                users[index]['year'].toString()),
            subtitle: Text(users[index]['color']),
          );
        },
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   List<dynamic> users = [];
//
//   @override
//   void initState() {
//     super.initState();
//     fetchUser();
//   }
//
//   void fetchUser() async {
//     print('fetch user list');
//     const url = 'https://reqres.in/api/login';
//     final uri = Uri.parse(url);
//     final response = await http.get(uri);
//     final body = response.body;
//     final json = jsonDecode(body);
//     setState(() {
//       users = json['data'];
//     });
//     print('Task done');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Users List'),
//       ),
//       body: ListView.builder(
//         itemCount: users.length,
//         itemBuilder: (context, index) {
//           String name = users[index]['name'];
//           String formattedName = name.split(' ').map((word) {
//             return word.substring(0, 1).toUpperCase() + word.substring(1);
//           }).join(' ');
//
//           return ListTile(
//             title: Text(formattedName + '    ' + users[index]['year'].toString()),
//             subtitle: Text(users[index]['color']),
//           );
//         },
//       ),
//     );
//   }
// }
