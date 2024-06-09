import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
class AddNewDestination extends StatelessWidget {
  const AddNewDestination({
    super.key,
    required this.addNewDestination,
    required this.width,
  });

  final void Function() addNewDestination;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: addNewDestination,
      child: Padding(
        padding: const EdgeInsets.only(left: 5.0,top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(
                height: 10,
                child: VerticalDivider(thickness: 2,color: secondaryColor,)),
            Container(
              width: width*0.45,
              padding:const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: const Color(0xffF57366).withOpacity(0.74),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.add,color: Colors.white,),
                  Text('Add New Destination',style: CustomTextStyle.font12WithEllipsis.copyWith(color: Colors.white),)
                ],
              ),
            )
          ],),
      ),
    );
  }
}
