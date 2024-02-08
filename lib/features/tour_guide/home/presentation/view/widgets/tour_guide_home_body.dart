import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tour_guide/home/presentation/manager/home_tour_guide_cubit.dart';
import 'package:prepare_project/features/tourist/tourist_home/presentaion/view/widgets/app_bar.dart';

class HomeTourGuideBody extends StatelessWidget {
  const HomeTourGuideBody({super.key,required this.cubit,required this.height,required this.width});
  final TourGuideHomeCubit cubit;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40,bottom: 10,right: 20,left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          cubit.isMenuActive? const SizedBox(height: 0,):HomeTouristTourGuideAppBar(
            rightIcon: Stack(
              alignment: Alignment.topRight,
              children: [
                IconButton(onPressed: (){},icon:const Icon(Icons.notifications_none_rounded,color: basicColor,size: 35,),padding: EdgeInsets.zero,),
                const CircleAvatar(radius: 12,backgroundColor: closeColor,child: Center(child: Text('5',style: TextStyle(color: Colors.white),)),)
              ],
            ),
            height: height, width: width, openSidePar:(){cubit.openSideBar();},),
          const Padding(
            padding:EdgeInsets.only(top: 10.0,left: 5),
            child:Text('Chats',style: CustomTextStyle.homePartTitle,),
          ),
          Expanded(
              child: ListView.builder(
                physics:const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      width: width,
                      height: height*0.1,
                      decoration: BoxDecoration(
                      color: thirdColor,
                      borderRadius: BorderRadius.circular(20),
                      ),),
                  );
                  },itemCount: 20,)),
        ],
      ),
    );
  }
}

