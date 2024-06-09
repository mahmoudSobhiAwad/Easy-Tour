import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
class DeleteOrEditPhoto extends StatelessWidget {
  const DeleteOrEditPhoto({super.key,this.photoName,required this.deleteImage,required this.cropImage});
  final String?photoName;
  final void Function() deleteImage;
  final Future<void> Function() cropImage;
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Container(
        padding:const EdgeInsets.symmetric(horizontal: 15,vertical: 30),
        height: MediaQuery.of(context).size.height*0.2,
        width: MediaQuery.of(context).size.width*0.8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap:(){
                  deleteImage();
                  Navigator.pop(context);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Delete",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color:closeColor),),
                    SizedBox(width: 30,),
                    Icon(Icons.delete_rounded,color: Colors.grey,),

                  ],
                )),
            const Divider(thickness: 0.5,color: secondaryColor,),
            GestureDetector(
                onTap:(){
                  cropImage();
                  Navigator.pop(context);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Edit",style:CustomTextStyle.fontBold16,),
                    SizedBox(width: 30,),
                    Icon(Icons.edit,color: secondaryColor,),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}