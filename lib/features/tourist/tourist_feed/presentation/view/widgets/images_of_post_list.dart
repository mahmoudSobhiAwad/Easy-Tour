import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/tourist_feed/data/model/post_model.dart';
class ImagesOfPostList extends StatelessWidget {
  const ImagesOfPostList({
    super.key,
    required this.mediaLinks,
    required this.height,
    required this.width,
  });

  final List<MediaPathWithType> mediaLinks;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ...List.generate(mediaLinks.length>2?2:mediaLinks.length, (index){
          return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  mediaLinks[index].type==MediaType.image? Image.network(mediaLinks[index].path,
                    height: height*0.3,fit: BoxFit.cover,width: mediaLinks.length>1?width*0.42:width*0.85,
                    color:index>0 && mediaLinks.length-2!=0?basicColor.withOpacity(0.35):null,
                    colorBlendMode:index>0 && mediaLinks.length-2!=0? BlendMode.srcOver:null,
                    filterQuality: FilterQuality.high,):
                  ColoredBox(
                    color: basicColor,
                    child: SizedBox(
                      height: height*0.3,
                      width: mediaLinks.length==1?width*0.85:width*0.42,
                      child: Icon(Icons.play_circle_outline_sharp,color: whiteColor,size: 40,),
                    ),
                  ),
                  index>0 && mediaLinks.length-2!=0?Text('+${mediaLinks.length-2}',style: CustomTextStyle.font16NormalWhite,):const SizedBox(),
                ],
              ));
        })
      ],
    );
  }
}