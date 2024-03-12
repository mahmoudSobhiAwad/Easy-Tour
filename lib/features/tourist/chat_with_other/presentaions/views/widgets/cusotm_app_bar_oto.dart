import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/profile/presentation/views/widgets/pic_profile_widget.dart';

class CustomChatOneToOneAppBar extends StatelessWidget {
  const CustomChatOneToOneAppBar({
    super.key,
    required this.height,
    required this.width,
    this.profileUrl,
    this.name
  });

  final double height;
  final double width;
  final String?profileUrl;
  final String?name;

  @override
  Widget build(BuildContext context) {
    return Container(
      height:height*0.08,
      width: width,
      decoration: const BoxDecoration(
        color: Colors.white,
        border:Border(bottom: BorderSide(color:secondaryColor)),
      ),
      child: Row(
        children: [
          IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: const Icon(Icons.arrow_back_ios_new)),
          ProfilePicWidget(imageUrl: profileUrl??'', height: height*0.06,),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0,left: 5),
            child: SizedBox(
              width: width*0.4,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Text(name??"",style: CustomTextStyle.commonFontThin,),
                    const Icon(Icons.circle,color: whatsAppColor,size: 15,),
                  ],
                ),
              ),
            ),
          ),
          const Spacer(),
          const IconButton(onPressed:null ,padding: EdgeInsets.only(right: 10),icon:Icon(Icons.info,color: basicColor,size: 30,)),
        ],
      ),
    );
  }
}