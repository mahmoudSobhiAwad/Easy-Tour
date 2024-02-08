import 'package:flutter/material.dart';

import '../../utilities/basics.dart';

class CustomDropDownList extends StatelessWidget {
  const CustomDropDownList({super.key,required this.items,required this.height,required this.addPref});
  final List<String>items;
  final double height;
  final void Function(String?value)addPref;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding:const EdgeInsets.all(5),
        physics:const BouncingScrollPhysics(),
        itemBuilder: (context,index){
          return  SizedBox(
              height: height*0.05,
              child: TextButton(onPressed: (){
                addPref(items[index]);
              },child:Text(items[index],style: const TextStyle(color: basicColor,overflow: TextOverflow.ellipsis,),)));
        }, separatorBuilder: (context,index)=>const SizedBox(height: 5,), itemCount: items.length);
  }
}
