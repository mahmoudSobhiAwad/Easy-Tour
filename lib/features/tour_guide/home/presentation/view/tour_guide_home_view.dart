import 'package:flutter/material.dart';
import 'package:prepare_project/features/tour_guide/home/presentation/view/widgets/home_tour_guide_with_cubit.dart';

class TourGuideHomeView extends StatefulWidget {
  const TourGuideHomeView({super.key,});
  @override
  State<TourGuideHomeView> createState() => _TourGuideHomeViewState();
}

class _TourGuideHomeViewState extends State<TourGuideHomeView> with SingleTickerProviderStateMixin{
  late AnimationController animationController;
  late Animation<double> animation;
  late Animation<double> scaleAnimation;
  @override
  void initState()
  {
    super.initState();
    animationController=AnimationController(vsync: this,duration:const Duration(milliseconds:500),)..addListener(() {setState(() {});});
    animation=Tween<double>(begin:0 ,end: 1).animate(CurvedAnimation(parent: animationController, curve: Curves.bounceInOut));
    scaleAnimation=Tween<double>(begin:1 ,end: 0.9).animate(CurvedAnimation(parent: animationController, curve: Curves.bounceInOut));
  }
  @override
  void dispose(){
    super.dispose();
    animationController.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return TourGuideHomeWithProvider(animationController: animationController,scaleAnimation: scaleAnimation, animation: animation,);
  }
}







