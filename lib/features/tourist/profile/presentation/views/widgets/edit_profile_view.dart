import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_container.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_types.dart';
import 'package:prepare_project/features/tourist/profile/data/models/tourist_info_model.dart';
import 'package:prepare_project/features/tourist/profile/data/repos/profie_repo_imp.dart';
import 'package:prepare_project/features/tourist/profile/presentation/manager/edit_profile/edit_profile_cubit.dart';
import 'package:prepare_project/features/tourist/profile/presentation/manager/edit_profile/edit_profile_state.dart';
import 'package:prepare_project/features/tourist/profile/presentation/views/widgets/edit_profile_body.dart';


class ProfileEditView extends StatelessWidget {
  const ProfileEditView({super.key,required this.model});
  final TouristInfoModel model;
  @override
  Widget build(BuildContext context) {
    double height=BasicDimension.screenHeight(context);
    double width=BasicDimension.screenWidth(context);
    return BlocProvider(
      create:(context)=>EditProfileCubit(profileRepo: getIt.get<ProfileRepoImpl>(), model: model),
      child:BlocConsumer(builder: (context,state){
        var cubit=BlocProvider.of<EditProfileCubit>(context);
        return ProfileEdit(height: height, width: width, cubit: cubit);
      }, listener: (context,state){
        if(state is SuccessEditProfileState){
            showDialog(context: context, builder: (context)=> const ContainerAlertWidget(
              types: AlertTypes.success,
              content: 'Updated Successfully',),).then((value){
                Navigator.pop(context);
            });
        }
        else if (state is FailureEditProfileState){
          showDialog(context: context, builder: (context)=> ContainerAlertWidget(
              types: AlertTypes.failed,
              onTap: (){
                Navigator.pop(context);
              },
              content: '${state.errMessage}',));
        }
      }) ,
    );
  }
}





