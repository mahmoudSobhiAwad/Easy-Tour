import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/get_availbitly_room_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/manager/room_view_cubit/rooms_view_cubit.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/manager/room_view_cubit/rooms_view_states.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/available_rooms/room_availabile_body.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/personal_payment/personal_data_payment_for_booking_view.dart';
class RoomAvailabilityView extends StatelessWidget {
  const RoomAvailabilityView({super.key,required this.model,required this.paxList,required this.roomNum});
final HotelModelWithRoomModel model;
final int roomNum;
final List<OccupanciesModel> paxList;
  @override
  Widget build(BuildContext context) {
    final double width=BasicDimension.screenWidth(context);
    final double height=BasicDimension.screenHeight(context);
    return BlocProvider(
      create: (context)=>RoomsViewCubit(
        paxList: paxList,
          totalRoomNum: roomNum,
          availableRoomsList: model.availableRoomsModel)..loadFacilityFromLocal(context, model.hotelsModel),
      child:BlocConsumer<RoomsViewCubit,RoomsViewState>(
          builder: (context,state){
            var cubit=BlocProvider.of<RoomsViewCubit>(context);
            return Scaffold(
              body: RoomAvailabilityBody(height: height, width: width, model: model,cubit: cubit,),
            );
      },
          listener: (context,stata){
            if(stata is InitNeededRoomsList){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return  PersonalDataPaymentForHotelBookingView(needRooms: stata.rooms,);
              }));
            }
          }) ,
    );
  }
}




