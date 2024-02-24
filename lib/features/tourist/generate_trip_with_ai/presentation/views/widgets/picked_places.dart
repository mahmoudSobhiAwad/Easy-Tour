import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
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
      child: SingleChildScrollView(
        child:places!.isEmpty?
        const Text('Try To Add Places ',textAlign: TextAlign.center,) :
        Wrap(
            alignment: WrapAlignment.start,
            spacing: 7,
            children:[
              ...List.generate(places?.length??0, (index) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  height: height*0.07,
                  width: width*0.3,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(color: const Color(0xff5F92D9),boxShadow: [buildBoxShadow()],borderRadius: commonBorderRadius()),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: width*0.15,child: Text(places?[index]??'',style: CustomTextStyle.commonFontThinLight.copyWith(color: Colors.white,),maxLines: 2,)),
                      IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: (){
                        removeAt(index);
                      }, icon:const Icon(Icons.close,color: Colors.white,))
                    ],
                  ),
                ),
              ))]
        ),
      ),
    );
  }
}