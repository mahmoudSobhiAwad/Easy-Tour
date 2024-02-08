import 'package:flutter/material.dart';

class CustomPageViewLoginSignUp extends StatelessWidget {
  const CustomPageViewLoginSignUp({super.key,this.progressIndex,this.height,required this.children,this.scrollPhysics,this.onPageChanged});
  final double? height;
  final List<Widget>children;
  final ScrollPhysics? scrollPhysics;
  final void Function(int)? onPageChanged;
  final int? progressIndex;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: PageView.builder(
          clipBehavior: Clip.none,
          onPageChanged: onPageChanged,
          itemCount: children.length,
          physics:scrollPhysics,
          itemBuilder: (context,index){
            return children[progressIndex??index];
          }),
    );
  }
}