
import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/two_beside_form.dart';
class TravelersDateAndTripType extends StatelessWidget {
  const TravelersDateAndTripType({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return CustomTwoFieldForm(
      mainAlignment: MainAxisAlignment.spaceBetween,
      firstCustomFormField:Container(
        width: width*0.6,
        height: height*0.07,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: secondaryColor,width: 2),
        ),
        padding:const EdgeInsets.all(5),
        child: const Row(
          children: [
            Icon(Icons.person),
            Text('0 Adult, 0 Children'),
            IconButton(onPressed:null,icon:Icon(Icons.add_circle),),
          ],
        ),
      ),
      firstText:'Travelers' ,
      secondCustomFormField:Container(
        width: width*0.3,
        height: height*0.07,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: secondaryColor,width: 2),
        ),
        child: Row(
          children: [
            SizedBox(
                width:width*0.2,
                child:const Text('sadsadsa',style: CustomTextStyle.commonFontThin,)),
            GestureDetector(
              onTap: (){
                showMenu(context: context,
                    constraints: BoxConstraints(maxHeight: height*0.1,maxWidth: width*0.3),
                    position: RelativeRect.fromLTRB(width*0.8,height*0.8,15, height*0.15), items: [
                      ...List.generate(4, (index) => const PopupMenuItem(child: Text('ECONOMY')))
                    ]
                );
              },
              child: const RotatedBox(
                  quarterTurns: 1,
                  child: Icon(Icons.arrow_forward_ios)),
            ),
          ],
        ),
      ),
      secondText: 'Type',
    );
  }
}