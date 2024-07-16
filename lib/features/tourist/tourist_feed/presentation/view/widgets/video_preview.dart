import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:prepare_project/features/tourist/tourist_feed/data/model/post_model.dart';
import 'package:video_player/video_player.dart';

class VideoPreview extends StatefulWidget {
  const VideoPreview({super.key,required this.type,required this.path,required this.width,required this.height});
  final VideoType type;
  final String path;
  final double width;
  final double height;

  @override
  State<VideoPreview> createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  bool isInstalled=false;
  @override
  void initState(){
    switch(widget.type){
      case VideoType.local:
        videoPlayerController=VideoPlayerController.file(File(widget.path));
    //videoPlayerController.initialize();
      case VideoType.url:
        videoPlayerController=VideoPlayerController.networkUrl(Uri.parse(widget.path));
    }
    chewieController=ChewieController(videoPlayerController: videoPlayerController);
    super.initState();
  }
  @override
  void dispose(){
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width:widget.width,
      height:widget.height*0.5,
      child: Chewie(controller: chewieController),
    );
  }
}