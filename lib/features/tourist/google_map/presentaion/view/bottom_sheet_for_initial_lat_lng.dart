import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/tourist/google_map/presentaion/manager/map_cubit/google_map_cubit.dart';
class BottomSheetForInitial extends StatelessWidget {
  const BottomSheetForInitial({
    super.key,
    required this.height,
    required this.width,
    required this.cubit,
  });

  final double height;
  final double width;
  final GoogleMapCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height*0.2,
      width: width,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft:Radius.circular(12) ,topRight: Radius.circular(12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(onPressed: (){
              cubit.closeBottomSheet();
            }, icon: const Icon(Icons.close)),
          ),
          Text("${cubit.initialLatLngInfo}"),
          SizedBox(
              width: width*0.6,
              child: Row(
                children: [
                  const Icon(Icons.directions_run),
                  Text("${cubit.initialDistance!/1000.toInt()} KM",style: CustomTextStyle.commonFontThin,),
                ],
              )),
          GestureDetector(
            onTap: (){
              cubit.showPolyLineForInitial();
            },
            child: Container(
              width: width*0.33,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: forthColor,borderRadius: commonBorderRadius()),
              child: Row(
                children: [
                  Text('Direction',style: CustomTextStyle.commonSignThinDark.copyWith(color: Colors.white),),
                  const Icon(Icons.directions,color: Colors.white,)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
