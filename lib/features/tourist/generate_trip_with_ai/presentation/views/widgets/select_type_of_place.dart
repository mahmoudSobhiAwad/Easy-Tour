import 'package:flutter/material.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/model/type_of_places_toursim.dart';
import 'package:prepare_project/features/tourist/nearby_places/presentation/views/widgets/pick_category_widget.dart';

class SelectTypesOfPlaces extends StatelessWidget {
  const SelectTypesOfPlaces({
    super.key,
    required this.height,
    required this.width,
    required this.typeOfTourismList,
    required this.changeToggle
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
        PickCategoryForSearch(height: height,title: 'Select Type or More', width: width, heightPercent: height*0.2,typeOfCategory: typeOfTourismList, pickCategory: changeToggle),
      ],
    );
  }
}

