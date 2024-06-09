import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/get_hotel_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/manager/hotel_result_cubit/hotel_result_cubit.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/date_range_pass_num_destination.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/hotel_result/one_hotel_item_in_result.dart';

class HotelResultBody extends StatelessWidget {
  const HotelResultBody({
    super.key,
    required this.height,
    required this.width,
    required this.cubit,
    required this.hotelList,
  });

  final double height;
  final double width;
  final HotelResultCubit cubit;
  final List<HotelsModel> hotelList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: CustomGeneratedAiTripAppBar(height: height, width: width,appBarTitle: '${cubit.destModel.destName}:Hotels',appBarStyle: CustomTextStyle.fontBold21,appBarWidth: width*0.8,),
                ),
                SizedBox(height: height*0.025,),
                DateWithPassengerNumbersWithPlace(height: height, width: width,onSearch: (){}, cubit: cubit,),
                SizedBox(height: height*0.025,),
                Expanded(
                  child: NotificationListener<ScrollEndNotification>(
                    onNotification: (notification){
                      final metrics = notification.metrics;
                      if (metrics.atEdge) {
                        if (metrics.pixels == metrics.maxScrollExtent) {
                          cubit.loadMoreHotels();
                        }
                      }
                      return false;
                    },
                    child: ListView.separated(
                        controller: cubit.scrollController,
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        itemBuilder: (context,index){
                          return OneHotelItemInBooking(width: width, height: height,model: hotelList[index],onTap: (){
                            cubit.searchForAvailableRooms(hotelCode: hotelList[index].code!, hotelIndex: index);
                          },);
                        }, separatorBuilder: (context,index){
                      return SizedBox(height: height*0.025,);
                    }, itemCount: hotelList.length),
                  ),
                ),
              ],
            ),
            cubit.showOccupancies?
            Align(
                alignment: Alignment.bottomCenter,
                child: OccupanciesWidget(cubit: cubit, width: width,height: height,)) :
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}