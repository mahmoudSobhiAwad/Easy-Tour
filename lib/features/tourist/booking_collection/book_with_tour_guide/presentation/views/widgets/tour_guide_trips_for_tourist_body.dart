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
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: height*0.05,right: 20,left: 20,bottom: 20),
      child: Column(
        children: [
          CustomGeneratedAiTripAppBar(height: height, width: width,appBarTitle: 'Book With Egyptian Tour Guides',appBarWidth: width*0.7,),
          Expanded(
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context,index)
                {
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return const ShowTourGuideTripsDetailsForTouristView();
                      }));
                    },
                    child: OneTourGuideTripForTourist(height: height, width: width, model: Trip(
                        title: 'Discovering Spiritual Egypt in 11 days',
                        brief: 'Pyramids Meditation, Luxor Banks, 3-night Dahabiya Nile Cruise',
                        bgImagePath: 'https://th.bing.com/th/id/OIP.7nc4uNs8hqHYnZldJH8gNAHaEK?rs=1&pid=ImgDetMain')),
                  );
                }
            ),
          ),
        ],
      ),
    );
  }
}