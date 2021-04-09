import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hack_36/Profile.dart';
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
            ElevatedButton(
              onPressed:(){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Profile(curr: curr),
                )
                );
              },
              child: Text(
                'Profile',
                style: TextStyle(
                    color: Colors.blueAccent
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),


            ),
          ],
        ),

      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   backgroundColor: Color(0xFF5CE1E6),
      //   onPressed: () {
      //     _fire.out();
      //     Phoenix.rebirth(context);
      //   },
      //   label: Text(
      //     'Sign Out',
      //     style: GoogleFonts.montserrat(
      //       fontWeight: FontWeight.bold,
      //       fontSize: 15,
      //       textStyle: TextStyle(
      //         color: Colors.grey[100],
      //       ),
      //
      //       //icon: Icon(Icons.thumb_up),
      //       //Color(0xff00ccff),//Colors.blueAccent,
      //     ),
      //   ),
      // ),
    );
  }
}
