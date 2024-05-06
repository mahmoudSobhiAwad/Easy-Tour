import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
class LoadingBestDestinationItem extends StatelessWidget {
  const LoadingBestDestinationItem({super.key,required this.height,required this.width,this.textTest});

  final double height;
  final double width;
  final String?textTest;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: thirdColor,width: 3),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Container(
            height: height*0.2,
            width: width*0.4,
            decoration:BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: thirdColor,
            ) ,
          ),
          Row(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const FaIcon(FontAwesomeIcons.ticket,color: entertainmentColor,),
                  Container(
                    width: width*0.15,
                    decoration: BoxDecoration(
                      color: thirdColor,
                      borderRadius: commonBorderRadius(),
                    ),
                    padding: const EdgeInsets.all(5),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.location_on,color: entertainmentColor,),
              textTest==null?
              Container(
                width: width*0.15,
                decoration: BoxDecoration(
                  color: thirdColor,
                  borderRadius: commonBorderRadius(),
                ),
                padding: const EdgeInsets.all(5),
              ) :
              Text('$textTest'),
            ],
          ),
        ],
      ),
    );
  }
}