import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tour_guide/private_tour/data/data_ui.dart';
import 'package:prepare_project/features/tourist/nearby_places/presentation/views/widgets/pick_category_widget.dart';
class TypeOfStay extends StatelessWidget {
  const TypeOfStay({
    super.key,
    required this.height,
    required this.width,
    required this.plan,
     this.onTap,
     this.pickedIndex,
  });

  final double height;
  final double width;
  final Map<String,dynamic>?plan;
  final void Function(int index)?onTap;
  final int? pickedIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height*0.22,
      child: ListView.builder(
          itemCount: plan?.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  GestureDetector(
                      onTap:(){
                        onTap != null?onTap!(index):();
                      },
                      child: PickedCategoryItem(height: height, width: width, typeImage: getPlanType(plan?.keys.elementAt(index)??""), picked:pickedIndex==null?true:pickedIndex==index)),
                  Text(plan?.keys.elementAt(index)??"",style: CustomTextStyle.commonFontThin,),
                  Column(
                    children: [
                      Text('${plan?.values.elementAt(index)??""} \$',style: CustomTextStyle.commonSignDark,),
                      const Text('per person',style: CustomTextStyle.commonFontThinLight,),
                    ],)
                ],
              ),
            );
          }),
    );
  }
}
String getPlanType(String plan){
  switch(plan){
    case 'standard':return standardPlan;
    case 'luxury':return comfortPlan;
    case 'VIP':return luxuryPlan ;
    default:return standardPlan;
  }
}