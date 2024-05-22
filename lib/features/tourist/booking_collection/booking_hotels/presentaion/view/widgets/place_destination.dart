import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';

class PlaceDestinationInHotelBooking extends StatelessWidget {
  const PlaceDestinationInHotelBooking({
    super.key,
    required this.height,
    required this.width,
    this.lastWidth
  });

  final double height;
  final double width;
  final double? lastWidth;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: commonBorderRadius(),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Image.network('https://imgs.search.brave.com/fFGUGfmEQfr7PVDaK5JWkr7XHg-v7h6FcvexpgVsXUE/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvMTA3/MzQzNjQ4OC9waG90/by9weXJhbWlkcy5q/cGc_cz02MTJ4NjEy/Jnc9MCZrPTIwJmM9/TGRjcTloSjdIbk1J/aVJyYjE4YVhCQkpE/cXlVenAzNWhIZ3Jl/R3BOcW5BYz0',
              height: height*0.15,width:lastWidth??width*0.45,fit: BoxFit.cover,),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Luxor',style: CustomTextStyle.commonSignAlwaysWhite,),
            )
          ],
        )
    );
  }
}