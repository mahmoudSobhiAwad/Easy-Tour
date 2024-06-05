import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_container.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_types.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/get_availbitly_room_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/repos/get_hotels_repo/get_hotels_repo_impl.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/manager/payment_personal_data_cubit/payment_personal_data_cubit.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/manager/payment_personal_data_cubit/payment_personal_data_states.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/personal_payment/pay_in_booking.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/personal_payment/personal_data_booking_body.dart';

class PersonalDataPaymentForHotelBookingView extends StatelessWidget {
  const PersonalDataPaymentForHotelBookingView({super.key,required this.needRooms});
  final List<GetAvailableRoomsModel>needRooms;
  @override
  Widget build(BuildContext context) {
    final double width=BasicDimension.screenWidth(context);
    final double height=BasicDimension.screenHeight(context);
    return BlocProvider(
      create: (context)=>PaymentPersonalDataCubit(neededRooms:needRooms,getHotelsRepoImpl: getIt.get<GetHotelsRepoImpl>())..preparePayList(),
      child: BlocConsumer<PaymentPersonalDataCubit,PaymentPersonalDataStates>(
          builder: (context,state){
            var cubit=BlocProvider.of<PaymentPersonalDataCubit>(context);
            return WillPopScope(
              onWillPop: ()async{
                if(cubit.currentPage==0){
                  return true;

                }
                else{
                  cubit.toggleBetweenPages(0);
                  return false;
                }
              },
              child: SafeArea(
                child: Scaffold(
                  body: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        PersonalDataInBookingView(height: height,width: width,cubit: cubit,),
                        cubit.isLoading?
                        Container(
                          width: width*0.3,
                          height: height*0.15,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child:const Center(child:CircularProgressIndicator()),
                        ):
                        const SizedBox(),
                      ],
                    ),

                    Stack(
                      alignment: Alignment.center,
                      children: [
                        PayInBookingView(width: width, height: height,cubit: cubit,),
                        cubit.isLoading?
                        Container(
                          width: width*0.3,
                          height: height*0.15,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child:const Center(child:CircularProgressIndicator()),
                        ):
                        const SizedBox(),
                      ],
                    )][cubit.currentPage],
                ),
              ),
            );
          },
          listener: (context,state){
            if(state is FailureSendCheckOfBooking){
            showDialog(context: context, builder: (context)=> ContainerAlertWidget(
            types: AlertTypes.failed,
            onTap: (){
            Navigator.pop(context);
            },
            content: '${state.errMessage}',));
            }
            else if(state is FailurePaymentOfBooking){
            showDialog(context: context, builder: (context)=> ContainerAlertWidget(
            types: AlertTypes.failed,
            onTap: (){
            Navigator.pop(context);
            },
            content: '${state.errMessage}',));
            }
          }),);
  }
}










