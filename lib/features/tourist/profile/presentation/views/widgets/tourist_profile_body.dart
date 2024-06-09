import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/go_router/go_router.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/profile/presentation/manager/profile_cubit.dart';
import 'package:prepare_project/features/tourist/profile/presentation/views/widgets/bio_edit_button.dart';
import 'package:prepare_project/features/tourist/profile/presentation/views/widgets/cover_profile_wiget.dart';
import 'package:prepare_project/features/tourist/profile/presentation/views/widgets/pic_profile_widget.dart';

class TouristProfileBody extends StatelessWidget {
  const TouristProfileBody({super.key,required this.screenWidth,required this.screenHeight,required this.cubit,this.showBackIcon=true});
  final double screenHeight;
  final double screenWidth;
  final ProfileCubit cubit;
  final bool showBackIcon;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(top:screenHeight*0.05,right: 15,left: 15,bottom:20),
      child: RefreshIndicator(
        color: basicColor,
        backgroundColor: thirdColor,
        onRefresh: ()async{
          cubit.getProfileData();
        },
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
           showBackIcon?
           SizedBox(
              height: screenHeight*0.04,
              child: Row(
                children: [
                  IconButton(
                      onPressed: (){
                        context.go(RouterApp.kHomeView);
                        },
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                      icon:const Icon(Icons.arrow_back_ios_new,)
                  ),
                  Text('${cubit.name}',style: CustomTextStyle.fontBold14,),
                ],
              ),
            ):
           const SizedBox(),
            SizedBox(height: screenHeight*0.01,),
            SizedBox(
              height: screenHeight*0.24,
              width: screenWidth,
              child: Stack(
                children: [
                  CoverPictureWidget(widgetHeight: screenHeight*0.2, widgetWidth: screenWidth, coverUrl: cubit.touristModel?.coverUrl, coverFile: null,),
                  Positioned(
                      top: screenHeight*0.15,
                      left: screenWidth*0.05,
                      child: ProfilePicWidget(
                        imageUrl: cubit.touristModel?.profileUrl, height: screenHeight*0.09,
                      ))
                ],
              ),
            ),
            BioAndEditButton(screenHeight: screenHeight, cubit: cubit, screenWidth: screenWidth)
          ],
        ),
      ),
    );
  }
}