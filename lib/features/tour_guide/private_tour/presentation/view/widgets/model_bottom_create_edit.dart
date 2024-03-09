import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/tour_guide/private_tour/data/model/private_tour_model.dart';
import 'package:prepare_project/features/tour_guide/private_tour/presentation/view/widgets/list_of_places_in_one_day.dart';
class AddOrEditTripModelBottom extends StatelessWidget {
  const AddOrEditTripModelBottom({
    super.key,
    required this.height,
    required this.width,
    this.labelButton='Add',
    required this.dayNum,
    this.enable=true,
    required this.onTap,
    required this.addAnotherPlaceInDay,
    required this.placesOfDay,
    required this.onClose,
    required this.clearDay,
    this.changeType,
  });

  final double height;
  final double width;
  final String labelButton;
  final int dayNum;
  final bool? enable;
  final void Function() onTap;
  final void Function() onClose;
  final void Function()? changeType;
  final void Function() addAnotherPlaceInDay;
  final void Function(int indedx) clearDay;
  final List<TripPlace>placesOfDay;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: height*0.51,
        decoration: BoxDecoration(
          border: Border.all(color: secondaryColor),
          color: thirdColor,
          borderRadius:commonBorderRadius(),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Align(child: Text('Day$dayNum')),
                IconButton(onPressed: onClose, padding: EdgeInsets.zero,icon: const Icon(Icons.close,color: basicColor,)),
              ],
            ),
            Column(
              children: [
                PlacesListOfOneDay(height: height, width: width,enable: enable,placesOfDay:placesOfDay,clearDay:clearDay,changeType: changeType,),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: width*0.5,
                    decoration: BoxDecoration(borderRadius:BorderRadius.circular(10),border: Border.all(color:secondaryColor)),
                    child: TextButton(
                        onPressed: addAnotherPlaceInDay,
                        child: const Text("Add Another Place",
                          style: CustomTextStyle.commonProfileDark,)),
                  ),
                ),
              ],
            ),
            const SizedBox(height:20),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Align(alignment: Alignment.center,child: CustomLoginButton(label: labelButton,onTap: onTap,)),
            ),
          ],
        ),
      ),
    );
  }
}