import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_image_pic.dart';
import 'package:prepare_project/features/tourist/profile/presentation/manager/edit_profile/edit_profile_cubit.dart';
import 'package:prepare_project/features/tourist/profile/presentation/views/widgets/cover_profile_wiget.dart';
import 'package:prepare_project/features/tourist/profile/presentation/views/widgets/pic_profile_widget.dart';

class UserProfilePicAndCover extends StatelessWidget {
  const UserProfilePicAndCover({super.key,required this.widgetHeight,this.widgetWidth,required this.cubit});
  final double widgetHeight;
  final double? widgetWidth;
  final EditProfileCubit cubit;
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: widgetHeight*0.3,
      child: Stack(
        clipBehavior: Clip.antiAlias,
        children: [
          InkWell(
            onTap: (){
              showDialog(context: context, builder: (context)=>OptionPickImage(
                getImageFromGallery: ()async{
                 await cubit.getImageFromGallery('cover');
                },
                // cropImage: ()async{
                //  await cubit.cropImage('cover');
                // },
                getImageFromCamera: ()async{
                 await cubit.getImageFromCamera('cover');
                },
              ));
            },
            child: CoverPictureWidget(widgetHeight: widgetHeight*0.2, widgetWidth: widgetWidth, coverUrl: cubit.coverUrl, coverFile: cubit.coverFile,),
          ),
          Positioned(
            top: widgetHeight*0.13,
            left: widgetWidth!*0.31,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                ProfilePicWidget(imageUrl: cubit.imageUrl,height:widgetHeight*0.15 ,width:widgetHeight*0.15,profileFile: cubit.profileFile,),
                CircleAvatar(
                  radius: 15,
                  backgroundColor: basicColor,
                  child: Center(
                      child:IconButton(onPressed: ()
                      {
                        showDialog(context: context, builder: (context)=>OptionPickImage(
                        getImageFromGallery: ()async{
                         await cubit.getImageFromGallery('profile');
                        },
                        // cropImage: ()async{
                        //  await cubit.cropImage('profile');
                        // },
                        getImageFromCamera: ()async{
                         await cubit.getImageFromCamera('profile');
                        },
                    ));
                        }, icon:const FaIcon(FontAwesomeIcons.plus,color: Colors.white,size: 22,),padding: EdgeInsets.zero,)),)
              ],
            ),
          ),
        ],
      ),
    );
  }
}



