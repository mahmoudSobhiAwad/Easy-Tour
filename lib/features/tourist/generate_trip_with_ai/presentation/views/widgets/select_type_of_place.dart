import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/model/type_of_places_toursim.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/trip_place_item.dart';

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

