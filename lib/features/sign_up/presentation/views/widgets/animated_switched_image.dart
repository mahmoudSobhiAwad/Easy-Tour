import 'dart:async';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';

import 'package:flutter/material.dart';

class AnimatedSwitchImages extends StatefulWidget {
  final String idImage;
  final String imageTitle;
  const AnimatedSwitchImages({
    super.key,
    required this.imageTitle,
    required this.idImage,
  });

  @override
  State<AnimatedSwitchImages> createState() => _AnimatedSwitchImagesState();
}

class _AnimatedSwitchImagesState extends State<AnimatedSwitchImages> with SingleTickerProviderStateMixin {
  late bool _isFirstImageVisible;
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    _isFirstImageVisible = true; // Start with first image visible
    _timer = Timer.periodic(const Duration(milliseconds: 2500), (timer) {
      setState(() {
        _isFirstImageVisible = !_isFirstImageVisible; // Toggle visibility every 2 seconds
      });
    });
  }
  @override
  void dispose() {
    _timer.cancel(); // Stop the timer when widget is disposed
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          AnimatedOpacity(
            opacity: _isFirstImageVisible ? 1.0 : 0.0,
            curve: Curves.easeIn,
            duration: const Duration(seconds: 1),
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon( Icons.photo_outlined,color: basicColor,size: 60,),
                const SizedBox(height: 10,),
                Text('Upload${widget.imageTitle}, please make it so clear with no blur.',style: CustomTextStyle.commonSignDark,textAlign: TextAlign.center,)
              ],
            ),
          ),
          AnimatedOpacity(
            curve: Curves.easeOut,
            opacity: _isFirstImageVisible ? 0.0 : 1.0,
            duration: const Duration(seconds: 1),
            child: ClipRRect(
              child: Image.asset(widget.idImage,),
            ),
          ),
        ]
    );
  }
}