import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/features/tour_guide/private_tour/data/data_ui.dart';
class CustomImageSlider extends StatelessWidget {
  const CustomImageSlider({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height*0.45,
      child: PageView.builder(
          itemCount: 3,
          itemBuilder: (context,index){
            return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image.network([historicalPlace,defaultImage,foodPlaces][index],fit: BoxFit.fill,height: height*0.45,width: width,),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...List.generate(3, (dotIndex) => Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: CircleAvatar(radius: 7.5,backgroundColor:dotIndex==index? entertainmentColor:Colors.white),
                        ))
                      ],
                    ),
                  ),
                  // ...List.generate(3, (dotIndex) => const CircleAvatar(radius: 10,backgroundColor: entertainmentColor))
                ]);
          }),
    );
  }
}