import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/features/tourist/tourist_feed/data/model/post_model.dart';
import 'package:prepare_project/features/tourist/tourist_feed/presentation/manager/create_post_cubit/create_post_cubit.dart';
import 'package:prepare_project/features/tourist/tourist_feed/presentation/view/widgets/list_of_images_preview.dart';
class ListOfImagesUsingWrap extends StatelessWidget {
  const ListOfImagesUsingWrap({
    super.key,
    required this.cubit,
    required this.height,
    required this.width,
  });

  final CreatePostCubit cubit;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        ...List.generate(cubit.mediaPaths.length, (index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
                alignment: Alignment.topRight,
                children:[
                  cubit.mediaPaths[index].type==MediaType.image?
                  GestureDetector(
                    onTap:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return ListOfImagesPreview(imagesLinks: cubit.mediaPaths, height: height, width: width,initPage: index,chewieController: cubit.chewieController,changePage: (int index){
                          cubit.onChangePageInPreview(index);
                        },);
                      }));
                    },
                    child: Image.file(File(cubit.mediaPaths[index].path),
                      height: height*0.3,fit: BoxFit.fill,width:cubit.mediaPaths.length==1?width*0.85:width*0.42,
                      filterQuality: FilterQuality.high,),
                  ):
                  GestureDetector(
                    onTap:()async{
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return ListOfImagesPreview(imagesLinks: cubit.mediaPaths, height: height, width: width,chewieController: cubit.chewieController,changePage: (int index){
                          cubit.onChangePageInPreview(index);
                        },);
                      }));
                    },
                    child: ColoredBox(
                      color: basicColor,
                      child: SizedBox(
                        height: height*0.3,
                        width: cubit.mediaPaths.length==1?width*0.85:width*0.42,
                        child:IconButton(onPressed: (){
                          cubit.initVideo(index);
                        },icon:Icon(Icons.play_circle_outline_sharp,color: whiteColor,size: 40,),),
                      ),
                    ),
                  ),
                  IconButton(onPressed: (){
                    cubit.removeSpecificImage(index);
                  }, icon:const CircleAvatar(
                      radius: 15,
                      backgroundColor:closeColor,
                      child: Icon(Icons.close,color: whiteColor,))),
                ]
            ),
          );
        }),
      ],
    );
  }
}
class VideoPreview extends StatelessWidget {
  const VideoPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
