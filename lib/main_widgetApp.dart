import 'package:flutter/material.dart';

//This is the example to demonstrate WidgetsApp class:https://api.flutter.dev/flutter/widgets/WidgetsApp-class.html
void main() => runApp(MyWidget());

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      pageRouteBuilder:
          <Void>(RouteSettings settings, WidgetBuilder widgetBuilder) {
        return unKnownRoute(settings);
      },
      initialRoute: "/",
      onGenerateRoute: generate,
      onUnknownRoute: unKnownRoute,
      color: Colors.blue,
    );
  }

  Route unKnownRoute(RouteSettings settings) {
    return PageRouteBuilder(pageBuilder: (BuildContext context,
        Animation<double> animation, Animation<double> secondaryAnimation) {
      return Center(
        child: Text("Unknown Page"),
      );
    });
  }

  Route generate(RouteSettings settings) {
    Route page;
    switch (settings.name) {
      case "/":
        page = PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return Center(
              child: Text("Home Page"),
            );
          },
        );
        break;
    }
    return page;
  }
}
