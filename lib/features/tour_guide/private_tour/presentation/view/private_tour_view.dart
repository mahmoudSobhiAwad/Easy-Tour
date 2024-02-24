import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_container.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_types.dart';
import 'package:prepare_project/features/tour_guide/private_tour/data/repos/private_tour_repo_impl.dart';
import 'package:prepare_project/features/tour_guide/private_tour/presentation/manager/tour_cubit/private_tour_cubit.dart';
import 'package:prepare_project/features/tour_guide/private_tour/presentation/manager/tour_cubit/private_tour_state.dart';
import 'package:prepare_project/features/tour_guide/private_tour/presentation/view/widgets/private_tours_list.dart';

class PrivateToursView extends StatelessWidget {
  const PrivateToursView({super.key,required this.height,required this.width});
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(create: (context)=>PrivateTourCubit(privateTourRepo: getIt.get<PrivateTourRepoImp>())..getAllMyTrip(),
    child: BlocConsumer<PrivateTourCubit,PrivateTourStates>(
      builder:(context,state){
        var cubit=BlocProvider.of<PrivateTourCubit>(context);
        return cubit.isLoading?const Center(child: CircularProgressIndicator(color:basicColor),):
          PrivateToursListBody(height: height, cubit: cubit, width: width);
        } , 
      listener: (context,state){
        var cubit=BlocProvider.of<PrivateTourCubit>(context);
        if(state is FailureGetALLPrivateTourState ){
          showDialog(context: context, builder: (context)=> ContainerAlertWidget(
            types: AlertTypes.failed,
            onTap: (){
              Navigator.pop(context);
            },
            content: '${state.errMessage}',));
        }
        else if(state is RefreshTokenFailureState) {
          showDialog(context: context, builder: (context)=> ContainerAlertWidget(
            types: AlertTypes.failed,
            onTap: (){
              cubit.getAllMyTrip().then((value){Navigator.pop(context);});
            },
            content: '${state.errMessage}',));
        }
      },
    ),
    );
  }
}
