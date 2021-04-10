import 'package:flutter/material.dart';
import 'package:hack_36/video/firestorageservice.dart';
import 'package:hack_36/video/PreRecordVideo.dart';

String url1= 'https://firebasestorage.googleapis.com/v0/b/hack36-2021.appspot.com/o/video_1%2FExampleVideo-1.mp4?alt=media&token=4c67e32a-30c9-4972-9d3e-922a42005ff2';
String url2=" https://firebasestorage.googleapis.com/v0/b/hack36-2021.appspot.com/o/video_1%2Fhello_video.mp4?alt=media&token=a7fc5446-21a0-48a7-9c42-8b1cacb1e23a";

class VideoListScreen extends StatefulWidget {
  @override
  _VideoListScreenState createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {

    Future videoFromStorage(BuildContext context, String filePath) async{
    String a;
    await FireStorageService?.loadFromStorage(context, filePath)?.then((downloadUrl) { //A function we defined that
      a= downloadUrl.toString();                                                       //returns the URL
    });
    print("URL Haha");
    print(a);
    //return a;

  }



  @override
  Widget build(BuildContext context) {
    //videoFromStorage(context, "video_1/hello_video.mp4");
    return Scaffold(
      backgroundColor: Color(0xFFFFCEE6),
      body:ListView(
        padding: const EdgeInsets.all(5),

        children: <Widget>[
          ElevatedButton(
            child: Container(
              height: 75,
              color: Color(0xFFEF87BE),
              child: const Center(child: Text('Example Video 1')),

            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoPlayerScreen(url: url1),
                  ));
            },
          ),
          SizedBox(
            height:5,
          ),
          ElevatedButton(
            child: Container(
              height: 75,
              color: Color(0xFFEF87BE),
              child: const Center(child: Text('Example Video 2')),

            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoPlayerScreen(url: url2),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
