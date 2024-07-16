import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
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
    this.enableSearch=false,
  });

  final double height;
  final double width;
  final bool enableSearch;
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
            IconButton(onPressed: openSidePar, icon: const Icon(Icons.table_rows_rounded,),),
            SizedBox(width: width*0.5,child:  Align(alignment: Alignment.centerLeft,child: Text('Easy Tour',style: CustomTextStyle.fontGrover30,))),
            enableSearch? GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:(context)=>const SearchView()));
              },
              child: Padding(
                padding: const EdgeInsets.only(top:10.0),
                child: Container(
                  padding: const EdgeInsets.only(bottom: 15,top: 5,left: 10,right: 10),
                  decoration: const BoxDecoration(
                    color: thirdColor,
                    shape: BoxShape.circle,
                  ),
                    child: const Icon( Icons.search_rounded,size: 33,)),
              ),
            ) :
            const Spacer(),
            rightIcon,
          ],
        )
    );
  }
}
