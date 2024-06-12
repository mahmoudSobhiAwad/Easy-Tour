import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_project/core/utilities/go_router/go_router.dart';
import 'package:prepare_project/features/tourist/tourist_home/data/model/home_data.dart';
import 'package:prepare_project/features/tourist/tourist_home/presentaion/view/widgets/total_grid_helper_tools.dart';
import 'package:prepare_project/features/tourist/tourist_home/presentaion/view/widgets/card_element.dart';

import '../../../../../../core/utilities/textStyle/font_styles.dart';
class HelperToolsPart extends StatelessWidget {
  const HelperToolsPart({super.key,required this.height,required this.width});
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height*0.5,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Helper Tools',style: CustomTextStyle.homePartTitle,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TotalHelperToolsGrid(height: height, width: width)));
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Text('See All',style: CustomTextStyle.fontBold14,),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: GridView.builder(
                physics:const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: 4,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing:width*0.1,mainAxisSpacing: height*0.02),
                itemBuilder: (context,index){
                  return GestureDetector(
                      onTap:  [
                            (){
                          context.push(RouterApp.kTouristHotelBooking);
                        },
                            (){
                          context.push(RouterApp.kTouristFlightTicketBooking);
                        },
                            (){
                          context.push(RouterApp.kChatBotView);
                        },
                            (){
                          context.push(RouterApp.kImageClassification);
                        },
                      ][index],
                      child: CardElement(height: height,width: width,cardModel: getHelperItems[index],));
                }),
          )
        ],
      ),
    );
  }
}