import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hack_36/groupChat/home_screen.dart';
import 'fireauth.dart';
import 'package:hack_36/Profile.dart';
import 'package:hack_36/video/PreRecordVideo.dart';
import 'package:hack_36/video/videoList.dart';

class MyHomePage extends StatefulWidget {
  final User curr;
  MyHomePage({Key key, this.title, this.curr}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  User curr;
  String username;
  final _fire = fireauth();

  PageController _pageController;

  @override
  void initState() {
    curr = widget.curr;
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    username = curr?.displayName;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[200],
        leading: Image(
          image: AssetImage(
            'assets/images/ironman.png',
          ),
          height: 30,
          width: 30,
        ),
        title: Text("Hack36",
            style: GoogleFonts.roboto(fontWeight: FontWeight.bold)),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.black45,
            ),
            onPressed: () {
              _fire.out();
              Phoenix.rebirth(context);
            }, //Should Log out
          )
        ],
      ),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[

            //
            Profile(curr: curr),
            //VideoPlayerScreen(),
            VideoListScreen(),

            // Container(
            //   color: Colors.black54,
            // ),
            // Container(
            //   color: Colors.yellow[50],
            // ),
            HomeScreen2(),
            Container(
              color: Colors.blue[50],
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Profile(curr: curr),
                    ));
              },
              child: Text(
                'Profile',
                style: TextStyle(
                  color: Color(0xFFEF87BE),
                ),
              ),
              color: Colors.white,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Colors.red[200],
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 300), curve: Curves.ease);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: Text('Profile'),
              icon: Icon(Icons.person),
              inactiveColor: Colors.black45,
              activeColor: Colors.white),
          BottomNavyBarItem(
              title: Text('Videos'),
              icon: Icon(Icons.video_library),
              inactiveColor: Colors.black45,
              activeColor: Colors.white),
          BottomNavyBarItem(
              title: Text('Chat'),
              icon: Icon(Icons.chat_bubble_outline),

              inactiveColor: Colors.black45,
              activeColor: Colors.white),
          BottomNavyBarItem(
              title: Text('Videocall'),
              icon: Icon(Icons.video_call),
              inactiveColor: Colors.black45,
              activeColor: Colors.white),
        ],
      ),
    );
  }
}
