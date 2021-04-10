import 'package:flutter/material.dart';
import 'package:hypertrack_plugin/hypertrack.dart';
import 'package:share/share.dart';
import 'networking.dart';


//TODO Add your publishablekey here
const String publishableKey ='v-mQjbXVtuGRTIF3DNDlhnKvwlIYtLuTw8a5yiZes0KLTwku2A8lazF8as8IdaXz_luRT1TtP-9-EKn8xAknsA';

class HyperTrackQuickStart extends StatefulWidget {
  HyperTrackQuickStart({Key key}) : super(key: key);

  @override
  _HyperTrackQuickStartState createState() => _HyperTrackQuickStartState();
}

class _HyperTrackQuickStartState extends State<HyperTrackQuickStart> {
  HyperTrack sdk;
  String deviceId;
  NetworkHelper helper;
  String result = '';
  bool isLoading = false;
  bool isLink = false;

  @override
  void initState() {
    super.initState();
    initializeSdk();
  }

  Future<void> initializeSdk() async {
    sdk = await HyperTrack.initialize(publishableKey);
    deviceId = await sdk.getDeviceId();
    sdk.setDeviceName('USER NAME HERE');
    helper = NetworkHelper('https://v3.api.hypertrack.com',
      'Basic bFZnUjFtOHdPanVXNkZqWE5oYTkxSWcyRUFjO2NlWVVsUTdLamU1eGE3M3ZMcmNBVlVEeVVTQlVzRkplQlU5ZjdQZ3hfZWFCUmNKNFRvRzBPZw==',
      deviceId,
    );
    print(deviceId);
  }


  void shareLink() async  {
    setState(() {
      isLoading = true;
      result = '';
    });
    var startTrack = await helper.startTracing();
    setState(() {
      result = (startTrack['message']);
      isLink = false;
      isLoading = false;
    });
  }

  void startTracking() async  {
    setState(() {
      isLoading = true;
      result = '';
    });
    var data = await helper.getData();
    setState(() {
      result = data['views']['share_url'];
      isLink = true;
      isLoading = false;
    });
    Share.share(data['views']['share_url'], subject: 'USER NAME\'s Location');
  }

  void endTracking() async {
    setState(() {
      isLoading = true;
      result = '';
    });
    var endTrack = await helper.endTracing();
    setState(() {
      result = (endTrack['message']);
      isLink = false;
      isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 0.0,
                width: double.infinity,
              ),
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isLoading ? CircularProgressIndicator() : Text(''),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      result,
                      style: TextStyle(
                          color: isLink ? Colors.blue[900] : Colors.red[900],
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              FlatButton(
                child: Text(
                  'Start Tracking my Location',
                ),
                onPressed: startTracking,
              ),
              FlatButton(
                child: Text('Share my Location'),
                onPressed: shareLink,
              ),
              FlatButton(
                child: Text('End Tracking my Location'),
                onPressed: endTracking,
              ),
            ],
          ),
        ));
  }
}