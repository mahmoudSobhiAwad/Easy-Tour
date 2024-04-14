import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/manager/view_trip_details_cubit/view_trip_details_cubit.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/resturants_hotels_details_view/restaurant_hotel_details_view.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/trip_details_widgets/restaurant_item.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/trip_details_widgets/widgets_bar.dart';

class RestaurantsListWithBar extends StatelessWidget {
  const RestaurantsListWithBar({super.key,required this.height,required this.width,required this.cubit,});
  final double height;
  final double width;
  final ViewTripDetailsCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        ChangeShowForWidgetInGeneratedTrip(
            showDetails:cubit.showRestaurants,
            changeShow:(){
              cubit.getNearbyRestaurants();
            }, height: height,barName: 'Restaurants'),
        const SizedBox(height: 10,),
        cubit.showRestaurants?
        SizedBox(
          height: height*0.3,
          child: cubit.restaurant.isEmpty?
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
                        return RestaurantOrHotelDetailsView(model: cubit.restaurant[index],);
                      }));
                    },
                    child: RestaurantItemInGeneratedTrip(height: height, width: width, model: cubit.restaurant[index],));
              },
              separatorBuilder: (context,index)
              {
                return const SizedBox(width: 15,);
              },
              itemCount: cubit.restaurant.length,
          ),
        ):
        const SizedBox(),
      ],
    );
  }
}
