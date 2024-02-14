import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/nearby_places/presentation/views/widgets/small_search_item.dart';

class OneCategorySearchItem extends StatelessWidget {
  const OneCategorySearchItem({
    super.key,
    required this.height,
    required this.width,
    required this.type
  });

  final double height;
  final double width;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: SizedBox(
        height: height*0.25,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(type,style: CustomTextStyle.placesTitle,),
            SizedBox(
                height: height*0.19,
                child: ListView.separated(
                    clipBehavior: Clip.none,
                    physics:const BouncingScrollPhysics(),
                    separatorBuilder: (context,index)=>const SizedBox(width: 20,),
                    itemBuilder:(context,index){
                      return OneSearchSmallItem(height: height, width: width);
                    }
                    ,scrollDirection: Axis.horizontal,
                    itemCount: 7)),
          ],
        ),
      ),
    );
  }
}