import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/get_availbitly_room_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/available_rooms/contact_info_with_social_info.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/available_rooms/rooms_images_with_small_details.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/available_rooms/services_facilites_in_hotel.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/available_rooms/table_available_rooms.dart';
class RoomAvailabilityView extends StatelessWidget {
  const RoomAvailabilityView({super.key,required this.model});
final HotelModelWithRoomModel model;
  @override
  Widget build(BuildContext context) {
    final double width=BasicDimension.screenWidth(context);
    final double height=BasicDimension.screenHeight(context);
    return Scaffold(
      body: ListView(
        children: [
          ImagesOfRoomWithSmallDetails(height: height, width: width,imagesPath: model.hotelsModel.imagesList,name: model.hotelsModel.name!,addressWithCity: '${model.hotelsModel.cityName},${model.hotelsModel.address}',),
          SizedBox(height: height*0.01,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('About Us',style: CustomTextStyle.privateTourTitle,),
                SizedBox(height: height*0.01,),
                SizedBox(
                    height: height*0.1,
                    child: SingleChildScrollView(
                        padding: EdgeInsets.zero,
                        child: Text(model.hotelsModel.describe??"",style: CustomTextStyle.commonFontThinLight))),
                SizedBox(height: height*0.01,),
                const Text('Services & Facilities',style: CustomTextStyle.privateTourTitle,),
                SizedBox(height: height*0.01,),
                SizedBox(
                  height: height*0.15,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                      itemCount: 10,
                      gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 8,crossAxisSpacing: width*0.2,mainAxisSpacing: height*0.015), itemBuilder: (context,index){
                    return const ServicesFacilitiesItem();
                  }),
                ),
                SizedBox(height: height*0.01,),
                const Text('Available Rooms',style: CustomTextStyle.privateTourTitle,),
                SizedBox(height: height*0.01,),
                TableDetailsOfAvailableRooms(width: width,model: model.availableRoomsModel,),
                SizedBox(height: height*0.02,),
                Center(child: CustomLoginButton(label: 'Book',altWidth: width*0.33,)),
              ],
            ),
          ),
          SizedBox(height: height*0.025,),
          ContactInfoWithSocialInfo(height: height, width: width),
          SizedBox(height: height*0.01,),
        ],
      ),
    );
  }
}


