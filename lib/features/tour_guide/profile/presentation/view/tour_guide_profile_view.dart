import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_container.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_types.dart';
import 'package:prepare_project/features/tour_guide/profile/data/repos/tour_guide_profile_repo_imp.dart';
import 'package:prepare_project/features/tour_guide/profile/presentation/manager/view_profile_cubit.dart';
import 'package:prepare_project/features/tour_guide/profile/presentation/manager/view_profile_state.dart';
import 'package:prepare_project/features/tour_guide/profile/presentation/view/widgets/custom_guide_profile_pic.dart';
import 'package:prepare_project/features/tour_guide/profile/presentation/view/widgets/profile_info_view.dart';
class TourGuideProfileView extends StatelessWidget {
  const TourGuideProfileView({super.key,required this.height,required this.width});
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context)=>TourGuideProfileViewCubit(tourGuideProfileRepo: getIt.get<TourGuideProfileRepoImp>())..getData(),
      child: BlocConsumer<TourGuideProfileViewCubit,TourGuideProfileViewState>(
          builder: (context,state){
            var cubit=BlocProvider.of<TourGuideProfileViewCubit>(context);
           return cubit.showLoading?const Center(child: CircularProgressIndicator(color: basicColor,),) :Column(
              children: [
                ProfilePicWithClipper(height: height, width: width,profileUrl: cubit.profileUrl,),
                Text('${cubit.firstName} ${cubit.lastName}',style: CustomTextStyle.commonSignDark,),
                TourGuideProfileInfo(height: height,cubit: cubit,width: width,),
              ],
            );
          },
          listener: (context,state)
          {
            if(state is FailureGetInfoTourGuideProfileView){
              showDialog(context: context, builder: (context)=> ContainerAlertWidget(
                types: AlertTypes.failed,
                onTap: (){
                  context.pop();
                },
                content: '${state.errMessage}',));
            }

      }),
    );
  }
}






