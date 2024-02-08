import 'package:flutter/material.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/sign_up/data/model/photo_name_enum.dart';
import 'package:prepare_project/features/sign_up/presentation/manager/sign_up_cubit.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/delete_edit_photo.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/verify_id_with_ai.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_image_pic.dart';

class FirstColumnOfSignUpTourGuide extends StatelessWidget {
  const FirstColumnOfSignUpTourGuide({super.key,required this.cubit,required this.height});
final SignUpCubit cubit;
final double height;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
            onLongPress: (){
              if(cubit.ministryID!=null)
              {
              showDialog(context: context, builder: (context)=>DeleteOrEditPhoto(
                 deleteImage: () {
                  cubit.deleteImage(SignUpPhotoName.ministryId);
              }, cropImage: ()async {
                await cubit.cropImage(SignUpPhotoName.ministryId);
              },));
              }
            },
            onTap:(){
            showDialog(
              context: context, builder: (context)=>OptionPickImage(
              getImageFromGallery: () async{
                await cubit.getImageFromGallery(SignUpPhotoName.ministryId);
               }, cropImage: ()async {
              await cubit.cropImage(SignUpPhotoName.ministryId);
            }, getImageFromCamera: () async{
              await cubit.getImageFromCamera(SignUpPhotoName.ministryId);
            },
              ),);
          },
            child: VerificationIdWithAi(imageId: cubit.ministryID,height: height,tourGuidId: 'assets/login/ministry_id.png',imageTitle: 'Ministry ID',)),
        InkWell(
          onLongPress: (){
            if(cubit.syndicateID!=null)
            {
            showDialog(context: context, builder: (context)=>DeleteOrEditPhoto(
              deleteImage: () {
                cubit.deleteImage(SignUpPhotoName.nId);
            }, cropImage: () async{
              await cubit.cropImage(SignUpPhotoName.nId);
            },),
            );
            }
          },
          onTap: (){
            showDialog(
              context: context, builder: (context)=>OptionPickImage(
              getImageFromGallery: () async{
                await cubit.getImageFromGallery(SignUpPhotoName.nId);
              }, cropImage: ()async {
              await cubit.cropImage(SignUpPhotoName.nId);
            }, getImageFromCamera: () async{
              await cubit.getImageFromCamera(SignUpPhotoName.nId);
            },
              ),);
          },
            child:  VerificationIdWithAi(imageId: cubit.syndicateID,height: height,tourGuidId: 'assets/login/syndicate_id.png', imageTitle: ' Syndicate ID',),),
        const SizedBox(height: 20,),
        CustomLoginButton(
          label:'Next',
          onTap:(){
            cubit.checkExitOfImages();
          },
        ),
      ],
    );
  }
}
