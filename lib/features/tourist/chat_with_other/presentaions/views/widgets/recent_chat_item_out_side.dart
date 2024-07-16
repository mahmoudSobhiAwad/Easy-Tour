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
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        width: width,
        height: height*0.1,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: thirdColor,
          borderRadius: commonBorderRadius(),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.only(bottom: 5,left: 5,right: 5),
          leading: ProfilePicWidget(imageUrl: profPic, height: height*0.06),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$name',style:CustomTextStyle.fontBold16.copyWith(color: basicColor),),
               getMessageType(model),
            ],
          ),
          //subtitle: SizedBox(width: width*0.5,child: getMessageType(model)),
          trailing:Text(model?.oneMessage?.messageDate?.toString().substring(0,10)??"",style: CustomTextStyle.font16Light.copyWith(color: basicColor),),

        ),
      ),
    );
  }
}
Widget getMessageType(RecentChatModel? model){
  switch(model?.oneMessage?.messageType){
    case 'text':
      return Text(model?.oneMessage?.message??"",style: CustomTextStyle.fontNormal14WithEllipsis.copyWith(color: basicColor),);
    case 'voice':
      return const Icon(Icons.mic,color: basicColor,);
    case 'image':
      return const Icon(Icons.image,color: basicColor,);
    case 'video':
      return const Icon(Icons.location_on_rounded,color: basicColor);
    default:
      return const SizedBox();
  }
}