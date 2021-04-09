import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class MyHomePage extends StatefulWidget {
  final User curr;
  MyHomePage({Key key, this.title, this.curr}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  User curr;
  String username;

  @override
  void initState() {
    curr = widget.curr;
    super.initState();
  }
  Widget build(BuildContext context) {
    username= curr?.displayName;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times, $username :',
            ),
          ],
        ),
      ),
    );
  }
}
