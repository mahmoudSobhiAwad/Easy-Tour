import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/views/widgets/chat_with_other_list.dart';
import 'package:prepare_project/features/tourist/profile/presentation/views/widgets/pic_profile_widget.dart';
class NotificationTourGuideView extends StatelessWidget {
  const NotificationTourGuideView({super.key});

  @override
  Widget build(BuildContext context) {
    final double height=BasicDimension.screenHeight(context);
    final double width=BasicDimension.screenWidth(context);
    return Scaffold(
      body: SafeArea(
          child:Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width*0.05),
                child: CustomGeneratedAiTripAppBar(height: height, width: width,appBarTitle: 'Notification',appBarStyle: CustomTextStyle.commonSignDark.copyWith(fontSize: 18),
                  menuToSaveTrip: TextButton(onPressed: null, child: Text('Clear All',style: CustomTextStyle.commonSignDark.copyWith(color: forthColor),)),),
              ),
              Expanded(
                child: SizedBox(
                  height: height*0.8,
                  child: ListView.builder(
                    padding:const EdgeInsets.symmetric(vertical: 20),
                      itemBuilder: (context,index){
                    return CustomDismissible(
                      child: Column(
                        children: [
                          NotificationItemWidget(height: height, width: width),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.0,left: width*0.125,right: width*0.125),
                            child: SizedBox(
                                width: width*0.7,
                                child: Divider(thickness: 3,color: entertainmentColor.withOpacity(0.6),)),
                          ),
                        ],
                      ),
                    );
                  },itemCount: 7,
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}

class NotificationItemWidget extends StatelessWidget {
  const NotificationItemWidget({super.key,required this.height,required this.width});
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: SizedBox(
        width: width,
        height: height*0.1,
        child: ListTile(
          leading: ProfilePicWidget(imageUrl: '', height: height*0.07),
          title: const Text('Toni Kroos',style:CustomTextStyle.commonSignDark,),
          subtitle: SizedBox(width: width*0.5,child: const Text('Send You request to book a trip',style: CustomTextStyle.commonFontThinLight,)),
          trailing: Column(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Sun 12:40 PM',style: CustomTextStyle.commonSignLight.copyWith(fontSize: 12),),
              const CircleAvatar(backgroundColor: forthColor,radius: 7.5,),
            ],
          ),
        ),
      ),
    );
  }
}

