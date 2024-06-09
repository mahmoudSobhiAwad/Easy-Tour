import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/tour_guide/private_tour/data/model/private_tour_model.dart';
import 'package:prepare_project/features/tour_guide/private_tour/presentation/view/widgets/tour_info_without_image.dart';

class PrivateTourItem extends StatelessWidget {
  const PrivateTourItem({
    super.key,
    required this.height,
    required this.width,
    required this.model,

  });

  final double height;
  final double width;
  final Trip? model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Container(
        height: height*0.35,
        width: width,
        decoration: BoxDecoration(color: thirdColor,borderRadius: commonBorderRadius()),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: const BorderRadius.only(topLeft:Radius.circular(20) ,topRight:Radius.circular(20)),
                child: model?.bgImagePath!=''?Image.network(model!.bgImagePath!,fit: BoxFit.cover,height:height*0.12,width: width,):
                Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(color: entertainmentColor.withOpacity(0.2),borderRadius: BorderRadius.circular(10)),
                    child:const  Center(child:  Text('Click On The Trip And Edit It To Have BackGround Image',style: CustomTextStyle.fontBold16,textAlign: TextAlign.center,)))
            ),
            PrivateTourWithoutImage(height: height, width: width,model: model,)
          ],
        ),
      ),
    );
  }
}