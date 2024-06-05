import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_container.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_types.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/destinations_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/get_hotel_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/repos/get_hotels_repo/get_hotels_repo_impl.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/manager/hotel_result_cubit/hotel_result_cubit.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/manager/hotel_result_cubit/hotel_result_states.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/available_rooms/availabile_room_view.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/hotel_result/hotel_result_body.dart';

class HotelResultView extends StatelessWidget {
  const HotelResultView({super.key,required this.hotelList,required this.destModel,required this.totalNum});
final List<HotelsModel> hotelList;
final DestinationModel destModel;
final int totalNum;
 @override
  Widget build(BuildContext context) {
    final double width=BasicDimension.screenWidth(context);
    final double height=BasicDimension.screenHeight(context);
    return BlocProvider(create: (context)=>HotelResultCubit(hotelList: hotelList,hotelsRepoImpl: getIt.get<GetHotelsRepoImpl>(),destModel: destModel,totalNum: totalNum),
        child: BlocConsumer<HotelResultCubit,HotelResultStates>(
            builder: (context,state){
              var cubit=BlocProvider.of<HotelResultCubit>(context);
              return WillPopScope(
                onWillPop: ()async{
                  if(cubit.showOccupancies){
                    cubit.showOrClosePickOccupancies();
                    return false;
                  }
                  return true;
                },
                child: HotelResultBody(height: height, width: width,cubit: cubit, hotelList: hotelList),
              );
            },
            listener: (context,state){
              var cubit=BlocProvider.of<HotelResultCubit>(context);
              if(state is SuccessGetAvailableRooms){
                Navigator.push(context,MaterialPageRoute(builder: (context){
                  return RoomAvailabilityView(model: state.model!,paxList: cubit.occupanciesList, roomNum: cubit.roomNum,);
                }));
              }
              else if(state is FailureGetAvailableRooms){
                showDialog(context: context, builder: (context)=> ContainerAlertWidget(
                  types: AlertTypes.failed,
                  onTap: (){
                    Navigator.pop(context);
                  },
                  content: '${state.errMessage}',));
              }
            }),
    );
  }
}






