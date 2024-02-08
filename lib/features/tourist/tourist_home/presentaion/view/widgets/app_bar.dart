import 'package:flutter/material.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import '../../../../../../core/utilities/basics.dart';

class HomeTouristTourGuideAppBar extends StatelessWidget {
  const HomeTouristTourGuideAppBar({
    super.key,
    required this.height,
    required this.width,
    this.openSidePar,
    required this.rightIcon,
    this.searchFun,
  });

  final double height;
  final double width;
  final void Function()?openSidePar;
  final Widget rightIcon;
  final void Function()? searchFun;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: height*0.06,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(onPressed: openSidePar, icon: const Icon(Icons.table_rows_rounded,color: basicColor,),padding: EdgeInsets.zero,),
            SizedBox(
              child: Container(
                width:width*0.65,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: commonBorderRadius(),
                  color: thirdColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Search...',style: TextStyle(color: secondaryColor),),
                    IconButton(icon:const Icon( Icons.search_rounded),onPressed: searchFun,padding: EdgeInsets.zero,),
                  ],
                ),
              ),),
            rightIcon,
          ],
        )
    );
  }
}