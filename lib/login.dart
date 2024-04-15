// import 'package:flutter/material.dart';
//
// class Login extends StatefulWidget {
//   const Login({super.key});
//
//   @override
//   State<Login> createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.only(left: 20, right: 20),
//         child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15),
//             ),
//             padding: const EdgeInsets.symmetric(
//               horizontal: 100,
//             ),
//             backgroundColor: Color.fromRGBO(64, 82, 224, 1),
//           ),
//           onPressed: () {
//
//           },
//           child: Text("Submit"),
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'HomePage.dart';
//import 'HomePage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leadingWidth: 100,
        leading: GestureDetector(
          child: const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Row(
              children: [
                Icon(Icons.arrow_back_ios, color: Colors.black87),
                Text('Back', style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        key: _formKey,
        padding: const EdgeInsets.only(left: 20, right: 20, top: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                suffixIcon: Icon(Icons.email_rounded),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                    .hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            const SizedBox(
              width: 12,
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                suffixIcon: Icon(
                  Icons.key,
                  color: Colors.grey,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                } else if (!RegExp(r'^(?=.*[@])(?=.*[a-zA-Z0-9]).{8,}$')
                    .hasMatch(value)) {
                  return 'Password must be at least 8 characters long and contain @ symbol';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 155,
                ),
                backgroundColor: Color.alphaBlend(Colors.red, Colors.redAccent),
              ),
               onPressed: login, //(){
              //   if (_formKey.currentState?.validate() ?? false) {
              //     login();
              // }
              // },
              child: const Text('login'),
            ),
          ],
        ),
      ),
    );
  }

  void login() async {
    const url = 'https://reqres.in/api/login';
    final uri = Uri.parse(url);
    final response = await http.post(uri,
        body: jsonDecode(
            '{"email": "eve.holt@reqres.in","password": "cityslicka"}'));
    final body = response.body;
    print(body);
    final json = jsonDecode(body);
    if (json['token'] != null) {
      String token = json['token'];
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      print('Error');
    }
  }
}
