import 'package:flutter/material.dart';

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
