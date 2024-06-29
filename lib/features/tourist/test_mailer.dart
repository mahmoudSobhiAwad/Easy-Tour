import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:video_player/video_player.dart';

class VideoTest extends StatelessWidget {
  const VideoTest({super.key});

  @override
  Widget build(BuildContext context) {
    final double width=BasicDimension.screenWidth(context);
    final double height=BasicDimension.screenHeight(context);
    return  BlocProvider(
      create: (context)=>VideoCubit(),
      child:BlocConsumer<VideoCubit,VideoStates>(
          builder: (context,state){
            var cubit=BlocProvider.of<VideoCubit>(context);
           return Scaffold(
              body: SafeArea(
                child: Column(
                  children: [
                    CustomGeneratedAiTripAppBar(height: height, width: width,appBarTitle: 'Video Test',),
                    SizedBox(height: height*0.025,),
                    SizedBox(
                        width: width,
                        height: height*0.5,
                        child:cubit.isInstalled? ClipRRect(
                            borderRadius:BorderRadius.circular(12) ,
                            child: Chewie(controller: cubit.chewieController,)):SizedBox()),
                    SizedBox(height: height*0.025,),
                    Text('Pick Option '),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(onPressed: (){
                          cubit.getVideo(ImageSource.gallery);
                        }, icon: Icon(Icons.image)),
                        IconButton(onPressed: (){
                          cubit.getVideo(ImageSource.camera);
                        }, icon: Icon(Icons.ondemand_video)),
                      ],
                    ),
                    SizedBox(height: height*0.025,),
                  ],
                ),
              ),
            );
          },
          listener: (context,state){}) ,);
  }
}
abstract class VideoStates {}
class InitialVideoState extends VideoStates {}
class InitVideoState extends VideoStates {}
class GetVideoToShow extends VideoStates {}

class VideoCubit extends Cubit<VideoStates>{
  VideoCubit():super(InitialVideoState());
  late ChewieController chewieController;
  late VideoPlayerController videoPlayerController=VideoPlayerController.networkUrl(Uri.parse('https://www.pornhub.com/embed/6632ff5d189be'));
  ImagePicker imagePicker=ImagePicker();
  String filePath='';
  bool isInstalled=false;
  void initVideo()async{
    chewieController.dispose();
    await videoPlayerController.initialize();
    chewieController=ChewieController(videoPlayerController: videoPlayerController,autoPlay: false,);
    isInstalled=true;
    emit(InitVideoState());
  }
  void getVideo(ImageSource source)async{
    imagePicker.pickVideo(source: source).then((value){
      if(value!=null){
        filePath=value.path;
        emit(GetVideoToShow());
        videoPlayerController=VideoPlayerController.file(File(filePath));
        initVideo();
      }
    });
  }

}
