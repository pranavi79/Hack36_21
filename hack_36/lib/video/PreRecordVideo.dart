import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:hack_36/video/firestorageservice.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';


class VideoPlayerScreen extends StatefulWidget {
  String url;
  VideoPlayerScreen({Key key, this.url}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  String url;
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    url= widget.url;
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.network(
      url,
      //'https://firebasestorage.googleapis.com/v0/b/hack36-2021.appspot.com/o/video_1%2FExampleVideo-1.mp4?alt=media&token=4c67e32a-30c9-4972-9d3e-922a42005ff2',
     // 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  Icon buildIcon(bool hey){
    if(hey){
      return Icon(
        Icons.call_end,
        color: Colors.red,
      );
    }
    else{
      return Icon(
        Icons.call,
        color: Colors.green,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      backgroundColor: Colors.black54,
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              // Use the VideoPlayer widget to display the video.
              child: VideoPlayer(_controller),
            );
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              Navigator.pop(context);
              //_controller.pause();
            } else {
              // If the video is paused, play it.
              _controller.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: buildIcon(_controller.value.isPlaying),


      ), // This trailing comma makes auto-formatting nicer for build methods.
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}


//
//
// class RecordedVideoScreen extends StatefulWidget {
//   @override
//   _RecordedVideoScreenState createState() => _RecordedVideoScreenState();
// }
//
// class _RecordedVideoScreenState extends State<RecordedVideoScreen> {
//   VideoPlayerController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//
//     //String a= await videoFromStorage(context, "video_1/ExampleVideo-1.mp4");
//
//     _controller = VideoPlayerController.network(
//         'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')//' https://firebasestorage.googleapis.com/v0/b/hack36-2021.appspot.com/o/video_1%2FExampleVideo-1.mp4?alt=media&token=4c67e32a-30c9-4972-9d3e-922a42005ff2')
//       ..initialize().then((_) {
//         // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
//         setState(() {});
//       });
//   }
//
//
//
//
//   Future videoFromStorage(BuildContext context, String filePath) async{
//     String a;
//     await FireStorageService?.loadFromStorage(context, filePath)?.then((downloadUrl) { //A function we defined that
//       a= downloadUrl.toString();                                                       //returns the URL
//     });
//     //return a;
//     print("URL Haha");
//     print(a);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     videoFromStorage(context, "video_1/ExampleVideo-1.mp4");
//     return Scaffold(
//       body: Container(
//          color: Colors.black54,
//         child:Column(
//           children: [
//             Center(
//               child: Text(
//                 "Videos here",
//               ),
//             ),
//             Center(
//               child: _controller.value.initialized
//                   ? AspectRatio(
//                 aspectRatio: _controller.value.aspectRatio,
//                 child: VideoPlayer(_controller),
//               )
//                   : Container(),
//             ),
//
//           ],
//         )
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           setState(() {
//             _controller.value.isPlaying
//                 ? _controller.pause()
//                 : _controller.play();
//           });
//         },
//         child: Icon(
//           _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }
//
// }
//
