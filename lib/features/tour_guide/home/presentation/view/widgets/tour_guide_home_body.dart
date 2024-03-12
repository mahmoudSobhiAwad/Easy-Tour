import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tour_guide/home/presentation/manager/home_tour_guide_cubit.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/views/widgets/chat_with_other_list.dart';
import 'package:prepare_project/features/tourist/tourist_home/presentaion/view/widgets/app_bar.dart';

class HomeTourGuideBody extends StatelessWidget {
  const HomeTourGuideBody({super.key,required this.cubit,required this.height,required this.width});
  final TourGuideHomeCubit cubit;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40,bottom: 10,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          cubit.isMenuActive? const SizedBox(height: 0,):HomeTouristTourGuideAppBar(
            rightIcon: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  IconButton(onPressed: (){},icon:const Icon(Icons.notifications_none_rounded,color: basicColor,size: 35,),padding: EdgeInsets.zero,),
                  const CircleAvatar(radius: 12,backgroundColor: closeColor,child: Center(child: Text('5',style: TextStyle(color: Colors.white),)),)
                ],
              ),
            ),
            height: height, width: width, openSidePar:(){cubit.openSideBar();},),
          const Padding(
            padding:EdgeInsets.only(top: 10.0,left: 10),
            child:Text('Chats',style: CustomTextStyle.homePartTitle,),
          ),
          RecentChatWithOther(width: width, height: height,recentChatList: cubit.chatsList,isRecentChatLoading: cubit.isLoadingRecentChats,emptyMessages: 'No Tourist Talks To Yet, When Chat Starts Will Be Here..',),
        ],
      ),
    );
  }
}

