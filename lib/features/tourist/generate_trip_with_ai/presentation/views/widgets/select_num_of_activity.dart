import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
class SelectNumOfActivityInDay extends StatelessWidget {
  const SelectNumOfActivityInDay({super.key,required this.width,required this.height,required this.activityNames,required this.changeActivity,required this.currActivity});
  final double width;
  final double height;
  final void Function(int index)changeActivity;
  final int ?currActivity;
  final Map<int,String>activityNames;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width*0.025),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Activity In One Day ',style: CustomTextStyle.commonSignDark,),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(3, (index) {
                return GestureDetector(
                  onTap: (){
                    changeActivity(index);
                  },
                  child: Container(
                    width: width*0.3,
                    height: height*0.08,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color:index==currActivity? basicColor:Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: secondaryColor,width: 2),
                    ),
                    child:Center(child:  Text(activityNames.values.elementAt(index),style: CustomTextStyle.commonFontThin.copyWith(color: currActivity==index?Colors.white:basicColor),maxLines: 2,textAlign: TextAlign.center,)),
                  ),
                );
              })
            ],),


        ],
      ),
    );
  }
}