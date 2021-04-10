import 'dart:async';
import 'package:hack_36/Login/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'fireauth.dart';
import 'package:hack_36/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hack_36/utilities.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

enum LoginStatus { NotDetermined, LoggedIn, NotLoggedIn }

class _SplashPageState extends State<SplashPage> {
  LoginStatus status = LoginStatus.NotDetermined;
  User curr = null;
  ConfettiController controllerTopCenter;
  @override
  void initState() {
    fireauth _fire = fireauth();
    Future.delayed(const Duration(seconds: 4), () {
      _fire.Current().then((current) {
        setState(() {
          status =
              current == null ? LoginStatus.NotLoggedIn : LoginStatus.LoggedIn;
          curr = current;
        });
      });
    });
    super.initState();
    setState(() {
      initController();
    });
  }

  void initController() {
    controllerTopCenter =
        ConfettiController(duration: const Duration(seconds: 4));
  }

  @override
  Widget build(BuildContext context) {
    controllerTopCenter.play();
    switch (status) {
      case LoginStatus.NotDetermined:
        {
          return Scaffold(
              backgroundColor: Colors.red[100],
              body: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //buildConfettiWidget(controllerTopCenter, pi / 1),
                    buildConfettiWidget(controllerTopCenter, pi / 4),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Container(
                                child: Text(
                              "Behind every successful woman, is a tribe of other women who have her back.",
                              style: tStyle,
                              textAlign: TextAlign.center,
                            )),
                          ),
                          // Center(
                          //   child: Container(
                          //       child: Text(
                          //     "woman, is a tribe of other",
                          //     style: tStyle,
                          //   )),
                          // ),
                          // Center(
                          //   child: Container(
                          //       child: Text(
                          //     "successful women who have",
                          //     style: tStyle,
                          //   )),
                          // ),
                          // Center(
                          //   child: Container(
                          //       child: Text(
                          //     "her back.",
                          //     style: tStyle,
                          //   )),
                          // ),
                        ],
                      ),
                    ),
                    Container(
                      //padding: EdgeInsets.only(bottom: 50.0, left: 10.0, right: 10.0, top:20.0),
                      child: SpinKitRipple(
                        color: Color(0xFFEF87BE),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
                //),
                //)
                // ],
                //),
              ));
        }
      case LoginStatus.LoggedIn:
        {
          // return LoginScreen();
          return MyHomePage(title: "Our app", curr: curr);
          //return HomeScreen(curr: null,);
        }
      case LoginStatus.NotLoggedIn:
        {
          return LoginScreen();
        }
    }
  }

  Align buildConfettiWidget(controller, double blastDirection) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConfettiWidget(
        maximumSize: Size(20, 20),
        shouldLoop: false,
        confettiController: controller,
        blastDirection: blastDirection,
        blastDirectionality: BlastDirectionality.explosive,
        maxBlastForce: 20, // set a lower max blast force
        minBlastForce: 8, // set a lower min blast force
        emissionFrequency: 0.3,
        numberOfParticles: 7, // a lot of particles at once
        gravity: 1,
      ),
    );
  }
}
