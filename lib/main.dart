import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login.dart';


int main() {
  
  runApp(MyApp());

  return 0;
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Button Widget",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Button Widget"),
          centerTitle: true,
        ),
        body: Login(),
      ),
    );
  }
}