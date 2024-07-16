import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';


class CameraOrGallery extends StatelessWidget {
  const CameraOrGallery({super.key,required this.height,required this.width,required this.getImageFromGallery});
  final double height;
  final double width;
  final void Function()getImageFromGallery;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: height*0.06,
              width: width*0.4,
              decoration: BoxDecoration(
                color: thirdColor,
                boxShadow: const [
                  BoxShadow(blurRadius: 4,offset: Offset(0, 4)),
                ],
                borderRadius: commonBorderRadius(),
                border: Border.all(color: basicColor,width: 3),
              ),
              child: Center(child: Text('Pick With Camera',style: CustomTextStyle.fontNormal14WithEllipsis,)),
            ),
            GestureDetector(
              onTap: getImageFromGallery,
              child: Container(
                height: height*0.06,
                width: width*0.4,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(blurRadius: 4,offset: Offset(0, 4)),
                  ],
                  color: thirdColor,
                  borderRadius: commonBorderRadius(),
                ),
                child: Center(child: Text('Open Gallery',style: CustomTextStyle.fontNormal14WithEllipsis,)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}