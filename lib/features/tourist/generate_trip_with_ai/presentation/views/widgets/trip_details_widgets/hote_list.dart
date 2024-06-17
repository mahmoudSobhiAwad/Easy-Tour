import 'package:flutter/material.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/resturants_hotels_details_view/restaurant_hotel_details_view.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/trip_details_widgets/hotel_item.dart';
import 'package:prepare_project/features/tourist/nearby_places/data/models/nearby_places_model.dart';
class HotelsListWithBar extends StatelessWidget {
  const HotelsListWithBar({super.key,required this.height,required this.width,required this.hotels,});
  final double height;
  final double width;
 final List<NearbyPlacesModel>hotels;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height*0.3,
      child: ListView.separated(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context,index)
          {
            return GestureDetector(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return RestaurantOrHotelDetailsView(model: hotels[index],);
                  }));
                },
                child: HotelItemInGeneratedTrip(height: height, width: width,model: hotels[index],));
          },
          separatorBuilder: (context,index)
          {
            return const SizedBox(width: 15,);
          },
          itemCount: hotels.length
      ),
    );
  }
}