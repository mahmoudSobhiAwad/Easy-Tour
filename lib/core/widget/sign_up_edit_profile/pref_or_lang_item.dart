import 'package:flutter/material.dart';

import '../../utilities/basics.dart';

class PreferenceItem extends StatelessWidget {
  const PreferenceItem({super.key,required this.textWidth,required this.itemHeight,required this.text,required this.width,required this.removePref});
  final double itemHeight;
  final double width;
  final String text;
  final void Function(String?value)removePref;
  final double textWidth ;
  @override
  Widget build(BuildContext context) {
    return  Container(
      height:itemHeight,
      width: width,
      padding:const EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: textWidth,child: Text(text,maxLines: 2,overflow: TextOverflow.ellipsis,)),
          GestureDetector(
            onTap: (){
              removePref(text);
            },
            child:const Padding(
              padding:  EdgeInsets.only(right: 5.0),
              child:  CircleAvatar(
                  radius: 10,
                  backgroundColor: Color(0xffF57366),
                  child: Center(child: Icon(Icons.close,color: Colors.white,size: 16,))),
            ),
          ),
        ],
      ),
    );
  }
}