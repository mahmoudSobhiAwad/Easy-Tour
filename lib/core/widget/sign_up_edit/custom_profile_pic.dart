import 'dart:io';
import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/delete_edit_photo.dart';
import 'package:prepare_project/features/sign_up/presentation/manager/sign_up_cubit.dart';

import '../../../features/sign_up/data/model/photo_name_enum.dart';

class CustomProfilePic extends StatelessWidget {
  const CustomProfilePic({super.key,required this.cubit,required this.height});
  final SignUpCubit cubit;
  final double height;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: (){
        if(cubit.profileUrl!=null)
        {
          showDialog(context: context, builder: (context)=>DeleteOrEditPhoto(
            deleteImage: () {
              cubit.deleteImage(SignUpPhotoName.profile);
            }, cropImage: ()async {
            await cubit.cropImage(SignUpPhotoName.profile);
          },));
        }
      },
      onTap:()async{
        await cubit.getImageFromCamera(SignUpPhotoName.profile);
      },
       child:
      Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            width:height*0.225,
            height: height*0.225,
            decoration:const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child:cubit.profileUrl!=null?ClipOval(child: Image.file(File(cubit.profileUrl!),fit: BoxFit.fill,)):Center(child: Image.asset('assets/login/default_profile.png',fit: BoxFit.fill,)),
          ),
          const CircleAvatar(
            radius: 16,
            backgroundColor:basicColor,
            child: Center(child: Icon(Icons.add,color: secondaryColor,size: 28,)),
          ),
        ],
      ),
    );
  }
}