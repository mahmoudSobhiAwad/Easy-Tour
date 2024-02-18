import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/tour_guide/private_tour/presentation/view/widgets/inc_exc_add_model_sheet.dart';

class IncludedOrExcludedFeatures extends StatelessWidget {
  const IncludedOrExcludedFeatures({
    super.key,
    required this.height,
    required this.width,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.incOrExc,
    required this.addIncOrExc,
    required this.removeIncOrExc,
    required this.controller,
  });

  final double height;
  final double width;
  final String title;
  final IconData icon;
  final Color iconColor;
  final List<String>incOrExc;
  final void Function()addIncOrExc;
  final void Function(int index)removeIncOrExc;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        SizedBox(
          height: height*0.23,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,style: CustomTextStyle.commonSignDark,),
              const SizedBox(height: 5,),
              Container(
                height: height*0.18,
                decoration: BoxDecoration(
                  color: thirdColor,
                  borderRadius: commonBorderRadius(),
                  boxShadow: [
                    buildBoxShadow(),
                  ],
                ),
                child:incOrExc.isEmpty?
                const Center(child: Text('Try To Add Feature')):
                ListView.builder(
                    padding:const EdgeInsets.all(10),
                    itemCount: incOrExc.length,
                    itemBuilder: (context,index){
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(icon,color: iconColor,),
                          const SizedBox(width: 10,),
                          SizedBox(width: width*0.65,child:Text(incOrExc[index],style: CustomTextStyle.commonSignThinDark,)),
                          IconButton(padding: EdgeInsets.zero,onPressed:(){
                            removeIncOrExc(index);
                          },icon:const Icon(Icons.minimize_rounded,color: closeColor),),
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
        AddIncOrExcModelBottomSheet(height: height, title: title, icon: icon, iconColor: iconColor, controller: controller, width: width, addIncOrExc: addIncOrExc)
      ],
    );
  }
}