import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_container.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_types.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/data/repo/get_guide_info_repo/get_guide_info_repo_imp.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/managers/guide_view_cubit/guide_view_for_tourist_cubit.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/managers/guide_view_cubit/guide_view_for_tourist_state.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/views/widgets/view_guide_profile_body.dart';
class ViewGuideProfileFromTouristView extends StatelessWidget {
  const ViewGuideProfileFromTouristView({super.key,required this.email});
  final String? email;
  @override
  Widget build(BuildContext context) {
    final double width=BasicDimension.screenWidth(context);
    final double height=BasicDimension.screenHeight(context);
    return  BlocProvider(create: (context)=>ViewGuideCubitForTourist(
        getGuideInfoForTouristRepImp: getIt.get<GetGuideInfoForTouristRepImp>(), tourGuideEmail: email??"")..getTourGuideData(),
      child:BlocConsumer<ViewGuideCubitForTourist,GuideViewForTouristState>(
          builder: (context,state){
            var cubit=BlocProvider.of<ViewGuideCubitForTourist>(context);
            return ViewGuideProfileForTouristBody(height: height, width: width,cubit: cubit,model: cubit.model,);
            },
          listener: (context,state){
            if(state is FailureGetGuideViewForTouristState){
              showDialog(context: context, builder: (context)=> ContainerAlertWidget(
                types: AlertTypes.failed,
                onTap: (){
                  Navigator.pop(context);
                },
                content: '${state.errMessage}',));
            }
          }
      ),
    );
  }
}








