import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/manager/get_ticket/cubit.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/view/departure_return_date.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/view/intro_flight_request.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/view/origin_departure_place.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/view/traveler_num_trip_type.dart';
class FlightRequestView extends StatelessWidget {
  const FlightRequestView({super.key,required this.width,required this.height,required this.cubit});
  final double width;
  final double height;
  final GetTicketCubit cubit;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          IntroInFlightBooking(height: height,name: cubit.name,profileUrl: cubit.profileUrl,),
          Positioned(
            top: height*0.22,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(10),
                height: height*0.75,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
                ),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OriginAndDeparturePlace(width: width,cubit: cubit,height: height,),
                    SizedBox(height: height*0.02,),
                    DepartureAndReturnDate(width: width, height: height,cubit: cubit,),
                    SizedBox(height: height*0.02,),
                    TravelersDateAndTripType(width: width, height: height,cubit: cubit,),
                    Expanded(child: SizedBox(height: height*0.033,)),
                    Center(
                      child: CustomLoginButton(
                        onTap: (){
                          cubit.getListOfTickets();
                        },
                        color: ticketBasicColor,
                        altWidth: width*0.7,
                        borderRadius: 12,
                        isLoading: cubit.isLoading,
                        label: 'Search For Flights',
                      ),
                    ),
                    SizedBox(height: height*0.02,),
                  ],
                ),
              ),
            ),
          ),
          cubit.showOccupancy?
          Align(
              alignment: Alignment.bottomCenter,
              child: FlightTravelersChangeNumbers(cubit: cubit, height: height, width: width)) :
          const SizedBox(),
        ],
      ),
    );
  }
}
class FlightTravelersChangeNumbers extends StatelessWidget {
  const FlightTravelersChangeNumbers({super.key,required this.cubit,required this.height,required this.width});
  final GetTicketCubit cubit;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height*0.2,
      width: width,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:const BorderRadius.only(topRight: Radius.circular(12),topLeft:Radius.circular(12)),
        border: Border.all(color: thirdColor,width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
              alignment: Alignment.topRight,
              child: IconButton(onPressed: (){
                cubit.enableChangeAdultOrChild();
              }, icon:const Icon(Icons.close))),
          IncreaseOrDecreaseFlightTravelers(text: 'Adult Num', changedIndex: cubit.adultNum, decrease: (){
            cubit.changeAdultOrChildNum(adult: true, increase: false);
          }, increase: (){
            cubit.changeAdultOrChildNum(adult: true, increase: true);
          }),
          IncreaseOrDecreaseFlightTravelers(text: 'Child Num', changedIndex: cubit.childNum, decrease: (){
            cubit.changeAdultOrChildNum(adult: false, increase: false);
          }, increase: (){
            cubit.changeAdultOrChildNum(adult: false, increase: true);
          }),
        ],
      ),
    );
  }
}
class IncreaseOrDecreaseFlightTravelers extends StatelessWidget {
  const IncreaseOrDecreaseFlightTravelers({super.key,required this.text,required this.changedIndex,required this.decrease,required this.increase});
  final String text;
  final int changedIndex;
  final void Function()increase;
  final void Function()decrease;
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text,style: CustomTextStyle.fontBold16,),
        Row(
          children: [
            IconButton(onPressed: increase,icon:const Icon(Icons.add_circle)),
            Text('$changedIndex'),
            IconButton(onPressed: decrease,icon:const FaIcon(FontAwesomeIcons.circleMinus)),
          ],
        )
      ],
    );
  }
}

