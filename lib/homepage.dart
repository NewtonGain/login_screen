import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(  
        title: Text("HomePage"),
        centerTitle: true,
      ),
      body: Container(  
        child: Text("This is HomePage"),
      ),
    );
  }
}