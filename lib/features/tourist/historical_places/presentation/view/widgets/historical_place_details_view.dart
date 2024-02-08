import 'package:flutter/material.dart';
import 'package:prepare_project/features/tourist/historical_places/presentation/view/widgets/historical_place_details_body.dart';
import 'package:prepare_project/features/tourist/image_classification/presentation/views/widgets/container_back_icon.dart';

class HistoricalPlaceDetails extends StatelessWidget {
  const HistoricalPlaceDetails({super.key,required this.height,required this.width});
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Image.asset('assets/on_boarding_images/on_boarding_1.jpg',height: height*0.5,width: width,fit: BoxFit.fill,),
            ],
          ),
          DetailsOfPlaceWithText(height: height, width: width),
          Padding(
            padding: EdgeInsets.only(top:height*0.03),
            child: ContainerBackIcons(height: height, width: width, onPressed: (){Navigator.pop(context);}),
          ),
        ],
      ),
    );
  }
}