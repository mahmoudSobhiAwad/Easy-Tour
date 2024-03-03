import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tour_guide/private_tour/data/data_ui.dart';
import 'package:prepare_project/features/tourist/nearby_places/presentation/views/widgets/pick_category_widget.dart';
class TypeOfStay extends StatelessWidget {
  const TypeOfStay({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height*0.22,
      child: ListView.builder(
          itemCount: 3,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  PickedCategoryItem(height: height, width: width, typeImage: standardPlan, picked: true),
                  const Text('Standard',style: CustomTextStyle.commonFontThin,),
                  const Column(
                    children: [
                      Text('20 \$',style: CustomTextStyle.commonSignDark,),
                      Text('per person',style: CustomTextStyle.commonFontThinLight,),
                    ],)
                ],
              ),
            );
          }),
    );
  }
}