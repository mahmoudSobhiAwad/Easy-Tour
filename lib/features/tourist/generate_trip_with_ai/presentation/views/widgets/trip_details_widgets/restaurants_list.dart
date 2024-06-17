import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/resturants_hotels_details_view/restaurant_hotel_details_view.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/trip_details_widgets/restaurant_item.dart';
import 'package:prepare_project/features/tourist/nearby_places/data/models/nearby_places_model.dart';

class RestaurantsListWithBar extends StatelessWidget {
  const RestaurantsListWithBar({super.key,required this.height,required this.width,required this.restaurant,});
  final double height;
  final double width;
  final List<NearbyPlacesModel>restaurant;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        SizedBox(
          height: height*0.3,
          child: restaurant.isEmpty?
          const Center(child: CircularProgressIndicator(color: basicColor,),):
          ListView.separated(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context,index)
              {
                return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context,){
                        return RestaurantOrHotelDetailsView(model: restaurant[index],);
                      }));
                    },
                    child: RestaurantItemInGeneratedTrip(height: height, width: width, model: restaurant[index],));
              },
              separatorBuilder: (context,index)
              {
                return const SizedBox(width: 15,);
              },
              itemCount: restaurant.length,
          ),
        ),
      ],
    );
  }
}
