import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';

class PickCountry extends StatelessWidget {
  const PickCountry({super.key,required this.onSelect,this.countryFlag,this.countryName,required this.width,this.maxLine});
  final void Function(Country value) onSelect;
  final String?countryName;
  final String?countryFlag;
  final double width;
  final int?maxLine;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding:const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: secondaryColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           SizedBox(
               width: width*0.5,
               child: Text('$countryFlag''$countryName',overflow: TextOverflow.ellipsis,maxLines: maxLine,)),
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