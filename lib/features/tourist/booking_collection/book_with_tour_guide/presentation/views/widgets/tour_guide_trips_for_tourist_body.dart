import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:prepare_project/features/tour_guide/private_tour/data/model/private_tour_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/managers/tour_guide_trips_to_view_cubit.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/views/widgets/one_tour_guide_trip_for_tourist_item.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/views/widgets/tour_guide_trip_for_tourist_details_view.dart';
import 'package:prepare_project/features/tourist/historical_places/presentation/view/widgets/pagination_widget.dart';
class TourGuideTripForTouristList extends StatelessWidget {
  const TourGuideTripForTouristList({
    super.key,
    required this.height,
    required this.width,
    required this.tripList,
    this.tourName,
    this.viewProfile=true,
    this.cubit,
    required this.isLoading,
  });

  final double height;
  final double width;
  final List<Trip>tripList;
  final String?tourName;
  final bool viewProfile;
  final TripsToViewCubit? cubit;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Padding(
          padding: EdgeInsets.only(top: height*0.05,right: 20,left: 20,bottom: 20),
          child: Column(
            children: [
              CustomGeneratedAiTripAppBar(height: height, width: width,appBarTitle:'Book With ${tourName??'Egyptian Tour Guides'}',appBarWidth: width*0.7,menuToSaveTrip:const Icon(Icons.filter_alt_rounded,color: basicColor,),),
              isLoading?
              const Center(child:  CircularProgressIndicator(color: basicColor,)) :
              Expanded(
                child:tripList.isEmpty?
                const Center(child: Text('There Is No Current Trips '),) :
                ListView.builder(
                  padding: EdgeInsets.only(bottom: height*0.07),
                    physics: const BouncingScrollPhysics(),
                    itemCount: tripList.length,
                    itemBuilder: (context,index)
                    {
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return  ShowTourGuideTripsDetailsForTouristView(tripItem: tripList[index],);
                          }));
                        },
                        child: OneTourGuideTripForTourist(height: height, width: width, model: tripList[index],viewProfile: viewProfile,),
                      );
                    }
                ),
              ),
            ],
          ),
        ),
        cubit!=null?
        PaginationInHistoricalPlaces(
          controller: cubit!.scrollController,
          width: width,
          height: height,
          decreaseIndex: () {
            cubit!.scrollToPrevItem(width: width*0.1);},
          pagIndex: cubit!.currIndex,
          increaseIndex: () {
            cubit!.scrollToNextItem(width: width*0.1);
          },
          changeIndex: (int index) {
            cubit!.changeIndex(index);
          },
          pageNumbers: cubit!.paginationList,
        ):
        const SizedBox(),
      ],
    );
  }
}