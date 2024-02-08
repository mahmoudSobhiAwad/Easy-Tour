import 'package:flutter/material.dart';

class BotCircle extends StatelessWidget {
  const BotCircle({
    super.key,
    required this.height,
    required this.blurRadius,
    required this.icon,
    this.xOffset,
    this.enableShadow=true,
  });
  final double height;
  final double blurRadius;
  final double? xOffset;
  final Icon icon;
  final bool enableShadow ;

  @override
  Widget build(BuildContext context) {
    return Container(
      height:height,
      width: height,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          enableShadow? BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: blurRadius,
            offset: Offset(xOffset??0, 4),
          ):const BoxShadow(color: Colors.white),
        ],
        shape: BoxShape.circle,
      ),
      child: icon,
    );
  }
}