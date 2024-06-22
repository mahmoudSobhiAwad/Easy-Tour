import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_container.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_types.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/data/flight_repos/get_tickets_repo_impl.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/manager/create_order/cubit.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/manager/create_order/states.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/view/create_order/traveler_requirement_for_flight_booking_item.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/view/payment/pay_view.dart';
class CreateFlightOrderView extends StatelessWidget {
  const CreateFlightOrderView({super.key,required this.travelerNum});
final int travelerNum;
  @override
  Widget build(BuildContext context) {
    final double width=BasicDimension.screenWidth(context);
    final double height=BasicDimension.screenHeight(context);
    return BlocProvider(
      create: (context)=>CreateFlightOrderCubit(travelerNum: travelerNum, getTicketsRepoImpl: getIt.get<GetTicketsRepoImpl>())..initTravelersDataList(),
      child: BlocConsumer<CreateFlightOrderCubit,CreateFlightOrderStates>(
          builder: (context,state){
            var cubit=BlocProvider.of<CreateFlightOrderCubit>(context);
            return Scaffold(
              body: SafeArea(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 12).copyWith(bottom: 12),
                  children: [
                    CustomGeneratedAiTripAppBar(height: height, width: width,appBarTitle: 'Flight Booking',),
                    SizedBox(height: height*0.015,),
                    const Text('Fill All The Requirements For Travelers',style: CustomTextStyle.fontBold18,),
                    SizedBox(height: height*0.01,),
                    SizedBox(
                      height: height*0.8,
                      child: PageView.builder(
                          itemCount: travelerNum,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context,index){
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: TravelerRequirementsForFlightBookingItem(width: width, height: height,cubit: cubit,index: index,),
                            );
                          }),
                    ),
                    SizedBox(height: height*0.015,),
                    CustomTextFormField(
                      maxLines: 3,
                      controller: cubit.remarkController,
                      label: 'Remark....',
                    ),
                    SizedBox(height: height*0.015,),
                    CustomLoginButton(
                      onTap: (){
                        cubit.checkConfirmation();
                      },
                      color: ticketBasicColor,
                      label: 'Create Order',
                      altWidth: width*0.6,
                      borderRadius: 10,
                    ),
                  ],
                ),
              ),
            );
      }, listener: (context,state){
            if(state is SuccessSendFlightOrderState){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return const PayFlightDemo();
              }));
            }
            else if(state is FailureSendFlightOrderState){
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







