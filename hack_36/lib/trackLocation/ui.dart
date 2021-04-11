import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hypertrack_plugin/hypertrack.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:clipboard/clipboard.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HyperTrackQuickStart extends StatefulWidget {
  @override
  _HyperTrackQuickStartState createState() => _HyperTrackQuickStartState();
}

final _firestoreid = FirebaseFirestore.instance;
String data;

class _HyperTrackQuickStartState extends State<HyperTrackQuickStart> {
  static const key =
      'v-mQjbXVtuGRTIF3DNDlhnKvwlIYtLuTw8a5yiZes0KLTwku2A8lazF8as8IdaXz_luRT1TtP-9-EKn8xAknsA'; //Provide the publishable key from the dashboard
  String deviceName = 'OnePlus'; //Provide a name for your device
  String _result = 'Not initialized';
  String _deviceId = '';
  HyperTrack sdk;
  String buttonLabel = 'Start Tracking';
  Color buttonColor = Colors.red[200];
  final _auth = FirebaseAuth.instance;
  User LInUser;

  void getCurrentUser() async {
    try {
      User hey = _auth.currentUser;
      if (hey != null) {
        LInUser = hey;
      }
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    super.initState();
    initializeSdk();
    getCurrentUser();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initializeSdk() async {
    HyperTrack.enableDebugLogging();
    // Initializer is just a helper class to get the actual sdk instance
    String result = 'failure';
    try {
      sdk = await HyperTrack.initialize(key);
      updateButtonState();
      result = 'initialized';
      sdk.setDeviceName(deviceName);
      sdk.setDeviceMetadata({"source": "flutter sdk"});
      sdk.onTrackingStateChanged.listen((TrackingStateChange event) {
        if (mounted) {
          setState(() {
            _result = '$event';
          });
          updateButtonState();
        }
      });
    } catch (e) {
      print(e);
    }

    final deviceId = (sdk == null) ? "unknown" : await sdk.getDeviceId();

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _result = result;
      _deviceId = deviceId;
    });
  }

  Future getData() async {
    http.Response response = await http
        .get('https://v3.api.hypertrack.com/devices/{$_deviceId}', headers: {
      'Authorization': 'Basic bFZnUjFtOHdPanVXNkZqWE5oYTkxS'
          'WcyRUFjOmNlWVVsUTdLamU1eGE3M3ZMcmNBVlVEeVVTQlVzRkplQlU5ZjdQZ3hfZWFCUmNKNFRvRzBPZw=='
    });
    if (response.statusCode == 200) {
      data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }

  void start() {
    sdk.start();
    Fluttertoast.showToast(
        msg: "Location copied",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red[200],
        textColor: Colors.white,
        fontSize: 12.0);
    FlutterClipboard.copy("https://trck.at/nx8jnj6")
        .then((value) => print('copied'));
    getData();
  }

  void stop() {
    sdk.stop();
  }

  void syncDeviceSettings() => sdk.syncDeviceSettings();

  Text getDeviceIdText() {
    return Text(
      _deviceId,
      style: TextStyle(fontSize: 16.0),
    );
  }

  Text displayButton() {
    return (Text(
      this.buttonLabel,
      style: TextStyle(color: Colors.white),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: true,
            backgroundColor: Colors.red[200],
            title: Text(
              'Live Location',
              style: TextStyle(),
            )),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 200.0,
                child: Center(
                  child: getDeviceIdText(),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40.0),
                child: RaisedButton(
                  padding: EdgeInsets.all(20.0),
                  color: buttonColor,
                  onPressed: () {
                    if (this.buttonLabel == "Stop Tracking") {
                      stop();
                    } else {
                      start();
                    }
                  },
                  child: displayButton(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateButtonState() async {
    final isRunning = await sdk.isRunning();
    if (isRunning) {
      setState(() {
        this.buttonLabel = "Stop Tracking";
        this.buttonColor = Colors.red;
      });
    } else {
      setState(() {
        this.buttonLabel = "Start Tracking";
        this.buttonColor = Colors.pink;
      });
    }
  }
}
