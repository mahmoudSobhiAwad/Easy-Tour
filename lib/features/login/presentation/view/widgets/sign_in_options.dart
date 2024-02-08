import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/sign_in_with_face_or_google.dart';

class OrSignInWith extends StatelessWidget {
  const OrSignInWith({super.key,required this.signInWithGoogle,required this.height,required this.width});
  final Future<void> Function()? signInWithGoogle;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: height*0.125,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         const Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.0),
            child:  Row(

              children: [
                Expanded(child: Divider(color: secondaryColor,)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text('or continue with ',style: TextStyle(fontSize: 16,color: basicColor,fontWeight: FontWeight.bold,),),
                ),
                Expanded(child: Divider(color: secondaryColor,)),
              ],),
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              LoginWithOption(height: height,width: width,backGroundColor:faceBookColor,text: 'acebook',icon: const FaIcon(FontAwesomeIcons.facebookF,color: Colors.white,),),
              const Expanded(child: SizedBox(width: 5,)),
              LoginWithOption(width: width,height: height,backGroundColor:const Color(0xffF57366),text: 'oogle',icon: const FaIcon(FontAwesomeIcons.google,color: Colors.white,),
                onTap: signInWithGoogle,),
            ],
          ),
        ],
      ),
    );
  }
}