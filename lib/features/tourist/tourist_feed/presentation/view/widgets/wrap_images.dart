import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prepare_project/features/tourist/tourist_feed/presentation/manager/create_post_cubit/create_post_cubit.dart';
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
        ...List.generate(cubit.imagePaths.length, (index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
                alignment: Alignment.topRight,
                children:[
                  Image.file(File(cubit.imagePaths[index]),
                    height: height*0.3,fit: BoxFit.fill,width:cubit.imagePaths.length==1?width*0.85:width*0.42,
                    filterQuality: FilterQuality.high,),
                  IconButton(onPressed: (){
                    cubit.removeSpecificImage(index);
                  }, icon:const Icon(Icons.cancel)),
                ]
            ),
          );
        }),
      ],
    );
  }
}