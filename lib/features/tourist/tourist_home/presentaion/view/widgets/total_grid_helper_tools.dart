import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_project/core/utilities/go_router/go_router.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:prepare_project/features/tourist/tourist_home/data/model/home_data.dart';
import 'package:prepare_project/features/tourist/tourist_home/presentaion/view/widgets/card_element.dart';

class TotalHelperToolsGrid extends StatelessWidget {
  const TotalHelperToolsGrid({super.key,required this.height,required this.width});
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomGeneratedAiTripAppBar(height: height, width: width,appBarTitle: 'Helper Tools',),
            Expanded(
              child: GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: width*0.04,vertical: height*0.025,),
                  itemCount: getHelperItems.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 0.9,crossAxisCount: 2,crossAxisSpacing:width*0.1,mainAxisSpacing: height*0.02),
                  itemBuilder: (context,index){
                    return GestureDetector(
                        onTap:  [
                              (){context.push(RouterApp.kTouristHotelBooking);},
                              (){context.push(RouterApp.kTouristFlightTicketBooking);},
                              (){context.push(RouterApp.kChatBotView);},
                              (){context.push(RouterApp.kImageClassification);},
                              (){
                            ///Car rental if it exist
                          },
                              (){context.push(RouterApp.kWeatherView);},
                              (){context.push(RouterApp.kCurrencyConverter);},
                        ][index],
                        child: CardElement(height: height,width: width,cardModel: getHelperItems[index],));
                  }),
            )
          ],
        ),
      ),
    );
  }
}