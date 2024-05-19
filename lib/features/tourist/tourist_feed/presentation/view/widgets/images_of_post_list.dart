import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
class ImagesOfPostList extends StatelessWidget {
  const ImagesOfPostList({
    super.key,
    required this.imagesLength,
    required this.height,
    required this.width,
  });

  final int imagesLength;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ...List.generate(imagesLength, (index){
          return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.network('https://th.bing.com/th/id/R.059f35496d46f332a217e64cacd68a59?rik=0v49qvtJwJocwg&riu=http%3a%2f%2fhdqwalls.com%2fwallpapers%2fcristiano-ronaldo-new.jpg&ehk=uwdE3a1Ka0BVb5uu5wlcWUBNJjp9d5k8HT0PgVO5vC4%3d&risl=&pid=ImgRaw&r=0',
                    height: height*0.3,fit: BoxFit.cover,width: imagesLength>1?width*0.42:width*0.85,
                    color:index>0?basicColor.withOpacity(0.35):null,
                    colorBlendMode: BlendMode.srcOver,
                    filterQuality: FilterQuality.high,),
                  index>0?const Text('+2',style: CustomTextStyle.commonSignThinAlwaysWhite,):const SizedBox(),
                ],
              ));
        })
      ],
    );
  }
}