import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/chat_with_other/data/models/recent_chat_model.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/views/widgets/custom_dissmisable_chat.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/views/widgets/one_to_one_view.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/views/widgets/recent_chat_item_out_side.dart';

class RecentChatWithOther extends StatelessWidget {
  const RecentChatWithOther({
    super.key,
    required this.width,
    required this.height,
     this.recentChatList,
    required this.isRecentChatLoading,
    this.emptyMessages,
  });
  final String?emptyMessages;
  final double width;
  final double height;
  final bool isRecentChatLoading;
  final List<RecentChatModel>?recentChatList;

  @override
  Widget build(BuildContext context) {
    return
      isRecentChatLoading?
      const Center(child: CircularProgressIndicator(color: basicColor,),):
      Expanded(
        child:recentChatList!.isNotEmpty?
        ListView.builder(
          physics:const BouncingScrollPhysics(),
          padding: EdgeInsets.only(top: height*0.02,left: 20,right: 20),
          itemBuilder: (context,index){
            PersonInChatData? personInChatData;
            personInChatData = checkWhichIsSource(index, personInChatData);
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return ChatTouristOneToOtherOne(height: height, width: width,chatId: recentChatList?[index].chatId,destEmail: personInChatData?.email,profileUrl: personInChatData?.profilePic,name: personInChatData?.name,status: 'Online',);
                }));
              },
              child: CustomDismissible(child: RecentChatItemOutSideListTile(width: width, height: height,model: recentChatList?[index],),),
            );
          },itemCount: recentChatList?.length??0,):
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.messenger_outlined,color: thirdColor,size: height*0.1,),
              SizedBox(
                  width: width*0.7,
                  child: Text('$emptyMessages',style: CustomTextStyle.font16Light,)),
            ],
          ),
        ),
    );
  }

  PersonInChatData? checkWhichIsSource(int index, PersonInChatData? personInChatData) {
    if(recentChatList?[index].personOne?.email==null){
      personInChatData=recentChatList?[index].personTwo;
    }
    else{
      personInChatData=recentChatList?[index].personOne;
    }
    return personInChatData;
  }
}



