import 'package:flutter/material.dart';

void main() => runApp(GoogleContactsProfilePage());

class GoogleContactsProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: Icon(
              Icons.arrow_back,
              color: Colors.black87,
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.star_border,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          body: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 250,
                    color: Colors.indigo.shade500,
                    child: Image.asset(
                      "assets/profile.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Priyanka Tyagi",
                            style: TextStyle(fontSize: 30),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        buildCallButton(),
                        buildTextButton(),
                        buildVideoCallButton(),
                        buildEmailButton(),
                        buildDirectionsButton(),
                        buildPayButton(),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  mobilePhoneListTile(),
                  otherPhoneListTile(),
                  Divider(
                    color: Colors.grey,
                  ),
                  emailListTile(),
                  Divider(
                    color: Colors.grey,
                  ),
                  addressListTile(),
                ],
              ),
            ],
          )),
    );
  }

  Widget buildCallButton() {
    return Column(
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.call,
            color: Colors.indigo.shade800,
          ),
          onPressed: () {},
        ),
        Text("Call"),
      ],
    );
  }

  Widget buildTextButton() {
    return Column(
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.message,
            color: Colors.indigo.shade800,
          ),
          onPressed: () {},
        ),
        Text("Text"),
      ],
    );
  }

  Widget buildVideoCallButton() {
    return Column(
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.video_call,
            color: Colors.indigo.shade800,
          ),
          onPressed: () {},
        ),
        Text("Video"),
      ],
    );
  }

  Widget buildEmailButton() {
    return Column(
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.email,
            color: Colors.indigo.shade800,
          ),
          onPressed: () {},
        ),
        Text("Email"),
      ],
    );
  }

  Widget buildDirectionsButton() {
    return Column(
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.directions,
            color: Colors.indigo.shade800,
          ),
          onPressed: () {},
        ),
        Text("Directions"),
      ],
    );
  }

  Widget buildPayButton() {
    return Column(
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.attach_money,
            color: Colors.indigo.shade800,
          ),
          onPressed: () {},
        ),
        Text("Pay"),
      ],
    );
  }

  Widget mobilePhoneListTile() {
    return ListTile(
      leading: Icon(Icons.call),
      title: Text("330-803-3390"),
      subtitle: Text("mobile"),
      trailing: IconButton(
        icon: Icon(Icons.message),
        color: Colors.indigo.shade500,
        onPressed: () {},
      ),
    );
  }

  Widget otherPhoneListTile() {
    return ListTile(
      leading: Text(""),
      title: Text("440-440-3390"),
      subtitle: Text("other"),
      trailing: IconButton(
        icon: Icon(Icons.message),
        color: Colors.indigo.shade500,
        onPressed: () {},
      ),
    );
  }

  Widget emailListTile() {
    return ListTile(
      leading: Icon(Icons.email),
      title: Text("priyanka@priyanka.com"),
      subtitle: Text("work"),
    );
  }

  Widget addressListTile() {
    return ListTile(
      leading: Icon(Icons.location_on),
      title: Text("234 Sunset St, Burlingame"),
      subtitle: Text("home"),
      trailing: IconButton(
        icon: Icon(Icons.directions),
        color: Colors.indigo.shade500,
        onPressed: () {},
      ),
    );
  }
}
