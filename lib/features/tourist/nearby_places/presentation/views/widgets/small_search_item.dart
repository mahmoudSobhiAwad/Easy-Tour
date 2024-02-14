import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';

class OneSearchSmallItem extends StatelessWidget {
  const OneSearchSmallItem({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: thirdColor,
          borderRadius: commonBorderRadius(),
          boxShadow: [
            buildBoxShadow(),
          ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/entertainment_places/food.png',height: height*0.04,),
          const Text('Fares restaurants',style: CustomTextStyle.commonFontThin,overflow: TextOverflow.ellipsis,),
          const Text('Sea Food',style: CustomTextStyle.commonFontThin,overflow: TextOverflow.ellipsis,),
          const Text('about 4.4 KM',style: CustomTextStyle.commonFontThin,overflow: TextOverflow.ellipsis,),
          Container(
            padding: const EdgeInsets.all(3),
            height: height*0.04,
            width: width*0.2,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: commonBorderRadius(),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                Text('Let\'s Go',style:TextStyle(color: Colors.white,fontSize: 10),),
                Icon(Icons.arrow_forward_rounded,color: Colors.white,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
