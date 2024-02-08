import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_image_pic.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/tour_guide/profile/presentation/manager/edit_personal_info_cubit/profile_info_cubit.dart';
import 'package:prepare_project/features/tour_guide/profile/presentation/view/widgets/custom_guide_profile_pic.dart';
import 'package:prepare_project/features/tour_guide/profile/presentation/view/widgets/text_form_personal_info.dart';
class EditTourGuideProfileBody extends StatelessWidget {
  const EditTourGuideProfileBody({
    super.key,
    required this.height,
    required this.width,
    required this.cubit,
  });

  final double height;
  final double width;
  final EditProfileInfoGuideCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom+10),
        child: Column(children:[
          Stack(
            alignment: Alignment.topLeft,
            children: [
              ProfilePicWithClipper(height: height, width: width,
                editProfilePhoto:(){
                showDialog(context: context, builder:(context)=>OptionPickImage(
                    getImageFromGallery:()async{ await cubit.getImageFromGallery();}
                    , getImageFromCamera: ()async{
                      await cubit.getImageFromCamera();
                }));
                },
                profileUrl: cubit.profileUrl,enableEdit: true,profileFile: cubit.profileFile,),
              IconButton(
                  padding: const EdgeInsets.all(30),
                  onPressed: (){
                    context.pop();
                  }, icon: const Icon(Icons.close,color: basicColor,))
            ],
          ),
          const SizedBox(height: 20,),
          TextFormInfoData(height: height, cubit: cubit, width: width),
          CustomLoginButton(
            label: 'Update',onTap: (){
            cubit.updateTourGuideInfo();
          },isLoading: cubit.isLoading,
          ),
        ]),
      ),
    );
  }
}