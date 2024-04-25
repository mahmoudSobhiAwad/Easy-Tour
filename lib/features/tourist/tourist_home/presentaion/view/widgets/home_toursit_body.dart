import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_project/core/utilities/go_router/go_router.dart';
import 'package:prepare_project/features/tourist/tourist_home/presentaion/manager/home_tourist_cubit.dart';
import 'package:prepare_project/features/tourist/tourist_home/presentaion/view/widgets/ai_part.dart';
import 'package:prepare_project/features/tourist/tourist_home/presentaion/view/widgets/app_bar.dart';
import 'package:prepare_project/features/tourist/tourist_home/presentaion/view/widgets/booking_part.dart';
import 'package:prepare_project/features/tourist/tourist_home/presentaion/view/widgets/dicover_part.dart';
import 'package:prepare_project/features/tourist/tourist_home/presentaion/view/widgets/helper_part.dart';

class HomeTouristBody extends StatelessWidget {
  const HomeTouristBody({super.key, required this.height, required this.width,required this.cubit});
  final double height;
  final double width;
  final HomeTouristCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const  EdgeInsets.only(left: 15.0,top:30),
      child: SizedBox(
        height: height*0.9,
        child: ListView(
          padding: const EdgeInsets.only(bottom: 40),
          children: [
            HomeTouristTourGuideAppBar(
              rightIcon: IconButton(onPressed: (){
                context.push(RouterApp.kChatTouristView,);
              },icon: const FaIcon(FontAwesomeIcons.facebookMessenger,),),
              height: height, width: width, openSidePar:(){cubit.openSideBar();},),
            const SizedBox(height: 20,),
            BookingPart(height: height, width: width,isMenuActive: cubit.isMenuActive,),
            const SizedBox(height: 20,),
            DiscoverPart(height: height, width: width,isMenuActive: cubit.isMenuActive),
            const SizedBox(height: 20,),
            AiPart(height: height, width: width,isMenuActive: cubit.isMenuActive),
            const SizedBox(height: 20,),
            HelperPart(height: height, width: width,isMenuActive: cubit.isMenuActive),
          ],
        ),
      ),
    );
  }
}