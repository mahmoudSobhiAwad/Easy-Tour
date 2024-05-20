import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/function/set_app_state.dart';

class SmallProfilePic extends StatelessWidget {
  const SmallProfilePic({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        backgroundColor: thirdColor,
        radius: width*0.06,
        child:Center(child: Image.network(
          errorBuilder:(context,_,m){
            return const Icon(Icons.warning,color: closeColor,);
          },
          SetAppState.prefs?.getString('profileUrl')??"",fit: BoxFit.fill,)));
  }
}