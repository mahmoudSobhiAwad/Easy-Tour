import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_container.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_types.dart';
import 'package:prepare_project/features/tourist/custom_trip/data/model/custom_trip_model.dart';
import 'package:prepare_project/features/tourist/custom_trip/data/repos/custom_trip_repo_impl.dart';
import 'package:prepare_project/features/tourist/custom_trip/presentation/manager/custom_trip_cubit.dart';
import 'package:prepare_project/features/tourist/custom_trip/presentation/manager/custom_trip_states.dart';
import 'package:prepare_project/features/tourist/custom_trip/presentation/manager/get_custom_trip/get_custom_trips_cubit.dart';
import 'package:prepare_project/features/tourist/custom_trip/presentation/views/widgets/custom_trip_body.dart';
class CustomTripView extends StatelessWidget {
  const CustomTripView({super.key,this.customTripModel,required this.customTripRepoImpl,required this.cubit,this.editOrCreate=false});
  final CustomTripModel? customTripModel;
  final CustomTripRepoImpl customTripRepoImpl;
  final GetCustomTripCubit cubit;
  final bool editOrCreate;
  @override
  Widget build(BuildContext context) {
    final double height=BasicDimension.screenHeight(context);
    final double width=BasicDimension.screenWidth(context);
    return  BlocProvider(
      create: (context)=>CustomTripCubit(editOrCreate: editOrCreate,customTripRepoImpl:customTripRepoImpl,pickedCompleteTrip: customTripModel??CustomTripModel())..initEditCustomTrip(),
      child: BlocConsumer<CustomTripCubit,CustomTripState>(
          builder: (context,state) {
            var cubit=BlocProvider.of<CustomTripCubit>(context);
            return Scaffold(body: CustomTripBody(height: height, width: width,cubit: cubit,),);
            },
          listener: (context,state){
            if(state is SuccessCreateOrEditTripState){
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      backgroundColor: whatsAppColor,
                      duration: const Duration(milliseconds: 600),
                      content: Container(
                        decoration: BoxDecoration(
                          color: whatsAppColor,
                          borderRadius: BorderRadius.circular(8)
                      ),
                        child:const Text("Successfully Done",style: CustomTextStyle.font16BoldWhite,),
              )));
              Navigator.pop(context);
              cubit.getAllTrips();
            }
            else if(state is FailureCreateOrEditTripState){
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







