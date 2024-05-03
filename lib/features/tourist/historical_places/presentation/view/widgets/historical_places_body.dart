import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/core/widget/sign_up_edit/custom_drop_down_button.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:prepare_project/features/tourist/historical_places/presentation/manager/historical_places_bloc.dart';
import 'package:prepare_project/features/tourist/historical_places/presentation/view/widgets/historical_places_grid_view.dart';
import 'package:prepare_project/features/tourist/historical_places/presentation/view/widgets/pagination_widget.dart';

class DiscoverPlacesBody extends StatelessWidget {
  const DiscoverPlacesBody({
    super.key,
    required this.height,
    required this.width,
    required this.cubit,
  });

  final double height;
  final double width;
  final DiscoverPlacesCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10,left: 10),
                  child: CustomGeneratedAiTripAppBar(height: height, width: width,appBarTitle: 'Discover Places',menuToSaveTrip: Row(children: [
                    const Icon(Icons.filter_alt_rounded,color: basicColor,),
                    CustomDropDownButton(list: discoverPlacesCategories, iconColor:basicColor,onChanged: (selectedCategory){
                      cubit.changeCategory(selectedCategory);
                    }, maxHeight: height*0.2,)
                  ],),),
                ),
                DiscoverPlacesGrid(height: height, width: width, place: cubit.places,),
              ],
            ),
            PaginationInHistoricalPlaces(
              controller: cubit.scrollController,
              width: width, height: height, decreaseIndex: () {
              cubit.scrollToPrevItem(width: width*0.1);
            }, pagIndex: cubit.currIndex, increaseIndex: () {
              cubit.scrollToNextItem(width: width*0.1);
            }, changeIndex: (int index) {
              cubit.changeIndex(index);
            },
              pageNumbers: cubit.paginationList,
            ),
          ],
        ),
      ),
    );
  }
}