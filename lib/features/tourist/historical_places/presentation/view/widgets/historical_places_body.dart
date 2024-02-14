import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/historical_places/presentation/manager/historical_places_bloc.dart';
import 'package:prepare_project/features/tourist/historical_places/presentation/view/widgets/historical_places_grid_view.dart';
import 'package:prepare_project/features/tourist/historical_places/presentation/view/widgets/pagination_widget.dart';
import 'package:prepare_project/features/tourist/image_classification/presentation/views/widgets/container_back_icon.dart';

class HistoricalPlacesBody extends StatelessWidget {
  const HistoricalPlacesBody({
    super.key,
    required this.height,
    required this.width,
    required this.cubit,
  });

  final double height;
  final double width;
  final HistoricalPlacesCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top:height*0.035),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ContainerBackIcons(height: height, width: width, onPressed: (){Navigator.pop(context);}),
                    const Text('Historical Places',style: CustomTextStyle.placesTitle,),
                    const IconButton(onPressed: null, icon:  Icon(Icons.filter_alt_rounded,size: 35,color: basicColor,),),
                  ],
                ),
              ),
              const SizedBox(height:25,),
              const Padding(
                padding:  EdgeInsets.only(left: 20.0),
                child:  Text('All Places',style: CustomTextStyle.placesTitle,),
              ),
              //const SizedBox(height:25,),
              HistoricalPlacesGrid(height: height, width: width),
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
    );
  }
}