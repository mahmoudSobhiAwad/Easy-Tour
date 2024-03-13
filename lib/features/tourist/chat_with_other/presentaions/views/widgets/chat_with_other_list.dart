import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/tourist/chat_with_other/data/models/recent_chat_model.dart';
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
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return ChatTouristOneToOtherOne(height: height, width: width,chatId: recentChatList?[index].chatId,);
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
                // onDismissed:(_){} ,
                key: UniqueKey(),
                child: RecentChatItemOutSideListTile(width: width, height: height,model: recentChatList?[index],),
              ),
            );
          },itemCount: recentChatList?.length??0,):
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.messenger_outlined,color: thirdColor,size: height*0.1,),
              SizedBox(
                  width: width*0.7,
                  child: Text('$emptyMessages',style: CustomTextStyle.commonSignLight,)),
            ],
          ),
        ),
    );
  }
}

