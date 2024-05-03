import 'dart:io';
import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/features/tourist/chat_with_other/data/models/recent_chat_model.dart';
class ImageMessageInChat extends StatelessWidget {
  const ImageMessageInChat({
    super.key,
    required this.showImagePreview,
    required this.model,
    required this.width,
    required this.height,
  });

  final void Function(String path)?showImagePreview;
  final CompleteChatOTOModel model;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        showImagePreview!(model.imageModel!.imageNetworkPath!);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: model.type=='source'?Alignment.centerRight:Alignment.centerLeft,
          child: Container(
            width: width*0.67,
            //height: height*0.31,
            decoration: BoxDecoration(
              image:model.imageModel!.filePath!=null? DecorationImage(image: FileImage(File(model.imageModel!.filePath!,),),opacity: 0.3, alignment: Alignment.centerRight, fit: BoxFit.fill,):null,
              color: model.type=='source'?forthColor.withOpacity(0.5):thirdColor,
              //backgroundBlendMode: BlendMode.darken,
              borderRadius: const BorderRadius.only(topLeft:Radius.circular(12),topRight:Radius.circular(12),bottomLeft: Radius.circular(12) ),
            ),
            padding: const EdgeInsets.all(5),
            child: Stack(
              alignment: Alignment.center,
              children: [
                model.imageModel?.imageNetworkPath!=null?Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child:model.imageModel!.isLoading?null:Image.network(
                        '${model.imageModel?.imageNetworkPath}',
                        width: width*0.65,
                        alignment: Alignment.centerRight,
                        height: height*0.3,
                        fit: BoxFit.fill, // Or BoxFit.contain or BoxFit.cover depending on your needs
                      ),
                    ),
                    Align(
                        alignment: model.type=='source'?Alignment.bottomRight:Alignment.bottomLeft,
                        child: Text('${model.messageDate?.hour}:${model.messageDate?.minute} ${model.messageDate!.hour>12?'PM':'AM'}')),
                  ],
                )
                    :const SizedBox(),
                model.imageModel!.isLoading?const CircularProgressIndicator(color: Colors.white,):const SizedBox(),

              ],
            ),
          ),
        ),
      ),
    );
  }
}