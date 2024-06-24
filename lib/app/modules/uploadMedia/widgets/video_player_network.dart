import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerNetwork extends StatefulWidget {
  final String videoFile;

  const VideoPlayerNetwork({super.key, required this.videoFile});

  @override
  State<VideoPlayerNetwork> createState() => _VideoPlayerAssetsState();
}

class _VideoPlayerAssetsState extends State<VideoPlayerNetwork> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoFile))
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
    return SizedBox(
      height: double.minPositive,
      width: double.minPositive,
      child: Stack(
        children: [
          Container(
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Container(
                    color: Colors.blueGrey.withOpacity(0.5),
                  ),
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
      ),
    );
  }
}
