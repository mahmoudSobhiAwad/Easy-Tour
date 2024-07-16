import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_container.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_types.dart';
import 'package:prepare_project/features/tour_guide/basic/presentation/manager/basic_home_cubit.dart';
import 'package:prepare_project/features/tour_guide/basic/presentation/manager/basic_home_state.dart';
import 'package:prepare_project/features/tour_guide/home/data/data_ui/icons.dart';
import 'package:prepare_project/features/tour_guide/home/presentation/view/tour_guide_home_view.dart';
import 'package:prepare_project/features/tour_guide/private_tour/presentation/view/private_tour_view.dart';
import 'package:prepare_project/features/tour_guide/tour_guide_feed/presentation/views/tour_guide_feed_view.dart';
import '../../../../tourist/tourist_home/presentaion/view/widgets/bottom_nav_bar_custom.dart';
import '../../../profile/presentation/view/tour_guide_profile_view.dart';
class BasicHome extends StatelessWidget {
  const BasicHome({super.key});
  @override
  Widget build(BuildContext context) {
    double height=BasicDimension.screenHeight(context);
    double width=BasicDimension.screenWidth(context);
    return BlocProvider(create: (context)=>BasicHomeCubit(),
      child: BlocBuilder<BasicHomeCubit,BasicHomeState>(
          builder: (context,state){
        var cubit=BlocProvider.of<BasicHomeCubit>(context);
        return WillPopScope(
          onWillPop: ()async{
            if(!cubit.noDrawer){
              cubit.close();
              return false;
            }
            else{
              final getOut=await
              showDialog<bool>(context: context, builder: (context)=>ContainerAlertWidget(
                types: AlertTypes.leaveApp,content:'Are You Sure To Leave The App ',
                onTapYes: (){
                  Navigator.pop(context,true);
                },
                onTapNo: (){
                  Navigator.pop(context,false);
                },

              ));
              return getOut!;
            }
          },
          child: Scaffold(
            extendBody: true,
            body: [const TourGuideHomeView(),PrivateToursView(width: width,height: height,),const TourGuideFeedsView(),TourGuideProfileView(height: height,width: width,),][cubit.currIndex],
            bottomNavigationBar:
            cubit.noDrawer? MyBottomNavBar(
              enableClip: false,
              height: height,
              width: width,
              barIcons: tourGuideBottomNavIcon,
              changeBottomNavIndex: (int index)
              {
                cubit.changeBottomNavIndex(index);
                },
              currIndex: cubit.currIndex,): null,
          ),
        );
      }),
    );
  }
}

