import 'dart:io';
import 'package:flutter/material.dart';
import 'package:prepare_project/features/tourist/tourist_feed/data/model/post_model.dart';
import 'package:prepare_project/features/tourist/tourist_feed/presentation/view/widgets/wrap_images.dart';
class ListOfImagesPreview extends StatelessWidget {
  const ListOfImagesPreview({super.key,required this.imagesLinks,required this.height,required this.width,this.initPage=0,required this.mediaType});
  final List<MediaPathWithType>imagesLinks;
  final double height;
  final double width;
  final int initPage;
  final VideoType mediaType;
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
                controller: PageController(initialPage: initPage),
                itemBuilder: (context,index){
                  return InteractiveViewer(
                    child: switch(imagesLinks[index].type){
                      MediaType.image => Center(
                          child: switch(mediaType){
                            VideoType.local => Image.file(File(imagesLinks[index].path),
                              height: height*0.7,fit: BoxFit.fitWidth,width: width,
                              filterQuality: FilterQuality.high,),
                            VideoType.url => Image.network(imagesLinks[index].path,
                              height: height*0.7,fit: BoxFit.fitWidth,width: width,
                              filterQuality: FilterQuality.high,),
                          }
                      ),
                      MediaType.video => Center(
                          child: VideoPreview(type: mediaType, path: imagesLinks[index].path, width: width, height: height)
                      ),
                    }
                  );
                }),
          ),
        ],
      ),
    );
  }
}