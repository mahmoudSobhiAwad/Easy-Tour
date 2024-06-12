import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_project/core/utilities/go_router/go_router.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/tourist_home/data/model/home_data.dart';
import 'package:prepare_project/features/tourist/tourist_home/presentaion/view/widgets/card_element.dart';
class GetTrip extends StatelessWidget {
  const GetTrip({
    super.key,
    required this.height,
    required this.width,
    required this.isMenuActive,
  });

  final double height;
  final bool isMenuActive;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height*0.28,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Get A Trip',style: CustomTextStyle.homePartTitle,),
          Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(top: 10),
                clipBehavior: Clip.none,
                physics: isMenuActive?const NeverScrollableScrollPhysics():const BouncingScrollPhysics(),
                separatorBuilder: (context,index)=>const SizedBox(width: 20,),
                itemBuilder:(context,index){
                  return GestureDetector(
                      onTap:  [
                            (){
                              context.push(RouterApp.kGenerateTripView);
                            },
                            (){
                              context.push(RouterApp.kTourGuideTripsBooking);
                            },
                            (){
                              context.push(RouterApp.kCustomTripView);
                            },
                      ][index],
                      child: CardElement(height: height,width: width,cardModel: getATripItems[index],));
                  }
                ,scrollDirection: Axis.horizontal,itemCount: getATripItems.length,)),
        ],
      ),
    );
  }
}