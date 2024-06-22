import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/repos/get_hotels_repo/get_hotels_repo_impl.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/manager/payment_personal_data_cubit/payment_personal_data_cubit.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/manager/payment_personal_data_cubit/payment_personal_data_states.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/personal_payment/pay_in_booking.dart';

class PayFlightDemo extends StatelessWidget {
  const PayFlightDemo({super.key});
  @override
  Widget build(BuildContext context) {
    final double width=BasicDimension.screenWidth(context);
    final double height=BasicDimension.screenHeight(context);
    return BlocProvider(create: (context)=>PaymentPersonalDataCubit(neededRooms: [], getHotelsRepoImpl: getIt.get<GetHotelsRepoImpl>()),
      child: BlocBuilder<PaymentPersonalDataCubit,PaymentPersonalDataStates>(builder: (context,state){
        var cubit=BlocProvider.of<PaymentPersonalDataCubit>(context);
        return Scaffold(body: Padding(
          padding: EdgeInsets.only(top: height*0.05),
          child: PayInBookingView(width: width, height: height, cubit: cubit),
        ));
    }),
    );
  }
}
