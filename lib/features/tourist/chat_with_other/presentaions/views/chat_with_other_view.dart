import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_container.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_types.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/managers/chat_with_other_cubit.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/managers/chat_with_other_states.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/views/widgets/app_bar_with_search.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/views/widgets/chat_with_other_list.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/views/widgets/other_pic_with_name.dart';
class TouristChatWithOtherView extends StatelessWidget {
  const TouristChatWithOtherView({super.key});
  @override
  Widget build(BuildContext context) {
    double width=BasicDimension.screenWidth(context);
    double height=BasicDimension.screenHeight(context);

    return BlocProvider(create: (context)=>TouristChatWithOtherCubit(guideMetaDataRepoImp: getIt.get()),
      child: BlocConsumer<TouristChatWithOtherCubit,TouristsChatWithOtherStates>(builder: (context,state){
        var cubit=BlocProvider.of<TouristChatWithOtherCubit>(context);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: EdgeInsets.only(top:height*0.03,bottom: MediaQuery.of(context).viewInsets.bottom,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                AppBarWithSearchWidget(height: height),
                OtherPeoplePicWithName(height: height, width: width,listOfGuide: cubit.tourGuidesList,isGuidesLoading: cubit.isLoadingGuides,),
                RecentChatWithOther(width: width, height: height,recentChatList:cubit.chatsList,isRecentChatLoading: cubit.isLoadingRecentChats,emptyMessages: 'you don’t have started any chat yet, when you chat with any tour guide your messages will be here',),
              ],
            ),
          ),
        );
      }, listener: (context,state){
        if(state is FailureGetChatsMetaDataState){
          showDialog(context: context, builder: (context)=> ContainerAlertWidget(
            types: AlertTypes.failed,
            onTap: ()
            {
              Navigator.pop(context);
            },
            content: '${state.errMessage}',));
        }

        if(state is FailureGetChatsMetaDataState){
          showDialog(context: context, builder: (context)=> ContainerAlertWidget(
            types: AlertTypes.failed,
            onTap: (){
              Navigator.pop(context);
            },
            content: '${state.errMessage}',));
        }
      }),);
  }
}







