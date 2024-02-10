import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';

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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             const SizedBox(height: 20,),
              IconButton(onPressed: (){
                context.pop();
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
                          //loadingBuilder: (context,ob,e)=>const Icon(Icons.access_time_rounded),
                    ),
                      ),
                    ),
                  ),
                ],
              ),
              ),
              const SizedBox(height: 10,),
              const Text('CV',style: CustomTextStyle.placesTitle,),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding:const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: basicColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Upload your resume',style: CustomTextStyle.commonSignLight.copyWith(color: Colors.white),),
                        const SizedBox(width: 5,),
                        const Icon(Icons.cloud_upload_rounded,color: thirdColor,)
                      ],
                    ),
                  ),
                  const Align(
                      alignment: Alignment.bottomRight,
                      child: Text('Doc ,Docx, Pdf (1 MB)',style: CustomTextStyle.tripDetailsInTourGuide,)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}