// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/destinations_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/manager/hotel_booking_cubit/hotel_booking_cubit.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/explore_egypt_destination.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/hotel_search_bar.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/show_dest_search_menu.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/trending_destination.dart';

class HotelBookingBody extends StatelessWidget {
  const HotelBookingBody({
    super.key,
    required this.width,
    required this.height,
    required this.cubit,
  });

  final double width;
  final double height;
  final HotelBookingCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset('assets/hotel_booking/booking_background.png',width: width,height: height*0.3,fit: BoxFit.cover,),
            cubit.isLoading?Center(child: CircularProgressIndicator()): Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: height*0.77,
                width: width,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius:  BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: height*0.1),
                  child:ListView(
                    padding: const EdgeInsets.all(14),
                    children: [
                      TrendingDestinationInHotelBooking(width: width, height: height,onTap: (DestinationModel val){
                        cubit.searchForHotelsByDestOnly(val);
                      },),
                      SizedBox(height: height*0.025,),
                      ExploreEgyptDestination(height: height, width: width,onTap: (DestinationModel val){
                        cubit.searchForHotelsByDestOnly(val);
                      }),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                top: height*0.2,
                left: width*0.025,
                child: SearchForHotelsWithNameOfDest(width: width, height: height, controller: cubit.searchText,
                  searchForHotel: (){
                    cubit.searchForHotelsByDestOnly(cubit.destModel!);
                  },
                  onChanged: (String?val){
                    cubit.searchForSpecificDest();
                  },)
            ),
           cubit.searchResults.isNotEmpty&&cubit.searchText.text.trim().isNotEmpty&&cubit.showList?
           ShowResultOfDestSearch(height: height, width: width, onTapMenu: (value){
             cubit.onTapOnMenu(value);
           }, searchResults: cubit.searchResults,) :
           const SizedBox(),
          ],
        ),
      ),
    );
  }
}

