import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/model/type_of_places_toursim.dart';

class SelectTypesOfPlaces extends StatelessWidget {
  const SelectTypesOfPlaces({
    super.key,
    required this.height,
    required this.width,
    required this.typeOfTourismList,required this.changeToggle
  });

  final double height;
  final double width;
  final List<TypeOfTourism> typeOfTourismList;
  final void Function(int index)changeToggle;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Select Type or More',style: CustomTextStyle.commonSignDark,),
        SizedBox(
          height: height*0.18,
          child: ListView.separated(
            separatorBuilder: (context,index){
              return const SizedBox(width: 20,);
            },
            itemCount:typeOfTourismList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: (){
                    changeToggle(index);
                  },
                  child: TripPlaceTypeItem(width: width, height: height,typeOfTourism: typeOfTourismList[index],));
            },

          ),
        ),

      ],
    );
  }
}

class TripPlaceTypeItem extends StatelessWidget {
  const TripPlaceTypeItem({
    super.key,
    required this.width,
    required this.height,
    required this.typeOfTourism
  });

  final double width;
  final double height;
  final TypeOfTourism typeOfTourism;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: width*0.25,
          height: height*0.14,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: commonBorderRadius(),
              boxShadow: [
                buildBoxShadow(
                ),
              ],
              border: Border.all(color: secondaryColor,width: 2)
          ),
          child: Column(
            children: [
              Image.asset(typeOfTourism.typeImage,fit: BoxFit.fitHeight,height: height*0.09,),
              Align(
                  alignment: Alignment.bottomRight,
                  child:typeOfTourism.picked? const Icon(Icons.check_circle_outline,color: whatsAppColor):const Icon(Icons.circle_outlined,color: secondaryColor,))
            ],
          ),
        ),
        const SizedBox(height: 7,),
        Text(typeOfTourism.typeName,style: CustomTextStyle.commonSignDark,),
      ],
    );
  }
}