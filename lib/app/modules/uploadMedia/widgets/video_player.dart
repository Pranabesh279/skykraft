import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerAssets extends StatefulWidget {
  final File videoFile;

  const VideoPlayerAssets({super.key, required this.videoFile});

  @override
  State<VideoPlayerAssets> createState() => _VideoPlayerAssetsState();
}

class _VideoPlayerAssetsState extends State<VideoPlayerAssets> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.videoFile)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.initialize().then((_) {
      _controller.dispose();
    });

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
        ),
        Align(
          alignment: Alignment.center,
          child: IconButton(
            color: Colors.white,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              size: 50,
            ),
            onPressed: () {
              setState(() {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  _controller.play();
                }
              });
            },
          ),
        ),
      ],
    );
  }
}
