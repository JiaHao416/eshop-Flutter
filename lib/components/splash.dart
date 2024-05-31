// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/view/main_page.dart';
import 'package:video_player/video_player.dart';

class Splash extends StatefulWidget {
  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> {
  late VideoPlayerController _controller;
  int _playCount = 0;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/splash_video_1k.mp4')
      ..initialize().then((_) {
        _controller.play();
        _controller.addListener(_videoListener);
        setState(() {});
      });
  }

  void _videoListener() {
    if (_controller.value.isInitialized) {
      if (_controller.value.position >= _controller.value.duration) {
        if (_playCount < 0) {
          _playCount++;
          _controller.seekTo(Duration.zero);
          _controller.play();
        } else {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
              overlays: SystemUiOverlay.values);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MainPage(
                      context: context,
                    )),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: IgnorePointer(
              child: VideoPlayer(_controller),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.removeListener(_videoListener);
    _controller.dispose();
  }
}
