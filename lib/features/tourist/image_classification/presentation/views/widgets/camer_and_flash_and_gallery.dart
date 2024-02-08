import 'package:flutter/material.dart';
import 'package:prepare_project/features/tourist/image_classification/presentation/manager/image_classification_cubit.dart';

class CameraFlashGallery extends StatelessWidget {
  const CameraFlashGallery({
    super.key,
    required this.height,
    required this.width,
    required this.cubit,
  });

  final double height;
  final double width;
  final ImageClassificationCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top:height*0.48,
        child:
        SizedBox(
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  padding: const EdgeInsets.only(left: 20),
                  onPressed: (){
                    cubit.changeFlashModel();
                  }, icon:Icon(cubit.getFlashIcon(cubit.currentFlashMode),color: Colors.white,size: 40,)),
              GestureDetector(
                onTap: ()async {
                  await cubit.takePicture();
                },
                child: Container(
                    padding:const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white, // Adjust border color
                        width: 3, // Adjust border width
                      ),
                    ),
                    child: CircleAvatar(radius:height*0.045,backgroundColor: Colors.white,)),),
              IconButton(
                  tooltip: 'Gallery',
                  onPressed: (){
                    cubit.getImageFromGallery();
                  },
                  icon:const Icon(Icons.photo_album_rounded,size: 40,color: Colors.white,))
            ],
          ),
        )
    );
  }
}