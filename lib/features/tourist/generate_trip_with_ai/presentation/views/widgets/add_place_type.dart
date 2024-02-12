
import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/sign_up_edit/custom_drop_down.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/data_ui.dart';

class AddPlaceType extends StatelessWidget {
  const AddPlaceType({
    super.key,
    required this.width,
  required this.onSelect,
  });

  final double width;
  final void Function(String?value)onSelect;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Pick Places To Go',style: CustomTextStyle.commonSignDark,),
        CustomDropDownMenu(
          width: width*0.7,
          fillColor: Colors.white,
          list: placesForGeneratedTrip,
          initialValue: placesForGeneratedTrip[0],
          enableSearch: true,
          color: Colors.white,
          onSelected:(String?value){
            onSelect(value);
          },),
      ],
    );
  }
}