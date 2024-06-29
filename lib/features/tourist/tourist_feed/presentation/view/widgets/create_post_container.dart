
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/tourist/tourist_feed/presentation/manager/create_post_cubit/create_post_cubit.dart';
import 'package:prepare_project/features/tourist/tourist_feed/presentation/view/widgets/small_profile_pic.dart';
import 'package:prepare_project/features/tourist/tourist_feed/presentation/view/widgets/wrap_images.dart';
class CreatePostContainer extends StatelessWidget {
  const CreatePostContainer({
    super.key,
    required this.width,
    required this.cubit,
    required this.height,
  });

  final double width;
  final CreatePostCubit cubit;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: commonBorderRadius(),
        border: Border.all(color: thirdColor,width: 2),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SmallProfilePic(width: width),
              const SizedBox(width: 10,),
              Text(cubit.name),
            ],
          ),
          SizedBox(height: height*0.02,),
          CustomTextFormField(
            controller: cubit.controller,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            label: 'share your amazing moment in Egypt.....',
            maxLength: 300,
            maxLines: 7,
            minLine: 2,
          ),
          SizedBox(height: height*0.02,),
          ListOfImagesUsingWrap(cubit: cubit, height: height, width: width),
          SizedBox(height: height*0.02,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Camera'),
              IconButton(onPressed: (){
                cubit.getImage();
              }, icon: const Icon(Icons.photo_camera)),
              SizedBox(width: width*0.05,),
              const Text('Gallery'),
              IconButton(onPressed: (){
                cubit.getImagesFromGallery();
              }, icon: const Icon(Icons.photo_rounded)),
              SizedBox(width: width*0.05,),
              const Text('Video'),
              IconButton(onPressed: (){
                cubit.getVideo(ImageSource.gallery);
              }, icon: const Icon(Icons.video_collection)),
              
            ],
          )
        ],
      ),
    );
  }
}