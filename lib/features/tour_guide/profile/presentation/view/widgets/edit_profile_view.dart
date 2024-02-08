import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_container.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_types.dart';
import 'package:prepare_project/features/tour_guide/profile/data/model/guide_personal_info_model.dart';
import 'package:prepare_project/features/tour_guide/profile/data/repos/tour_guide_profile_repo_imp.dart';
import 'package:prepare_project/features/tour_guide/profile/presentation/manager/edit_personal_info_cubit/profile_info_cubit.dart';
import 'package:prepare_project/features/tour_guide/profile/presentation/manager/edit_personal_info_cubit/profile_info_state.dart';
import 'package:prepare_project/features/tour_guide/profile/presentation/view/widgets/eidt_personal_info.dart';

import '../../manager/view_profile_cubit.dart';

class EditTourGuideProfileView extends StatelessWidget {
  const EditTourGuideProfileView({super.key,required this.model,required this.profileViewCubit});
  final TourGuidePersonalInfoModel? model;
  final TourGuideProfileViewCubit profileViewCubit;
  @override
  Widget build(BuildContext context) {
    double height=BasicDimension.screenHeight(context);
    double width=BasicDimension.screenWidth(context);
    return BlocProvider(
        create: (context)=>EditProfileInfoGuideCubit(personalInfoModel: model, tourGuideProfileRepo: getIt.get<TourGuideProfileRepoImp>())..editFormField(),
        child: BlocConsumer<EditProfileInfoGuideCubit,EditGuidePersonalState>(
            builder: (context,state){
              var cubit=BlocProvider.of<EditProfileInfoGuideCubit>(context);
              return EditTourGuideProfileBody(height: height, width: width, cubit: cubit);
            },
            listener: (context,state){
              if(state is SuccessEditGuidePersonalState){
                showDialog(context: context, builder: (context)=>const ContainerAlertWidget(
                  types: AlertTypes.success,
                  content: 'Updated Successfully',)).then((value){
                  context.pop();
                  profileViewCubit.getData();
                });
              }
            }
        )
    );
  }
}





