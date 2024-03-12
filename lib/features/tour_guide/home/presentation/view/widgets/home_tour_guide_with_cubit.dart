import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/features/tour_guide/basic/presentation/manager/basic_home_cubit.dart';
import 'package:prepare_project/features/tour_guide/home/data/repo/tour_guide_home_repo_imp.dart';
import 'package:prepare_project/features/tour_guide/home/presentation/manager/home_tour_guide_cubit.dart';
import 'package:prepare_project/features/tour_guide/home/presentation/manager/home_tour_guide_state.dart';
import 'package:prepare_project/features/tour_guide/home/presentation/view/widgets/tour_guide_home_view_ui.dart';
import 'package:prepare_project/features/tourist/chat_with_other/data/repos/get_guide_meta_data/get_guide_meta_data_repo_imp.dart';

import '../../../../../../core/utilities/go_router/go_router.dart';
import '../../../../../../core/widget/custom_alert_widget/alert_container.dart';
import '../../../../../../core/widget/custom_alert_widget/alert_types.dart';
class TourGuideHomeWithProvider extends StatelessWidget {
  const TourGuideHomeWithProvider({
    super.key,
    required this.animationController,
    required this.scaleAnimation,
    required this.animation,

  });

  final AnimationController animationController;
  final Animation<double> scaleAnimation;
  final Animation<double> animation;


  @override
  Widget build(BuildContext context) {
    double height=BasicDimension.screenHeight(context);
    double width=BasicDimension.screenWidth(context);
    return BlocProvider(
      create: (context)=>TourGuideHomeCubit(
          controller: animationController,
          homeTourGuideRepoImp: getIt.get<HomeTourGuideRepoImp>(),
          guideMetaDataRepoImp: getIt.get<GuideMetaDataAndChatRecentRepoImp>())..connect()..getRecentChats(),
      child: BlocConsumer<TourGuideHomeCubit,TourGuideHomeStates>(
        builder: (context,state){
          var cubit=BlocProvider.of<TourGuideHomeCubit>(context);
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
              child:HomeTourGuideViewUi(height: height,width: width,scaleAnimation: scaleAnimation,animation: animation, cubit: cubit,),
            ),
          );
        },
        listener: (context,state){
          var basicCubit=BlocProvider.of<BasicHomeCubit>(context);
          if(state is ChangeTourGuideHomeMenuState)
          {
            basicCubit.changeMenuState();
          }
          else if(state is SuccessLogOutTourGuideState)
          {
            context.go(RouterApp.kLoginView);
          }
          else if(state is FailureLogOutTourGuideState)
          {
            showDialog(context: context, builder: (context)=>ContainerAlertWidget(types: AlertTypes.failed,content:state.errMessage,onTap: (){
              context.pop();
            },));
          }
        },

      ),
    );
  }
}