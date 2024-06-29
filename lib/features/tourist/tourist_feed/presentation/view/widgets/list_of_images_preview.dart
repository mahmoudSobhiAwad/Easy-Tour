import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:prepare_project/features/tourist/tourist_feed/data/model/post_model.dart';
class ListOfImagesPreview extends StatelessWidget {
  const ListOfImagesPreview({super.key,required this.imagesLinks,required this.height,required this.width,this.initPage=0,this.changePage,required this.chewieController});
  final List<MediaPathWithType>imagesLinks;
  final double height;
  final double width;
  final int initPage;
  final Function(int)?changePage;
  final ChewieController chewieController;
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: const Icon(Icons.close,color: Colors.white,)),
          SizedBox(
            height: height*0.8,
            child: PageView.builder(
                itemCount: imagesLinks.length,
                onPageChanged: changePage,
                itemBuilder: (context,index){
                  return InteractiveViewer(
                    child: Center(
                      child: imagesLinks[index].type==MediaType.image?
                      Image.file(File(imagesLinks[index].path),
                        height: height*0.7,fit: BoxFit.fitWidth,width: width,
                        filterQuality: FilterQuality.high,):
                      SizedBox(
                          width: width,
                          height: height*0.5,
                          child:ClipRRect(
                            borderRadius:BorderRadius.circular(12) ,
                            child: Chewie(controller: chewieController,),
                          )
                      ),

                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}