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
    required this.pickCategory,
    this.heightPercent,
    this.title,

  });

  final double height;
  final double? heightPercent;
  final double width;
  final List<TypeOfTourism> typeOfCategory;
  final void Function(int index)pickCategory;
  final String?title;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title??'Pick Category or More',style: CustomTextStyle.fontBold16,),
        SizedBox(
          height:heightPercent?? height*0.17,
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
                    child: PickedCategoryItem(height: height, width: width, picked: typeOfCategory[index].picked,typeImage: typeOfCategory[index].typeImage,),
                  ),
                  heightPercent!=null?SizedBox(
                      width: width*0.25,
                      height: height*0.08,
                      child: Text(typeOfCategory[index].typeName,textAlign: TextAlign.center,style: CustomTextStyle.fontNormal14WithEllipsis,maxLines: 3,)):
                  Text(typeOfCategory[index].typeName,style: CustomTextStyle.fontBold16,overflow: TextOverflow.ellipsis,),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class PickedCategoryItem extends StatelessWidget {
  const PickedCategoryItem({
    super.key,
    required this.height,
    required this.width,
    required this.typeImage,
    required this.picked,
    this.padding
  });

  final double height;
  final double width;
  final String typeImage;
  final bool picked;
  final EdgeInsets?padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding?? const EdgeInsets.only(right: 15.0),
      child: Container(
        height:height*0.12,
        width:width*0.22,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [buildBoxShadow()],
            border: Border.all(color:picked?whatsAppColor:secondaryColor,width: 5)
        ),
        child: Center(child: Image.asset(typeImage,fit: BoxFit.fitHeight,height: height*0.07,width: width*0.14,)),
      ),
    );
  }
}