import 'package:flutter/material.dart';

import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
class ShowGuideLicenceForTourist extends StatelessWidget {
  const ShowGuideLicenceForTourist({super.key,required this.licences,required this.height,required this.width,this.cvUrl});
  final List<String>licences;
  final double height;
  final double width;
  final String? cvUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon: const Icon(Icons.close),),
              ...List.generate(licences.length, (index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(['Ministry ID','Syndicate ID'][index],style: CustomTextStyle.placesTitle,),
                  Padding(
                    padding:const EdgeInsets.only(bottom: 20),
                    child: Container(
                      width: width,
                      height: height*0.3,
                      decoration: BoxDecoration(color: thirdColor,borderRadius: BorderRadius.circular(20),),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(licences[index],fit: BoxFit.fill,
                          errorBuilder: (context,ob,e)=>const Icon(Icons.error,color: closeColor,),

                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ),
              const SizedBox(height: 10,),
              const Text('CV',style: CustomTextStyle.placesTitle,),
              cvUrl==null?
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: basicColor,
                  borderRadius: commonBorderRadius(),
                ),
                child: Text('Cv File',style: CustomTextStyle.commonFontThin.copyWith(color: Colors.white),),
              ):
              const SizedBox(),
              const SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}