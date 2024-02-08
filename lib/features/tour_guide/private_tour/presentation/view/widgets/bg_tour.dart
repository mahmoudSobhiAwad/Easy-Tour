import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_image_pic.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/delete_edit_photo.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/tour_guide/private_tour/presentation/manager/edit_create_tour/edit_create_tour_cubit.dart';

class BGPrivateTourOption extends StatelessWidget {
  const BGPrivateTourOption({
    super.key,
    required this.height,
    required this.cubit,
    required this.width,
  });

  final double height;
  final double width;
  final CreateEditPrivateTourCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      height:height*.18,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: secondaryColor.withOpacity(0.5),),
          color: const Color(0xffF6F3F3)),
      child:cubit.bgPath==''?
      GestureDetector(
        onLongPress: (){
          showDialog(context: context, builder: (context){
            return DeleteOrEditPhoto(deleteImage: (){
              cubit.deleteImage();
            }, cropImage:()async{
              await cubit.cropImage();
            });
          });
        },
        onTap: (){
          showDialog(context: context, builder: (context){
            return  OptionPickImage(getImageFromGallery: ()async{
              await cubit.getImageFromGallery();
              },
                getImageFromCamera: ()async
                {
              await cubit.getImageFromCamera();
            });
          });

        },
        child:cubit.bgFile==null?
        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.photo_outlined,color: basicColor,size: 40,),
            SizedBox(height: 10,),
            Text('pick image as back ground for the trip',style: CustomTextStyle.commonSignDark,textAlign: TextAlign.center,)
          ],
        ):
        ClipRRect(
            borderRadius: commonBorderRadius(),
            child: Image.file(cubit.bgFile!,fit: BoxFit.fill,)),
      ):
      GestureDetector(onLongPress: (){
          showDialog(context: context, builder: (context){
            return DeleteOrEditPhoto(deleteImage: (){
              cubit.deleteImage();
            }, cropImage:()async{
              await cubit.cropImage();
            });
          });
        },
        child: ClipRRect(
            borderRadius: commonBorderRadius(),
            child: Image.network(cubit.bgPath,fit: BoxFit.fill,),
        ),
      ),
    );
  }
}