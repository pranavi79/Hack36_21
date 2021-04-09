import 'package:hack_36/fireauth.dart';
import 'package:hack_36/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'edit_profile.dart';
import 'package:google_fonts/google_fonts.dart';

final _firestore = FirebaseFirestore.instance;

class Profile extends StatefulWidget {
  final User curr;

  Profile({this.curr});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _fire = fireauth();
  FirebaseAuth auth = FirebaseAuth.instance;
  User curr;
  String username;
  String initial;
  String mail;
  String location;
  String phone;

  @override
  void initState() {
    curr = widget.curr;
    super.initState();
  }

  Widget details(String details, String value) {
    print(details);
    print(value);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              details,
              style: GoogleFonts.montserrat(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black, //blueAccent,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              value,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.montserrat(
                fontSize: 20.0,
                color: Colors.black, //blueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    //curr=auth.currentUser;
    username = curr.displayName;
    mail = curr.email;
    initial = username.substring(0, 1);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5CE1E6),
        brightness: Brightness.dark,
        title: Text(
          "My Profile",
          style: GoogleFonts.montserrat(
            fontSize: 25,
            textStyle: TextStyle(
              color: Colors.grey[100],
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(3.0, 3.0),
                  blurRadius: 3.0,
                  color: Colors.black45,
                ),
                //
              ],
            ),
          ),
        ),
        actions: <Widget>[
          // IconButton(
          //   icon: Icon(Icons.edit),
          //   onPressed: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => EditProfile(),
          //         ));
          //   },
          // )
        ],
      ),
      body: Container(
        child: Column(children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color:
                Color(0xffccffff), //Color(0xff00ccff),//Color(0xFF5CE1E6),
              ),
              height: double.infinity,
              width: double.infinity,
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    CircleAvatar(
                      backgroundColor: Color(0xFF5CE1E6), //Color(0xff00ccff),
                      maxRadius: 50,
                      child: Text(
                        '$initial',
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Colors
                              .white, //Color(0xff00ccff),//Color(0xFF5CE1E6),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Text(
                        '$username',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.raleway(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            textStyle: TextStyle(shadows: <Shadow>[
                              Shadow(
                                offset: Offset(3.0, 3.0),
                                blurRadius: 3.0,
                                color: Colors.black38,
                              ),
                            ])),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      mail,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    // StreamBuilder<QuerySnapshot>(
                    //     stream: _firestore
                    //         .collection('people')
                    //         .where('email', isEqualTo: mail)
                    //         .snapshots(),
                    //     builder: (context, snapshot) {
                    //       if (!snapshot.hasData) {
                    //         return Center(
                    //           child: CircularProgressIndicator(
                    //             valueColor:
                    //             AlwaysStoppedAnimation<Color>(Colors.blue),
                    //           ),
                    //         );
                    //       } else {
                    //         final t = snapshot.data.docs[0];
                    //         phone = t.data()['phone'];
                    //         return details("Phone no:", phone);
                    //       }
                    //     }),
                    //details("phone: ","1234"),
                   // details("location: ","hey there"),
                   //  StreamBuilder<QuerySnapshot>(
                   //      stream: _firestore
                   //          .collection('people')
                   //          .where('email', isEqualTo: mail)
                   //          .snapshots(),
                   //      builder: (context, snapshot) {
                   //        if (!snapshot.hasData) {
                   //          return Center(
                   //            child: CircularProgressIndicator(
                   //              valueColor:
                   //              AlwaysStoppedAnimation<Color>(Colors.blue),
                   //            ),
                   //          );
                   //        } else {
                   //          final t = snapshot.data.docs[0];
                   //          location = t.data()['location'];
                   //          return details("Location:", location);
                   //        }
                   //      }),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0xFF5CE1E6),
        onPressed: () {
          _fire.out();
          Phoenix.rebirth(context);
        },
        label: Text(
          'Sign Out',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            textStyle: TextStyle(
              color: Colors.grey[100],
            ),

            //icon: Icon(Icons.thumb_up),
            //Color(0xff00ccff),//Colors.blueAccent,
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: BottomAppBar(
          color: Color(0xFF5CE1E6),
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Color(0xFF5CE1E6),
                ),
                onPressed: () {},
                color: Color(0xff66ccff), //Colors.blue,
              ),
            ],
          ),
          //child: bottomAppBarContents,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
