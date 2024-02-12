import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/tourist/toursit_search/presentation/view/search_view.dart';
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
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:(context)=>const SearchView()));
              },
              child: SizedBox(
                child: Container(
                  width:width*0.65,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: commonBorderRadius(),
                    color: thirdColor,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Search...',style:CustomTextStyle.commonFontThinLight),
                      Icon( Icons.search_rounded),
                    ],
                  ),
                ),),
            ),
            rightIcon,
          ],
        )
    );
  }
}
