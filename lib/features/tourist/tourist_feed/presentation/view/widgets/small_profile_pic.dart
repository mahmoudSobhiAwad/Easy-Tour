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
      backgroundImage: NetworkImage(SetAppState.prefs?.getString('profileUrl')??"https://cdn1.iconfinder.com/data/icons/users-pack-mino-io/24/user-1-error-512.png",),
        backgroundColor: thirdColor,
        radius: width*0.06,
        // child:Center(
        //     child: Image.network(
        //       errorBuilder:(context,_,m){
        //         return const Icon(Icons.warning,color: closeColor,);
        //         },
        //   SetAppState.prefs?.getString('profileUrl')??"",fit: BoxFit.fill,width: width*0.06,height: width*0.06,))
    );
  }
}