import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_container.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_types.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/data/flight_models/get_tickets_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/data/flight_repos/get_tickets_repo_impl.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/manager/check_price/check_price_cubit.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/manager/check_price/check_price_states.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/view/create_order/create_flight_order_view.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/view/flight_details/flight_full_ticket_details.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/view/flight_details/ticket_info.dart';

class FlightDetailsView extends StatelessWidget {
  const FlightDetailsView({super.key,required this.model,required this.index,required this.travelerNum});
  final GetTicketsModel model;
  final int index;
  final int travelerNum;
  @override
  Widget build(BuildContext context) {
    final double width=BasicDimension.screenWidth(context);
    final double height=BasicDimension.screenHeight(context);
    return BlocProvider(
      create: (context)=>CheckPriceCubit(getTicketsRepoImpl: getIt.get<GetTicketsRepoImpl>(), index: index),
      child:BlocConsumer<CheckPriceCubit,CheckPriceStates>(
          builder: (context,state){
            var cubit=BlocProvider.of<CheckPriceCubit>(context);
            return Scaffold(
              body: SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomGeneratedAiTripAppBar(height: height, width: width,appBarTitle: 'Flight Details',appBarStyle: CustomTextStyle.fontBold21,),
                        FlightTicketInDetailsView(width: width, height: height,model: model,),
                        SizedBox(height: height*0.025,),
                        TicketInfo(lastTicketDate: model.lastTicketTime??"",instantTicket: model.instantBooking,),
                        SizedBox(height: height*0.05,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomLoginButton(color: Colors.white,label: 'Cancel',labelStyle: CustomTextStyle.fontBold18.copyWith(color: ticketBasicColor),borderRadius: 12,onTap: (){
                              Navigator.pop(context);
                            },),
                            CustomLoginButton(color: ticketBasicColor,label: 'Confirm',borderRadius: 12,isLoading: cubit.isLoading,onTap: (){
                              cubit.checkPrice();
                            },),
                          ],
                        ),
                      ],
                    ),
                  )),
        );
            },
          listener: (context,state){
            if(state is SuccessCheckPriceState){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return CreateFlightOrderView(travelerNum: travelerNum,);
              }));
            }
            else if(state is FailureCheckPriceState){
              showDialog(context: context, builder: (context)=> ContainerAlertWidget(
                types: AlertTypes.failed,
                onTap: (){
                  Navigator.pop(context);
                },
                content: '${state.errMessage}',));
            }
          }) ,
    );
  }
}













