import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/manager/rest_hotel_cubit/rest_hotel_cubit.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/resturants_hotels_details_view/custom_image_slider.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/resturants_hotels_details_view/rest_or_hotel_info.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/views/widgets/resturants_hotels_details_view/review_list.dart';
import 'package:prepare_project/features/tourist/nearby_places/data/models/nearby_places_model.dart';
class RestaurantOrHotelDetailsBody extends StatelessWidget {
  const RestaurantOrHotelDetailsBody({
    super.key,
    required this.width,
    required this.height,
    required this.model,
    required this.cubit,
  });

  final double width;
  final NearbyPlacesModel model;
  final double height;
  final RestHotelDetailsCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              cubit.isLoadingPhotos?
              CustomImageSlider(width: width, height: height,photoUrls: cubit.photoUrlList,):const Center(child: CircularProgressIndicator(color: basicColor,)),
              DefaultTabController(length: 2,
                  child: TabBar(
                      onTap: (value){
                      },
                      indicatorColor: entertainmentColor,
                      tabs:const[
                        Tab(child: Text('Details',style:CustomTextStyle.commonFontThin,),),
                        Tab(child: Text('Reviews',style:CustomTextStyle.commonFontThin,),),
                      ]
                  )
              ),
              0==0?
              RestOrHotelInfo(width: width, height: height,model: model,):
              Expanded(
                  child: ReviewListForHotelsOrRestaurants(height: height, width: width)),

              Center(child: CustomLoginButton(altWidth: width*0.9,color: forthColor,label: 'Go Now',)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0,left: 10,right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomContainerWithStroke(height: height, width: width, containWidget: IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon:const Icon(Icons.arrow_back_sharp))),
              CustomContainerWithStroke(height: height, width: width, containWidget: IconButton(onPressed: (){
              }, icon:const Icon(Icons.bookmark_border,))),
            ],),
        ),
      ],
    );
  }
}