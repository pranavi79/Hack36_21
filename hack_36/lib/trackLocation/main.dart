import 'dart:core';

import 'package:flutter/material.dart';
import 'package:hypertrack_plugin/hypertrack.dart';
import 'networking.dart';
import 'package:share/share.dart';


const String publishableKey =
    'v-mQjbXVtuGRTIF3DNDlhnKvwlIYtLuTw8a5yiZes0KLTwku2A8lazF8as8IdaXz_luRT1TtP-9-EKn8xAknsA';
void main() => runApp(HyperTrackQuickStart());

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
  bool isLink = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    initializeSdk();
  }

  Future<void> initializeSdk() async {
    sdk = await HyperTrack.initialize(publishableKey);
    deviceId = await sdk.getDeviceId();
    sdk.setDeviceName('USER NAME');
    helper = NetworkHelper('https://v3.api.hypertrack.com',
      'Basic bFZnUjFtOHdPanVXNkZqWE5oYTkxSWcyRUFjO2NlWVVsUTdLamU1eGE3M3ZMcmNBVlVEeVVTQlVzRkplQlU5ZjdQZ3hfZWFCUmNKNFRvRzBPZw==',
       deviceId,
    );
    print(deviceId);
  }

  void shareLink() async {
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

  void startTracking() async {
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

// then build method, we already implented it

  @override
  Widget build(BuildContext context) {}

}