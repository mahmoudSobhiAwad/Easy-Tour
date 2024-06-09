import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/view/create_order/create_flight_order_view.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/view/flight_details/traveler_pricing_item.dart';

class TravelerPricingList extends StatelessWidget {
  const TravelerPricingList({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: height*0.025),
        children: [
          Text('Traveler Pricing',style: CustomTextStyle.fontBold21.copyWith(fontSize: 18),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(3, (index) => Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: CircleAvatar(
                  radius: 7.5,
                  backgroundColor: index==0?basicColor:thirdColor,
                ),
              )),
            ],
          ),
          const SizedBox(height: 10,),
          SizedBox(
            height: height*0.65,
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context,index){
                return TravelersPricingItem(width: width, height: height);
              },scrollDirection: Axis.horizontal,),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                Text('Check Required Data',style: CustomTextStyle.fontBold21,),
                IconButton(onPressed: null, icon: Icon(Icons.library_books_rounded)),
              ],
            ),
          ),
          CustomLoginButton(label: 'Continue',altWidth: width*0.5,color:ticketBasicColor,borderRadius: 10,onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return const CreateFlightOrderView();
            }));
          },),
        ],
      ),
    );
  }
}
