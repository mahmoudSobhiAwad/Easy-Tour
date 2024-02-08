import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/tourist_home/data/model/home_data.dart';
import 'package:prepare_project/features/tourist/tourist_home/presentaion/view/widgets/card_element.dart';

import '../../../../../../core/utilities/go_router/go_router.dart';

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
        const Text('Discover Places',style: CustomTextStyle.homePartTitle,),
        SizedBox(
            height: height*0.18,
            width: width,
            child: ListView.separated(
              padding: EdgeInsets.zero,
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              itemCount: placesItem.length,
              physics: isMenuActive?const NeverScrollableScrollPhysics():const BouncingScrollPhysics(),
              separatorBuilder: (context,index){
                return const SizedBox(width: 40,);
                },
              itemBuilder: (BuildContext context, int index)
              {
                return GestureDetector(
                    onTap:  [
                        (){
                      context.push(RouterApp.kHistoricalPlace);
                    },
                        (){
                      context.push(RouterApp.kEntertainmentPlaces);
                    },
                  ][index],
                    child: CardElement(height: height, width: width*1.7,cardModel: placesItem[index],));},)
        ),
      ],
    );
  }
}