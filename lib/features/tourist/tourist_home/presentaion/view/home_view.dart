import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/core/utilities/go_router/go_router.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_types.dart';
import 'package:prepare_project/features/tourist/tourist_home/data/repo/home_tourist_repo_impl.dart';
import 'package:prepare_project/features/tourist/tourist_home/presentaion/manager/home_tourist_cubit.dart';
import 'package:prepare_project/features/tourist/tourist_home/presentaion/manager/home_tourist_state.dart';
import 'package:prepare_project/features/tourist/tourist_home/presentaion/view/widgets/home_tourist_view_ui.dart';

import '../../../../../core/widget/custom_alert_widget/alert_container.dart';


class HomeTouristView extends StatefulWidget {
  const HomeTouristView({super.key});

  @override
  State<HomeTouristView> createState() => _HomeTouristViewState();
}

class _HomeTouristViewState extends State<HomeTouristView> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  late Animation<double> scaleAnimation;
  @override
  void initState(){
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
    double height=BasicDimension.screenHeight(context);
    double width=BasicDimension.screenWidth(context);
    return  BlocProvider(
      create: (context)=>HomeTouristCubit(controller: animationController,homeTouristRepoImp: getIt.get<HomeTouristRepoImp>()),
      child: BlocConsumer<HomeTouristCubit,HomeTouristState>(
        builder: (context,state){
          var cubit=BlocProvider.of<HomeTouristCubit>(context);
          return WillPopScope(
            onWillPop: ()async{
              if(cubit.isMenuActive){
                cubit.closeSideBar();
                return false;
              }
              else{
                return true;
              }
            },
            child: GestureDetector(
              onHorizontalDragStart: (details){
                if(cubit.isMenuActive&&details.globalPosition>Offset(width*0.7,0)){
                  cubit.closeSideBar();
                }
              },
              onHorizontalDragEnd: (details){
                if(details.primaryVelocity! > 0&& cubit.isMenuActive==false){
                  cubit.openSideBar();
                }
              },
              child: HomeTouristViewUi(cubit: cubit, height: height, width: width, animation: animation, scaleAnimation: scaleAnimation),
            ),
          );
        },
        listener: (context,state){
          if(state is SuccessLogOutState){
            context.go(RouterApp.kLoginView);
          }
          if(state is FailureLogOutState){
            showDialog(context: context, builder: (context)=>ContainerAlertWidget(types: AlertTypes.failed,content:state.errMessage,onTap: (){
              context.pop();
            },));
          }
        },

      ),
    );
  }
}











