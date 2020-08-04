import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(VideoDemo());
}

class VideoDemo extends StatefulWidget {
  VideoDemo() : super();

  VideoDemoState createState() => VideoDemoState();
}

class VideoDemoState extends State<VideoDemo> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  void initState() {
    _controller = VideoPlayerController.asset(
        "assets/video/video-1.mp4");
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.setVolume(1.0);
    super.initState();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("VideoDemo"),
          backgroundColor: Colors.grey.shade900,
        ),
        body: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Center(
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              if (_controller.value.isPlaying) {
                _controller.pause();
              } else {
                _controller.play();
              }
            });
          },
          child: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
          backgroundColor: Colors.white,
          hoverColor: Colors.black,
          foregroundColor: Colors.black,
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}