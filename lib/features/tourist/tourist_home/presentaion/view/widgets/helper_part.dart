import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_project/core/utilities/go_router/go_router.dart';
import 'package:prepare_project/features/tourist/tourist_home/data/model/home_data.dart';
import 'package:prepare_project/features/tourist/tourist_home/presentaion/view/widgets/card_element.dart';

import '../../../../../../core/utilities/textStyle/font_styles.dart';
class HelperPart extends StatelessWidget {
  const HelperPart({
    super.key,
    required this.height,
    required this.width,
    required this.isMenuActive
  });

  final double height;
  final double width;
  final bool isMenuActive;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //  height: height*0.25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Helpers Tool',style:CustomTextStyle.homePartTitle,),
          SizedBox(
              height: height*0.22,
              child: ListView.separated(
                clipBehavior: Clip.none,
                physics:const BouncingScrollPhysics(),
                separatorBuilder: (context,index)=>const SizedBox(width: 20,),
                itemBuilder:(context,index)
                {
                  return GestureDetector(
                      onTap:  [
                            (){
                          context.push(RouterApp.kCustomTripView);
                        },
                            (){
                          context.push(RouterApp.kWeatherView);
                        },
                            (){
                            context.push(RouterApp.kCurrencyConverter);
                        },
                      ][index],
                      child: CardElement(height: height,width: width,cardModel: helperTool[index],));
                },
                scrollDirection: Axis.horizontal,
                itemCount: aiTool.length,
              )
          ),
        ],
      ),
    );
  }
}