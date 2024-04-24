import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_project/core/utilities/go_router/go_router.dart';
import 'package:prepare_project/features/tourist/tourist_home/data/model/home_data.dart';
import 'package:prepare_project/features/tourist/tourist_home/presentaion/view/widgets/card_element.dart';

import '../../../../../../core/utilities/textStyle/font_styles.dart';

class AiPart extends StatelessWidget {
  const AiPart({
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
      height: height*0.24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('AI Tool',style:CustomTextStyle.homePartTitle,),
          SizedBox(
              height: height*0.18,
              child: ListView.separated(
                clipBehavior: Clip.none,
                physics:const BouncingScrollPhysics(),
                separatorBuilder: (context,index)=>const SizedBox(width: 20,),
                itemBuilder:(context,index)
                {
                  return GestureDetector(
                    onTap:  [
                          (){
                      context.push(RouterApp.kChatBotView);
                      },
                          (){
                      context.push(RouterApp.kImageClassification);
                      },
                          (){
                            context.push(RouterApp.kGenerateTripView);
                      },
                    ][index],
                      child: CardElement(height: height,width: width,cardModel: aiTool[index],));
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
