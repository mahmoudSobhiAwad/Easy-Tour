// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/features/tourist/google_map/presentaion/view/google_map_view.dart';
import 'package:prepare_project/features/tourist/nearby_places/presentation/views/search_nearby_view.dart';
import 'package:prepare_project/features/tourist/profile/presentation/views/profile_view.dart';
import 'package:prepare_project/features/tourist/tourist_feed/presentation/view/tourist_feed_view.dart';
import 'package:prepare_project/features/tourist/tourist_home/data/home_ui_data/icons.dart';
import 'package:prepare_project/features/tourist/tourist_home/presentaion/manager/home_tourist_cubit.dart';
import 'package:prepare_project/features/tourist/tourist_home/presentaion/view/widgets/bottom_nav_bar_custom.dart';
import 'package:prepare_project/features/tourist/tourist_home/presentaion/view/widgets/home_tourist_first_page.dart';
import 'package:prepare_project/features/tourist/trip_history/presentation/view/trip_history_view.dart';

class HomeTouristViewUi extends StatelessWidget {
  const HomeTouristViewUi({
    super.key,
    required this.cubit,
    required this.height,
    required this.width,
    required this.animation,
    required this.scaleAnimation,
    this.currIndex,
  });

  final HomeTouristCubit cubit;
  final double height;
  final double width;
  final Animation<double> animation;
  final Animation<double> scaleAnimation;
  final int?currIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: [
        TouristHomeFirstPage(animation: animation, cubit: cubit, width: width, scaleAnimation: scaleAnimation, height: height),
        const TouristFeedView(),
        const TripHistoryView(),
        const ProfileView(showBackIcon: false),
      ][currIndex??cubit.currIndex],
      floatingActionButton:cubit.isMenuActive?null:FloatingActionButton(
        onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>const GoogleMapView()));
        },
        backgroundColor: thirdColor,
        foregroundColor: basicColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50),side:const BorderSide(width: 5,color: Colors.white,)),
        child: const Icon(Icons.location_on_rounded),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar:cubit.isMenuActive?null:MyBottomNavBar(height: height, width: width, barIcons: bottomNavIcons, changeBottomNavIndex: (int index) {
        cubit.changeBottomNavIndex(index);
      }, currIndex: cubit.currIndex,

      ),
    );
  }
}


