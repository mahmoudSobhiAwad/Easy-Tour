import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:prepare_project/features/tour_guide/requested_trips/presentaions/manager/requested_trip_for_guide/requested_trip_for_guide_cubit.dart';
import 'package:prepare_project/features/tour_guide/requested_trips/presentaions/view/widgets/request_details/request_details_view.dart';
import 'package:prepare_project/features/tour_guide/requested_trips/presentaions/view/widgets/request_trip_item.dart';

import '../../../../../tourist/chat_with_other/presentaions/views/widgets/custom_dissmisable_chat.dart';
class RequestedTripsTourGuideBody extends StatelessWidget {
  const RequestedTripsTourGuideBody({
    super.key,
    required this.width,
    required this.height,
    required this.cubit
  });

  final double width;
  final double height;
  final RequestedTripForGuideCubit cubit;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:cubit.isLoading?
        const Center(child: CircularProgressIndicator()):
        Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width*0.05),
              child: CustomGeneratedAiTripAppBar(height: height, width: width,appBarTitle: 'Notification',appBarStyle: CustomTextStyle.commonSignDark.copyWith(fontSize: 18),
                menuToSaveTrip: TextButton(onPressed: null, child: Text('Clear All',style: CustomTextStyle.commonSignDark.copyWith(color: forthColor),)),),
            ),
            cubit.requestedList.isEmpty?
            const Text('You Dont\'t Have Any Request Yet',style: CustomTextStyle.privateTourTitle,):
            Expanded(
              child: SizedBox(
                height: height*0.8,
                child: RefreshIndicator(
                  onRefresh: ()async{
                    await cubit.getAllRequested();
                  },
                  child: ListView.builder(
                    padding:const EdgeInsets.symmetric(vertical: 20),
                    itemBuilder: (context,index){
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return RequestDetailsView(model:cubit.requestedList[index]);
                          }));
                        },
                        child: CustomDismissible(
                          child: Column(
                            children: [
                              RequestedTripForGuideItemWidget(height: height, width: width,model: cubit.requestedList[index],),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10.0,left: width*0.125,right: width*0.125),
                                child: SizedBox(
                                    width: width*0.7,
                                    child: Divider(thickness: 3,color: entertainmentColor.withOpacity(0.6),)),
                              ),
                            ],
                          ),
                        ),
                      );
                    },itemCount: cubit.requestedList.length,
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}