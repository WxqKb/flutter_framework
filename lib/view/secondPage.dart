import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageView createState() => _SecondPageView();
}

class _SecondPageView extends State<SecondPage> {
  List<String> list = ['1', '2', '3', '4', '5', '6', '7'];
  VideoPlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.network(
        'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    // TODO: implement build
    return new Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          backgroundColor: const Color(0xffFF7E5C),
          title: Text('开门',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(34),
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          centerTitle: true,
        ),
        preferredSize: Size.fromHeight(35.0),
      ),
      body: Center(
        child: _controller.value.initialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Container(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  List<Expanded> expanded() {
    List<Expanded> ep = new List();
    list.forEach((f) => {
          ep.add(new Expanded(
            child: Container(
              color: Colors.red,
              padding: EdgeInsets.all(5.0),
              child: new Text(f),
            ),
          ))
        });
    return ep;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
}
