import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
class PlacesWrapWidget extends StatelessWidget {
  const PlacesWrapWidget({
    super.key,
    required this.height,
    required this.width,
    required this.places,
    required this.removeAt
  });

  final double height;
  final double width;
  final List<String>?places;
  final void Function(int index)removeAt;

  @override
  Widget build(BuildContext context) {
    return Container(
      height:places!.isEmpty? height*0.08:height*0.2,
      width: width,
      padding: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(color: thirdColor,borderRadius: commonBorderRadius(),boxShadow: [buildBoxShadow()]),
      child: places!.isEmpty?
      const Text('Try To Add Places ',textAlign: TextAlign.center,) :
          PickedPlaceWithNumberOfDays(height: height, width: width,places: places,),
    );
  }
}
class PickedPlaceWithNumberOfDays extends StatelessWidget {
  const PickedPlaceWithNumberOfDays({super.key,required this.height,required this.width,this.places});
final double height;
final double width;
final List<String>?places;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
        itemCount: places?.length,
        itemBuilder:(context,index){
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: height*0.07,
              width: width*0.4,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(color: const Color(0xff5F92D9),boxShadow: [buildBoxShadow()],borderRadius: commonBorderRadius()),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: width*0.25,child: Text(places?[index]??'',style: CustomTextStyle.commonFontThinLight.copyWith(color: Colors.white,),maxLines: 2,)),
                  IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: (){
                        }, icon:const Icon(Icons.arrow_drop_down),color: Colors.white,)
                ],
              ),
            ),
            SizedBox(
              height: height*0.07,
              width: width*0.4,
              child: CustomTextFormField(
                filled: true,
                fillColor: Colors.white,
                label: 'Num Of Days',
                floatingLabelBehavior: FloatingLabelBehavior.never,
                maxLines: 1,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(1),
                ],
              ),
            ),
            const IconButton(onPressed: null, icon: Icon(Icons.remove,color: closeColor,)),
          ],
        ),
      );
    });
  }
}
