import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/get_availbitly_room_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/manager/room_view_cubit/rooms_view_cubit.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/available_rooms/contact_info_with_social_info.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/available_rooms/rooms_images_with_small_details.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/available_rooms/services_facilites_in_hotel.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/available_rooms/table_available_rooms.dart';
class RoomAvailabilityBody extends StatelessWidget {
  const RoomAvailabilityBody({
    super.key,
    required this.height,
    required this.width,
    required this.model,
    required this.cubit,
  });

  final double height;
  final double width;
  final HotelModelWithRoomModel model;
  final RoomsViewCubit cubit;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ImagesOfRoomWithSmallDetails(height: height, width: width,imagesPath: model.hotelsModel.imagesList,name: model.hotelsModel.name!,addressWithCity: '${model.hotelsModel.cityName},${model.hotelsModel.address}',),
        SizedBox(height: height*0.01,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('About Us',style: CustomTextStyle.fontBold21,),
              SizedBox(height: height*0.01,),
              SizedBox(
                  height: height*0.1,
                  child: SingleChildScrollView(
                      padding: EdgeInsets.zero,
                      child: Text(model.hotelsModel.describe??"",style: CustomTextStyle.font14Light))),
              SizedBox(height: height*0.01,),
              const Text('Services & Facilities',style: CustomTextStyle.fontBold21,),
              SizedBox(height: height*0.01,),
              cubit.facilityStringList.isNotEmpty?
              SizedBox(
                height: height*0.2,
                child: GridView.builder(
                    itemCount: cubit.facilityStringList.length,
                    gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 4,crossAxisSpacing: width*0.2,mainAxisSpacing: height*0.015), itemBuilder: (context,index){
                  return ServicesFacilitiesItem(facilityItem: cubit.facilityStringList[index],width: width,height: height,);
                }),
              ) :
              const SizedBox(),
              SizedBox(height: height*0.01,),
              const Text('Available Rooms',style: CustomTextStyle.fontBold21,),
              SizedBox(height: height*0.01,),
              TableDetailsOfAvailableRooms(width: width,model: model.availableRoomsModel,changeBookedRoomsNum: (
                  {required int index,required bool increase}){
                cubit.changeRoomBookedNumbers(index: index, increase: increase);
              },
              ),
              SizedBox(height: height*0.02,),
              Text('total Net is ${cubit.totalNet}  Euro'),
              SizedBox(height: height*0.02,),
              Center(child: CustomLoginButton(onTap: (){
                cubit.getListOfPickedRoom();
              },label: 'Book',altWidth: width*0.33,color: cubit.totalRoomNum>0? basicColor:basicColor.withOpacity(0.5),)),
            ],
          ),
        ),
        SizedBox(height: height*0.025,),
        ContactInfoWithSocialInfo(height: height, width: width,phonesList: model.hotelsModel.phoneList,webUrl: model.hotelsModel.webUrl,),
        SizedBox(height: height*0.01,),
      ],
    );
  }
}