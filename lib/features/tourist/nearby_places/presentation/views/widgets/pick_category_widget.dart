import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/model/type_of_places_toursim.dart';

class PickCategoryForSearch extends StatelessWidget {
  const PickCategoryForSearch({
    super.key,
    required this.height,
    required this.width,
    required this.typeOfCategory,
    required this.pickCategory
  });

  final double height;
  final double width;
  final List<TypeOfTourism> typeOfCategory;
  final void Function(int index)pickCategory;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Pick Category or More',style: CustomTextStyle.commonSignDark,),
        SizedBox(
          height: height*0.17,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            separatorBuilder: (context,index){
              return const SizedBox(width: 20,);
            },
            itemCount:typeOfCategory.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  GestureDetector(
                    onTap:(){
                      pickCategory(index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Container(
                        height:height*0.12,
                        width:width*0.22,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [buildBoxShadow()],
                            border: Border.all(color:typeOfCategory[index].picked?whatsAppColor:secondaryColor,width: 5)
                        ),
                        child: Center(child: Image.asset(typeOfCategory[index].typeImage,fit: BoxFit.fitHeight,height: height*0.06,)),
                      ),
                    ),
                  ),
                  // const SizedBox(height: 7,),
                  Text(typeOfCategory[index].typeName,style: CustomTextStyle.commonSignDark,overflow: TextOverflow.ellipsis,),
                ],
              );

            },
          ),
        ),
      ],
    );
  }
}