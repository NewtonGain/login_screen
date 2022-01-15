import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'homepage.dart';


class Login extends StatelessWidget {

  Future<void> authSignUp(String email, String password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyD0gxgqEWZsfFJeHKcpVzmL6kj8VhWlVrc';
    final response = await http.post(
      Uri.parse(url),
      body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );
    print(json.decode(response.body));
    // notifyListeners();
  }

  Widget build(BuildContext context) {
    TextEditingController _email = TextEditingController();
    TextEditingController _pass = TextEditingController();

    return SafeArea(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "My Application",
            style: TextStyle(fontSize: 25),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Your Login Page",
            style: TextStyle(fontSize: 40, color: Colors.red),
          ),
          SizedBox(height: 40),
          TextField(
            controller: _email,
            decoration: InputDecoration(
              hintText: "Enter Your E-mail",
              prefixIcon: Icon(Icons.email),
            ),
          ),
          TextField(
            controller: _pass,
            obscureText: true,
            decoration: InputDecoration(
                hintText: "Enter Your Password", prefixIcon: Icon(Icons.lock)),
          ),
          SizedBox(height: 40),
          FlatButton(
            minWidth: double.infinity,
            color: Colors.red,
            height: 50,
            child: Text(
              "Login",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            onPressed: () async {
              await authSignUp(_email.text, _pass.text);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          )
        ],
      ),
    ));
  }
}