import 'package:flutter/material.dart';

//Demonstrates the MaterialApp's simplicity over WidgetsApp way of creating an app

void main() => runApp(MyWidget());

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Center(
        child: Text("Home Page"),
      ),
    );
  }
}
