import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/two_beside_form.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/view/widgets/date_picker_destination.dart';

class DateWithPassengerNumbersWithPlace extends StatelessWidget {
  const DateWithPassengerNumbersWithPlace({super.key,required this.height,required this.width,required this.onSearch});
  final double width;
  final double height;
  final void Function() onSearch;
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        DatePickerWithDestination(width: width, height: height),
        SizedBox(height: height*0.02,),
        CustomTwoFieldForm(
          mainAlignment: MainAxisAlignment.center,
            firstCustomFormField:  Container(
              width: width*0.75,
              height: height*0.08,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: secondaryColor,width: 2),
              ),
              child: const Row(
                children: [
                  IconButton(onPressed: null, icon: Icon(Icons.person)),
                  Text('2 adult. 0 children .1 room'),
                  IconButton(
                      onPressed: null,
                      icon: RotatedBox(
                          quarterTurns: -1,
                          child: Icon(Icons.arrow_back_ios))),
                ],
              ),
            ),
            secondCustomFormField: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: CircleAvatar(
                backgroundColor: forthColor,
                radius: width*0.055,
                child:  IconButton(onPressed: onSearch, icon: const Icon(Icons.search_rounded,color: Colors.white,),),
              ),
            )
        ),
      ],
    );
  }
}