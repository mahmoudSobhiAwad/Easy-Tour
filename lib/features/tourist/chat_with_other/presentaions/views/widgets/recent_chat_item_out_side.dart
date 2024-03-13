import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/tourist/chat_with_other/data/models/recent_chat_model.dart';
import 'package:prepare_project/features/tourist/profile/presentation/views/widgets/pic_profile_widget.dart';
class RecentChatItemOutSideListTile extends StatelessWidget {
  const RecentChatItemOutSideListTile({
    super.key,
    required this.width,
    required this.height,
    required this.model,
  });

  final double width;
  final double height;
  final RecentChatModel? model;

  @override
  Widget build(BuildContext context) {
    String?profPic=model?.personOne?.email==null?model?.personTwo?.profilePic:model?.personOne?.profilePic;
    String?name=model?.personOne?.email==null?model?.personTwo?.name:model?.personOne?.name;
    String?message=model?.oneMessage?.message??"";
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        width: width,
        height: height*0.1,
        decoration: BoxDecoration(
          color: thirdColor,
          borderRadius: commonBorderRadius(),
        ),
        child: ListTile(
          leading: ProfilePicWidget(imageUrl: profPic, height: height*0.06),
          title: Text('$name',style:CustomTextStyle.commonSignDark,),
          subtitle: SizedBox(width: width*0.5,child: Text(message,style: CustomTextStyle.commonFontThin,)),
          trailing: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(model?.oneMessage?.messageDate?.substring(0,10)??"",style: CustomTextStyle.commonSignLight,),
              CircleAvatar(backgroundColor: basicColor,radius: 15,child: Center( child: Text('3',style: CustomTextStyle.commonFontThinLight.copyWith(color: Colors.white,fontSize: 12),)),)
            ],
          ),
        ),
      ),
    );
  }
}