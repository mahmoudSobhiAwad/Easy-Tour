import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/views/widgets/one_to_one_view.dart';
import 'package:prepare_project/features/tourist/profile/presentation/views/widgets/pic_profile_widget.dart';

class ChatWithOtherList extends StatelessWidget {
  const ChatWithOtherList({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
          physics:const BouncingScrollPhysics(),
          padding: EdgeInsets.only(top: height*0.02,left: 20,right: 20),
          itemBuilder: (context,index){
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return ChatTouristOneToOtherOne(height: height, width: width);
                }));
              },
              child: Dismissible(
                direction: DismissDirection.startToEnd,
                background: Container(
                  decoration: BoxDecoration(
                    color: closeColor,
                    borderRadius: commonBorderRadius(),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  alignment: Alignment.centerLeft,
                  child:const Padding(
                    padding:  EdgeInsets.only(left: 10.0),
                    child:  Icon(
                      size:30,
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ),
                onDismissed:(_){} ,
                key: UniqueKey(),
                child: OneChatItemWidget(width: width, height: height),
              ),
            );
          },itemCount: 20,));
  }
}

class OneChatItemWidget extends StatelessWidget {
  const OneChatItemWidget({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
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
          leading: ProfilePicWidget(imageUrl: '', height: height*0.06),
          title: const Text('Sara Ahmed',style:CustomTextStyle.commonSignDark,),
          subtitle: SizedBox(width: width*0.5,child: const Text('Hello How Are You Today',style: CustomTextStyle.commonFontThin,)),
          trailing: Column(
           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('9:01 am',style: CustomTextStyle.commonSignLight,),
              CircleAvatar(backgroundColor: basicColor,radius: 15,child: Center( child: Text('3',style: CustomTextStyle.commonFontThinLight.copyWith(color: Colors.white,fontSize: 12),)),)
            ],
          ),
        ),
      ),
    );
  }
}