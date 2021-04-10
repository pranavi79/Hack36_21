import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'call_screen.dart';

class MyChannel extends StatefulWidget {
  @override
  _MyChannelState createState() => _MyChannelState();
}

class _MyChannelState extends State<MyChannel> {
  final myController = TextEditingController();
  //bool _validateError = false;

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }

  Future<void> onJoin(String channel) async {
    // setState(() {
    //   myController.text.isEmpty
    //       ? _validateError = true
    //       : _validateError = false;
    // });

    await _handleCameraAndMic(Permission.camera);
    await _handleCameraAndMic(Permission.microphone);

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(channelName: channel),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 15)),
              Text(
                'ROOMS',
                style: GoogleFonts.roboto(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: GridView.count(
                  childAspectRatio: 1.5,
                  shrinkWrap: true,
                  //padding: const EdgeInsets.all(4.0),
                  mainAxisSpacing: 2.0,
                  crossAxisSpacing: 10.0,
                  crossAxisCount: 2,
                  children: List.generate(6, (index) {
                    return Center(
                      child: MaterialButton(
                        onPressed: () => onJoin('channel$index'),
                        height: 50,
                        color: Colors.red[200],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Channel $index',
                              style: TextStyle(color: Colors.white),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),

              // Container(
              //   width: MediaQuery.of(context).size.width * 0.8,
              //   child: TextFormField(
              //     controller: myController,
              //     decoration: InputDecoration(
              //       labelText: 'Channel Name',
              //       labelStyle: TextStyle(color: Colors.blue),
              //       hintText: 'test',
              //       hintStyle: TextStyle(color: Colors.black45),
              //       errorText:
              //           _validateError ? 'Channel name is mandatory' : null,
              //       border: OutlineInputBorder(
              //         borderSide: BorderSide(color: Colors.blue),
              //         borderRadius: BorderRadius.circular(20),
              //       ),
              //     ),
              //   ),
              // ),
              // Padding(padding: EdgeInsets.symmetric(vertical: 30)),
              // Container(
              //   width: MediaQuery.of(context).size.width * 0.25,
              //   child: MaterialButton(
              //     onPressed: onJoin,
              //     height: 40,
              //     color: Colors.blueAccent,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: <Widget>[
              //         Text(
              //           'Join',
              //           style: TextStyle(color: Colors.white),
              //         ),
              //         Icon(
              //           Icons.arrow_forward,
              //           color: Colors.white,
              //         ),
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
