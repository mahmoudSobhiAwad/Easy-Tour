import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';

class OptionPickImage extends StatelessWidget {
  const OptionPickImage({super.key,required this.getImageFromGallery, this.cropImage,required this.getImageFromCamera});

  final Future<void> Function() getImageFromGallery;
  final Future<void> Function() getImageFromCamera;
  final Future<void> Function()? cropImage;

  @override
  Widget build(BuildContext context) {
    final double height=BasicDimension.screenHeight(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 20),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: height*0.22,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(onTap: (){
                    context.pop();
                  },child: const CircleAvatar(radius: 13,backgroundColor:closeColor,child:Center(child:  FaIcon(FontAwesomeIcons.xmark,color:Colors.white,size: 20,)))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: GestureDetector(
                    onTap:(){
                      getImageFromGallery().then((value)=>Navigator.pop(context));

                    },
                    child:const Row(
                      children: [
                         Text("Upload From Gallery",style:CustomTextStyle.commonSignDark,),
                        SizedBox(width: 30,),
                        Icon(Icons.photo_library_rounded,color: basicColor,size: 35,),
                      ],
                    )),
              ),
              const Divider(thickness: 0.5,color: secondaryColor,),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: GestureDetector(
                    onTap:(){
                      getImageFromCamera().then((value) {
                         //cropImage();
                      }).then((value)=>Navigator.pop(context));
                    },
                    child:const Row(
                      children: [
                        Text("Take A Picture",style: CustomTextStyle.commonSignDark),
                        SizedBox(width: 20,),
                        Icon(Icons.camera_alt_rounded,color: basicColor,size: 35,),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

