import 'package:flutter/material.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:prepare_project/features/tour_guide/private_tour/data/model/private_tour_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/views/widgets/one_tour_guide_trip_for_tourist_item.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/views/widgets/tour_guide_trip_for_tourist_details_view.dart';
class TourGuideTripForTouristList extends StatelessWidget {
  const TourGuideTripForTouristList({
    super.key,
    required this.height,
    required this.width,
    required this.tripList,
  });

  final double height;
  final double width;
  final List<Trip>tripList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: height*0.05,right: 20,left: 20,bottom: 20),
      child: Column(
        children: [
          CustomGeneratedAiTripAppBar(height: height, width: width,appBarTitle: 'Book With Egyptian Tour Guides',appBarWidth: width*0.7,),
          Expanded(
            child:tripList.isEmpty?
            const Center(child: Text('There Is No Current Trips '),) :
            ListView.builder(
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
                    child: OneTourGuideTripForTourist(height: height, width: width, model: tripList[index]),
                  );
                }
            ),
          ),
        ],
      ),
    );
  }
}