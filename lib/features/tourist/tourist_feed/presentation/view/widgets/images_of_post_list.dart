import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
class ImagesOfPostList extends StatelessWidget {
  const ImagesOfPostList({
    super.key,
    required this.imagesLinks,
    required this.height,
    required this.width,
  });

  final List<String> imagesLinks;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ...List.generate(imagesLinks.length, (index){
          return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.network(imagesLinks[index],
                    height: height*0.3,fit: BoxFit.cover,width: imagesLinks.length>1?width*0.42:width*0.85,
                    color:index>0 && imagesLinks.length-2!=0?basicColor.withOpacity(0.35):null,
                    colorBlendMode:index>0 && imagesLinks.length-2!=0? BlendMode.srcOver:null,
                    filterQuality: FilterQuality.high,),
                  index>0 && imagesLinks.length-2!=0?Text('${imagesLinks.length-2}',style: CustomTextStyle.commonSignThinAlwaysWhite,):const SizedBox(),
                ],
              ));
        })
      ],
    );
  }
}