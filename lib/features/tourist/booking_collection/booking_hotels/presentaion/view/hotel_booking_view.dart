import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/repos/get_hotels_repo/get_hotels_repo_impl.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/manager/hotel_booking_cubit/hotel_booking_cubit.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/manager/hotel_booking_cubit/hotel_booking_state.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/hotel_booking_body.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/hotel_result/hotel_result_view.dart';

class HotelBookingView extends StatelessWidget {
  const HotelBookingView({super.key});

  @override
  Widget build(BuildContext context) {
    final double width=BasicDimension.screenWidth(context);
    final double height=BasicDimension.screenHeight(context);
    return BlocProvider(
      create: (context)=>HotelBookingCubit(hotelsRepoImpl: getIt.get<GetHotelsRepoImpl>()),
      child:BlocConsumer<HotelBookingCubit,HotelBookingStates>(
          builder: (context,state){
            var cubit=BlocProvider.of<HotelBookingCubit>(context);
            return HotelBookingBody(width: width, height: height,cubit: cubit,);
            },
          listener: (context,state){
            var cubit=BlocProvider.of<HotelBookingCubit>(context);
            if(state is SuccessGetHotelsState){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return  HotelResultView(hotelList: cubit.hotelList!,destName:cubit.destName,roomNum: cubit.roomNum,checkIn: cubit.checkIn,checkOut: cubit.checkOut,childNum: cubit.childNum,adultNum: cubit.adultNum,);
              }));
            }
          }) ,
    );
  }
}




