import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:hypertrack_plugin/hypertrack.dart';
HyperTrack sdk;

const String publishableKey ='v-mQjbXVtuGRTIF3DNDlhnKvwlIYtLuTw8a5yiZes0KLTwku2A8lazF8as8IdaXz_luRT1TtP-9-EKn8xAknsA';


class NetworkHelper {
  String url,id,auth;
  NetworkHelper(url,auth,id){
    this.url=url;
    this.auth=auth;
    this.id=id;
  }


  Future startTracing() async {
    http.Response response = await http.post('$url/devices/$id/start',
        body: null,
        headers: {
          'Authorization': auth
        });
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }

  Future getData() async {
    http.Response response =
    await http.get('$url/devices/$id', headers: {
      'Authorization': auth
    });
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }

  Future endTracing() async {
    http.Response response = await http.post('$url/devices/$id/stop',
        body: null,
        headers: {
          'Authorization': auth
        });
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}