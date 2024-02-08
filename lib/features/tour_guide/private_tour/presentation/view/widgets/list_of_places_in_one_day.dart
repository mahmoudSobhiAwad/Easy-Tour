import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/tour_guide/private_tour/data/model/private_tour_model.dart';

class PlacesListOfOneDay extends StatelessWidget {
  const PlacesListOfOneDay({
    super.key,
    required this.height,
    required this.width,
    required this.enable,
    required this.placesOfDay,

  });
  final double height;
  final double width;
  final bool? enable;
  final List<Place>placesOfDay;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height*0.3,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: placesOfDay.length,
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width*0.38,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Place ${index+1}'),
                            CustomTextFormField(
                              initialValue: placesOfDay[index].placeName,
                              border: 20,
                              onChanged: (String value){
                                placesOfDay[index].placeName=value;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: width*0.38,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('type'),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(borderRadius: commonBorderRadius(),border:Border.all(color: secondaryColor,width: 2)),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Historical'),
                                  IconButton(padding: EdgeInsets.zero,onPressed: null, icon: Icon(Icons.arrow_drop_up_outlined)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          placesOfDay.removeAt(index);
                        },
                          child: const Icon(Icons.delete_rounded,color: closeColor,))
                    ],
                  ),
                  const SizedBox(height: 10,),
                  const Text('Activity'),
                  CustomTextFormField(
                    initialValue: placesOfDay[index].activity,
                    onChanged: (String value){
                      placesOfDay[index].activity=value;
                    },
                    border: 20,
                  ),
                ],
              ),
            );
          }
      ),
    );
  }
}