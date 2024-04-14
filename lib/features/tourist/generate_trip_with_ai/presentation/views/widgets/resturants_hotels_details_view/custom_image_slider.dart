import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
class CustomImageSlider extends StatelessWidget {
  const CustomImageSlider({
    super.key,
    required this.width,
    required this.height,
    required this.photoUrls,
  });

  final double width;
  final double height;
  final List <String> photoUrls;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height*0.45,
      child: PageView.builder(
          itemCount: photoUrls.length,
          itemBuilder: (context,index){
            return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image.network(photoUrls[index],fit: BoxFit.fill,height: height*0.45,width: width,),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...List.generate(photoUrls.length, (dotIndex) => Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: CircleAvatar(radius: 7.5,backgroundColor:dotIndex==index? entertainmentColor:Colors.white),
                        ))
                      ],
                    ),
                  ),]);
          }),
    );
  }
}