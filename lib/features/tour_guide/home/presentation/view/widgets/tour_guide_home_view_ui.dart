import 'dart:math'show pi;

import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/features/tour_guide/home/data/data_ui/icons.dart';
import 'package:prepare_project/features/tour_guide/home/presentation/manager/home_tour_guide_cubit.dart';
import 'package:prepare_project/features/tour_guide/home/presentation/view/widgets/tour_guide_home_body.dart';
import 'package:prepare_project/features/tourist/tourist_home/presentaion/view/widgets/my_cutom_drawer.dart';

class HomeTourGuideViewUi extends StatelessWidget {
  const HomeTourGuideViewUi({super.key,required this.cubit,required this.height,required this.width,required this.animation,required this.scaleAnimation});
  final TourGuideHomeCubit cubit;
  final double height;
  final double width;
  final Animation<double> animation;
  final Animation<double> scaleAnimation;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()..setEntry(3, 2, 0.001)
            ..rotateY(animation.value-30*animation.value*pi/180),
          child: Transform.translate(
              offset: Offset(cubit.isMenuActive?width*0.7:0,0),
              child: Transform.scale(
                scale: scaleAnimation.value,
                child: HomeTourGuideBody(cubit: cubit,width: width,height: height,),
              )),
        ),
        cubit.isMenuActive?
        MyDrawer(
            role: Role.tourGuide,
            touristDrawerList: tourGuideDrawerIcon,
            height: height,
            width: width,
            name: cubit.touristName,
            profileUrl: cubit.profileUrl,
            onClose:(){ cubit.closeSideBar();},
            logOut:()async{
              await  cubit.logOut();
            }
        )
            :const SizedBox(),

      ],
    );


  }
}