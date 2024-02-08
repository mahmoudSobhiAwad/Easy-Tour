import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/utilities/basics.dart';

class LicencesView extends StatelessWidget {
  const LicencesView({super.key,required this.height,required this.width,required this.licences});
  final double width;
  final double height;
  final List<String>licences;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding:const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(onPressed: (){
              context.pop();
            }, icon: const Icon(Icons.close),),
            ...List.generate(licences.length, (index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(licences[index]),
                const SizedBox(height: 10,),
                Container(
                  width: width,
                  height: height*0.4,
                  decoration: BoxDecoration(color: thirdColor,borderRadius: BorderRadius.circular(20),),),
              ],
            ),),
          ],
        ),
      ),
    );
  }
}