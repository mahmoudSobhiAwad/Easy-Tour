import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/trip_history/presentation/view/widgets/custom_card_empty_trip_history.dart';
class EmptyHistory extends StatelessWidget {
  const EmptyHistory({super.key,required this.width,required this.height});
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            width: width*0.75,
            child: const Text('Let\'s Make Your First Trip To Egypt',style: CustomTextStyle.privateTourTitle,maxLines: 2,textAlign: TextAlign.center,)),
        const SizedBox(height: 15,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width*0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  CustomCardInEmptyTripHistory(width: width, height: height, text: 'Book With Tour Guide', imagePath: 'assets/login/tour_guide.png', color:const Color(0xff1F96B0)),
                  SizedBox(height: height*0.04,),
                  CustomCardInEmptyTripHistory(width: width, height: height, text: 'Custom Trip', imagePath: 'assets/tourist_home/custom_trip.png', color: goldenColor),
                ],
              ),
              SizedBox(width: width*0.1,),
              CustomCardInEmptyTripHistory(width: width, height: height, text: 'Generate Trip With AI', imagePath: 'assets/tourist_home/Vector_Robot_3.webp', color: forthColor),
            ],
          ),
        )
      ],
    );
  }
}