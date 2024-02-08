import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_container.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_types.dart';
import 'package:prepare_project/features/tour_guide/profile/data/repos/tour_guide_profile_repo_imp.dart';
import 'package:prepare_project/features/tour_guide/profile/presentation/manager/contact_info/contact_info_cubit.dart';
import 'package:prepare_project/features/tour_guide/profile/presentation/manager/contact_info/contact_info_state.dart';
import 'package:prepare_project/features/tour_guide/profile/presentation/manager/view_profile_cubit.dart';
import 'package:prepare_project/features/tour_guide/profile/presentation/view/widgets/contact_info_body.dart';
import 'package:prepare_project/features/tour_guide/profile/presentation/view/widgets/contact_info_bottom_sheet.dart';

class ContactInfoView extends StatelessWidget {
  const ContactInfoView({super.key,required this.height,required this.width,required this.socialLinks,required this.profileViewCubit});
  final double height;
  final double width;
  final Map<String,dynamic>socialLinks;
  final TourGuideProfileViewCubit profileViewCubit;
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(create: (context)=>ContactInfoCubit(socialLinks: socialLinks,tourGuideProfileRepo: getIt.get<TourGuideProfileRepoImp>())..setEditSocialLinks(),
      child: BlocConsumer<ContactInfoCubit,ContactInfoState>(
          builder: (context,state) {
            var cubit=BlocProvider.of<ContactInfoCubit>(context);
            return Scaffold(
              bottomSheet: cubit.showBottomSheet?ContactInfoBottomSheet(height: height, width: width, cubit: cubit):null,
              body: ContactInfoBody(cubit: cubit,width: width,),
              floatingActionButton: !cubit.showBottomSheet? GestureDetector(
                onTap: (){
                  cubit.changeBottomSheet();
                },
                  child: CircleAvatar(radius: height*0.04,backgroundColor: thirdColor,child:const Icon(Icons.add,color: basicColor,size: 35,),)):null,
            );
            },
          listener: (context,state){
            if(state is FailureUpdateContactInfo){
              showDialog(context: context, builder: (context)=> ContainerAlertWidget(
                types: AlertTypes.failed,
                onTap: (){
                  Navigator.pop(context);
                },
                content: '${state.errMessage}',));
            }
            else if (state is SuccessUpdateContactInfo){
              showDialog(context: context, builder: (context)=>const ContainerAlertWidget(
                types: AlertTypes.success,
                content: 'Updated Successfully',)).then((value)
              {
                context.pop();
                profileViewCubit.getData();
              });
            }
          }),
    );
  }
}






