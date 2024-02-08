import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/tourist/historical_places/presentation/view/widgets/fav_widget_icon.dart';

class HistoricalPlaceItem extends StatelessWidget {
  const HistoricalPlaceItem({super.key,required this.height,required this.width});
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              borderRadius: commonBorderRadius(),
              boxShadow: const[
                BoxShadow(
                  blurRadius: 4,
                  offset: Offset(0,4),
                ),
              ],
              image: const DecorationImage(image: AssetImage('assets/on_boarding_images/on_boarding_1.jpg'),fit: BoxFit.fill)
          ),
        ),
        Positioned(
          top: height*0.7,
          child: SizedBox(
            width: width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: width*0.6,
                  height: height*0.2,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: commonBorderRadius(),
                    boxShadow: const[
                      BoxShadow(
                        blurRadius: 4,
                        offset: Offset(0,4),
                      ),
                    ],
                  ),
                  child: const Center(child:  Text('Pyramids',style: CustomTextStyle.commonFontThin,overflow: TextOverflow.ellipsis,)),
                ),
                FavouritePlaceIcon(width: width),
              ],
            ),
          ),
        )
      ],
    );
  }
}
