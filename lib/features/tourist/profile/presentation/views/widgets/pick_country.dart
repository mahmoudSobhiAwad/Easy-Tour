import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';

class PickCountry extends StatelessWidget {
  const PickCountry({super.key,required this.onSelect,this.countryFlag,this.countryName,required this.width});
  final void Function(Country value) onSelect;
  final String?countryName;
  final String?countryFlag;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
       width: width,
      padding:const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: formFillColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: secondaryColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           SizedBox(
             width: 90,
               child: Text('$countryFlag''$countryName',overflow: TextOverflow.ellipsis,)),
          IconButton(onPressed: (){
            showCountryPicker(
              context: context,
              exclude: ['Israel'],
              showPhoneCode: false,
              onSelect:onSelect,
            );
          }, icon: const Icon(Icons.arrow_drop_down,size: 30,))
        ],
      ),
    );
  }
}