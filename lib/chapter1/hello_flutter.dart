import 'package:flutter/material.dart';

//Create a simple Hello Flutter app

//Learning objectives:
/**
 * 1. app's entry point
 * 2. MaterialApp widget
 * 3. Center widget: Centers the content in the middle of the device screen
 * 4. Scaffold widget : Provides a app's scaffold
 * 5. SafeArea widget
 * 6. AppBar widget: Title, leading and actions
 * 7. Type of widgets: Stateless vs Stateful
 * 8. Add a button to toggle text in between English and Spanish
 */

//Scaffold
void main() => runApp(HelloFlutterApp());

//class HelloFlutterApp extends StatelessWidget {
//  String displayText = englishGreeting;
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      debugShowCheckedModeBanner: false,
//      home: Scaffold(
//        appBar: AppBar(
//          title: Text("Hello Flutter App"),
//          leading: Icon(Icons.home),
//          actions: <Widget>[
//            IconButton(
//              icon: Icon(Icons.refresh),
//              onPressed: () {},
//            )
//          ],
//        ),
//        body: Center(
//          child: Text(
//            displayText,
//            style: TextStyle(fontSize: 24),
//          ),
//        ),
//      ),
//    );
//  }
//}

//SafeArea
//void main() => runApp(HelloFlutterApp());
//
//class HelloFlutterApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      home: SafeArea(
//        child: Text("Hello Flutter !"),
//      ),
//    );
//  }
//}

//#1
//void main() => runApp(HelloFlutterApp());
//
//class HelloFlutterApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      home: Center(
//        child: Text("Hello Flutter !"),
//      ),
//    );
//  }
//}

class HelloFlutterApp extends StatefulWidget {
  @override
  _HelloFlutterAppState createState() => _HelloFlutterAppState();
}

String englishGreeting = "Hello Flutter !";
String spanishGreeting = "Hola Flutter !";

class _HelloFlutterAppState extends State<HelloFlutterApp> {
  String displayText = englishGreeting;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Hello Flutter App"),
          leading: Icon(Icons.home),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  displayText = displayText == englishGreeting
                      ? spanishGreeting
                      : englishGreeting;
                });
              },
            )
          ],
        ),
        body: Center(
          child: Text(
            displayText,
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
