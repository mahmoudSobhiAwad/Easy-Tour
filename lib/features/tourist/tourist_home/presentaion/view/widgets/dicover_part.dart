import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/tourist_home/data/model/home_data.dart';


class DiscoverPart extends StatelessWidget {
  const DiscoverPart({
    super.key,
    required this.height,
    required this.width,
    required this.isMenuActive,
  });

  final double height;
  final double width;
  final bool isMenuActive;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
       const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Best Destinations',style: CustomTextStyle.homePartTitle,),
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Text('See All',style: CustomTextStyle.commonFontThin,),
            ),
          ],
        ),
        SizedBox(
            height: height*0.3,
            width: width,
            child: ListView.separated(
              padding: EdgeInsets.zero,
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              itemCount: placesItem.length,
              physics: isMenuActive?const NeverScrollableScrollPhysics():const BouncingScrollPhysics(),
              separatorBuilder: (context,index){
                return const SizedBox(width: 20,);
                },
              itemBuilder: (BuildContext context, int index)
              {
                return BestDestinationItem(index: index, height: height, width: width);
                },
            )
        ),
      ],
    );
  }
}
class BestDestinationItem extends StatelessWidget {
  const BestDestinationItem({super.key,required this.index,required this.height,required this.width});
final int index;
final double height;
final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: thirdColor,width: 3),
       // color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
              child: Image.asset(placesItem[index].imagePath,height: height*0.2,width: width*0.4,fit: BoxFit.fill,)),
          const Row(
            children: [
              Text('Niladri Reservoir',style: CustomTextStyle.commonFontThin,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.star,color: goldenColor,),
                  Text('4.7',style: CustomTextStyle.commonFontThin,),
                ],
              ),
            ],
          ),
          const Row(
            children: [
              Icon(Icons.location_on,color: entertainmentColor,),
              Text('Tekergat, Sunamgnj',style: CustomTextStyle.commonFontThinLight,),
            ],
          ),
        ],
      ),
    );
  }
}
