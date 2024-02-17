import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/features/tourist/profile/data/repos/profie_repo_imp.dart';
import 'package:prepare_project/features/tourist/profile/presentation/manager/profile_cubit.dart';
import 'package:prepare_project/features/tourist/profile/presentation/manager/profile_states.dart';
import 'package:prepare_project/features/tourist/profile/presentation/views/widgets/tourist_profile_body.dart';

import '../../../../../core/widget/custom_alert_widget/alert_container.dart';
import '../../../../../core/widget/custom_alert_widget/alert_types.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    double height=BasicDimension.screenHeight(context);
    double width=BasicDimension.screenWidth(context);
    return  BlocProvider(
      create: (context)=>ProfileCubit(profileRepo: getIt.get<ProfileRepoImpl>())..getProfileData(),
        child:BlocConsumer<ProfileCubit,ProfileStates>(
        builder: (context,state){
          var cubit=BlocProvider.of<ProfileCubit>(context);
          return  Scaffold(
            resizeToAvoidBottomInset: false,
            body:cubit.showGetLoading?
            const Center(child: CircularProgressIndicator(color: basicColor,),) :
            TouristProfileBody(screenWidth: width, screenHeight: height,cubit: cubit,),
          );
        },
        listener: (context,state){
          var cubit=BlocProvider.of<ProfileCubit>(context);
          if(state is FailureGetInfoTouristDataState) {
            showDialog(context: context, builder: (context)=> ContainerAlertWidget(
              types: AlertTypes.failed,
              onTap: (){
                context.pop();
              },
              content: '${state.errMessage}',));

          }
          else if(state is RefreshTokenFailureState) {
            showDialog(context: context, builder: (context)=> ContainerAlertWidget(
              types: AlertTypes.failed,
              onTap: (){
                cubit.getProfileData().then((value){Navigator.pop(context);});
              },
              content: '${state.errMessage}',));
          }


        },
      )
    );
  }
}









