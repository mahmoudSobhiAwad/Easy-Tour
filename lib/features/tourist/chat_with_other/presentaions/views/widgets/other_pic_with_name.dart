import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/profile/presentation/views/widgets/pic_profile_widget.dart';
class OtherPeoplePicWithName extends StatelessWidget {
  const OtherPeoplePicWithName({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height*0.15,
      child: ListView.separated(
        padding: EdgeInsets.only(top: height*0.02,left: 20,right: 20),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context,index){
          return SizedBox(
            height: height*0.14,
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    ProfilePicWidget(imageUrl: '', height: height*0.07),
                    const Icon(Icons.circle,size: 15,color: whatsAppColor,)
                  ],
                ),
                SizedBox(height: height*0.01,),
                SizedBox(width:width*0.2,height: height*0.05,child: const Text('Mahmoud Sobhi Awad',style: CustomTextStyle.commonFontThin,maxLines: 2,overflow: TextOverflow.ellipsis,))
              ],
            ),
          );
        },
        separatorBuilder: (context,index){
          return SizedBox(width: width*0.04,);
        },
      ),
    );
  }
}