import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/features/tourist/google_map/presentaion/view/google_map_view.dart';
import 'package:prepare_project/features/tourist/profile/presentation/views/profile_view.dart';
import 'package:prepare_project/features/tourist/tourist_feed/presentation/view/tourist_feed_view.dart';
import 'package:prepare_project/features/tourist/tourist_home/data/home_ui_data/icons.dart';
import 'package:prepare_project/features/tourist/tourist_home/presentaion/manager/home_tourist_cubit.dart';
import 'package:prepare_project/features/tourist/tourist_home/presentaion/view/widgets/bottom_nav_bar_custom.dart';
import 'package:prepare_project/features/tourist/tourist_home/presentaion/view/widgets/home_toursit_body.dart';
import 'package:prepare_project/features/tourist/tourist_home/presentaion/view/widgets/my_cutom_drawer.dart';
import 'dart:math' show pi;
class HomeTouristViewUi extends StatelessWidget {
  const HomeTouristViewUi({
    super.key,
    required this.cubit,
    required this.height,
    required this.width,
    required this.animation,
    required this.scaleAnimation,
  });

  final HomeTouristCubit cubit;
  final double height;
  final double width;
  final Animation<double> animation;
  final Animation<double> scaleAnimation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: [
        TouristHomeFirstPage(animation: animation, cubit: cubit, width: width, scaleAnimation: scaleAnimation, height: height),
        const TouristFeedView(),
        const GoogleMapView(),
        const ProfileView(),
      ][cubit.currIndex],
      floatingActionButton:cubit.isMenuActive?null:FloatingActionButton(
        onPressed: (){},
        backgroundColor: thirdColor,
        foregroundColor: basicColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50),side:const BorderSide(width: 5,color: Colors.white,)),
        child: const Icon(Icons.camera_alt_rounded),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar:cubit.isMenuActive?null:MyBottomNavBar(height: height, width: width, barIcons: bottomNavIcons, changeBottomNavIndex: (int index) {
        cubit.changeBottomNavIndex(index);
      }, currIndex: cubit.currIndex,

      ),
    );
  }
}

class TouristHomeFirstPage extends StatelessWidget {
  const TouristHomeFirstPage({
    super.key,
    required this.animation,
    required this.cubit,
    required this.width,
    required this.scaleAnimation,
    required this.height,
  });

  final Animation<double> animation;
  final HomeTouristCubit cubit;
  final double width;
  final Animation<double> scaleAnimation;
  final double height;

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
                  child: HomeTouristBody(height: height, width: width,cubit:cubit,))),
        ),
        cubit.isMenuActive?MyDrawer(
            height: height,
            touristDrawerList: touristDrawerListTile,
            width: width,
            name: cubit.touristName,
            profileUrl: cubit.profileUrl,
            onClose:(){ cubit.closeSideBar();},
            logOut:()async{
              await  cubit.logOut();
            })
            :const SizedBox(),

      ],
    );
  }
}
