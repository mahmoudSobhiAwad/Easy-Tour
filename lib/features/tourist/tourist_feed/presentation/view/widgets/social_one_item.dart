import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/function/set_app_state.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/tourist/tourist_feed/data/model/post_model.dart';
import 'package:prepare_project/features/tourist/tourist_feed/presentation/view/widgets/images_of_post_list.dart';
import 'package:prepare_project/features/tourist/tourist_feed/presentation/view/widgets/list_of_images_preview.dart';
import 'package:prepare_project/features/tourist/tourist_feed/presentation/view/widgets/poster_info.dart';

class SocialItemPost extends StatelessWidget {
  final double width;
  final double height;
  final PostModel model;
  final String role;
  final int initIndex;
  const SocialItemPost({super.key,required this.role,required this.height,required this.width,required this.model,this.initIndex=0});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: commonBorderRadius(),
        border: Border.all(color: secondaryColor,width: 2),
      ),
      padding:const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PosterInfo(width: width,model: model,role: role,),
          SizedBox(height: height*0.02,),
          Text('${model.postText}',),
          SizedBox(height: height*0.02,),
          GestureDetector(
              onTap: ()async{

                // Navigator.push(context, MaterialPageRoute(builder: (context){
                //   return ListOfImagesPreview(imagesLinks: model.mediaPosts??[], height: height, width: width,initPage: initIndex,);
                // }));
              },
              child: ImagesOfPostList(mediaLinks: model.mediaPosts??[], height: height, width: width)),
          model.sourceEmail==SetAppState.prefs?.getString('email')?
          const SizedBox() : const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text('Send Message',style: CustomTextStyle.fontBold14,),
                  IconButton(onPressed: null, icon: Icon(Icons.send_rounded),),
                ],
              ),
              IconButton(onPressed: null, icon: Icon(Icons.bookmark_border)),
            ],
          )
        ],
      ),
    );
  }
}

