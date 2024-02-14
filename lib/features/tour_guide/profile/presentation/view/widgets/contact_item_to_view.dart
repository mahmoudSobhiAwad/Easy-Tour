import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/core/widget/tour_guide/get_social_widget.dart';

class ContactShowItem extends StatelessWidget {
  const ContactShowItem({super.key,required this.name,required this.contactData,required this.width,required this.removeFromSocialLinks});
  final String name;
  final String contactData;
  final double width;
  final void Function() removeFromSocialLinks;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width:width*0.75,
          decoration: BoxDecoration(
              borderRadius: commonBorderRadius(),
              color: Colors.white,
              border: Border.all(color: secondaryColor,width: 1),
              boxShadow:  [
                buildBoxShadow(),
              ]
          ),
          child: Row(
            children: [
              SizedBox(
                width: 60,
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getSocialIcon(name),
                      const VerticalDivider(thickness: 1,color:Color(0xffCDCDCD),indent: 5,endIndent: 5,),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 5,),
              Text(contactData),
            ],
          ),
        ),
        IconButton(onPressed: removeFromSocialLinks, icon: const Icon(Icons.delete_rounded,color: closeColor,))
      ],
    );
  }
}