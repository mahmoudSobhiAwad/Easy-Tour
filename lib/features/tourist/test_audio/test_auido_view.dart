import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_container.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_types.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:prepare_project/features/tourist/chat_bot/presentation/views/widgets/tourist_message_bubble.dart';
import 'package:prepare_project/features/tourist/test_audio/manager/test_audio_cubit.dart';
import 'package:prepare_project/features/tourist/test_audio/manager/test_auio_state.dart';

class AudioPageView extends StatelessWidget {
  const AudioPageView({super.key});
  @override
  Widget build(BuildContext context) {
    final double width=BasicDimension.screenWidth(context);
    final double height=BasicDimension.screenHeight(context);
    return BlocProvider(
      create: (context)=>TestAudioCubit()..getPermissionToRecord(),
      child:BlocConsumer<TestAudioCubit,TestAudioState>(
          builder: (context,state){
            var cubit=BlocProvider.of<TestAudioCubit>(context);
            return WillPopScope(
              onWillPop: ()async{
                if(cubit.enableImagePreview){
                  cubit.disableImagePreview();
                  return false;
                }
                return true;
              },
              child: Scaffold(
                body: Stack(
                  children: [
                    AudiPageBody(height: height, width: width, cubit: cubit,),
                   cubit.enableImagePreview? CustomImagePreview(imageModel:cubit.selectedImageModel,height: height, onDismissed: () {
                      cubit.disableImagePreview();
                    }, width: width,enableSendImage: cubit.enableSendImageInImagePreview,sendImage: (){
                     cubit.addToChatModel('image');
                   },):const SizedBox(),
                  ],
                ),
              ),
            );
            },
          listener: (context,state){
            if(state is FailureToHavePermissionToRecord){
              showDialog(context: context, builder: (context)=> ContainerAlertWidget(
                types: AlertTypes.failed,
                onTap: (){
                  Navigator.pop(context);
                },
                content: '${state.errMessage}',));
            }
          }) ,
    );
  }
}

class AudiPageBody extends StatelessWidget {
  const AudiPageBody({
    super.key,
    required this.height,
    required this.width,
    required this.cubit,
  });

  final double height;
  final double width;
  final TestAudioCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(bottom: 15),
          child: Column(
            children: [
              CustomGeneratedAiTripAppBar(
                extraOnBack: (){
                  cubit.dispose();
                },
                height: height, width: width,appBarTitle: 'Modern Audio Recorder',appBarStyle: CustomTextStyle.commonSignThinDark,),
              Expanded(
                child: SizedBox(
                  height: height*0.7,
                  child: ListView.builder(
                      itemCount: cubit.completeChatModel.length,
                      physics:const BouncingScrollPhysics(),
                      itemBuilder:(context,index){
                        return ChatItemWithDiffTypes(width: width, cubit: cubit,index: index, type: '${cubit.completeChatModel[index].type}', model: cubit.completeChatModel[index], height: height,);
                      }),
                ),
              ),
              SizedBox(height: height*0.05,),
              RecorderWithCustomForm(width: width, height: height,cubit: cubit,),
            ],
      ),
    ));
  }
}

class VoiceSlider extends StatelessWidget {
  const VoiceSlider({
    super.key,
    required this.width,
    required this.cubit,
    required this.index,
  });
  final int index;
  final double width;
  final TestAudioCubit cubit;

  @override
  Widget build(BuildContext context) {
    RecordModel recordModel=cubit.completeChatModel[index].recordModel!;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
            decoration: BoxDecoration(
             // color: forthColor,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomLeft,
                colors: [Color(0xff5F92D9), Color(0xffB588DC),]
            ),
              borderRadius: BorderRadius.circular(25),
            ),
            padding:const EdgeInsets.all(5),
            child: SizedBox(
              width: width*0.6,
              child: Row(
                children: [
                  recordModel.isLoading?const CircularProgressIndicator(color: Colors.white,):recordModel.isPlaying?
                  IconButton(onPressed: (){
                    cubit.stopPlayingVoice(index);
                    }, icon: const Icon(Icons.pause,color: whiteColor,)) :
                  IconButton(onPressed: (){
                      cubit.playVoice(index);
                      }, icon: const Icon(Icons.play_arrow,color: whiteColor,)),
                  Slider(
                    activeColor: whiteColor,
                    inactiveColor: thirdColor,
                    thumbColor: whiteColor,
                    min: 0,
                    value:cubit.playingIndex==index?recordModel.currentPosition!.clamp(0,recordModel.totalDuration?.toDouble()??0).toDouble():0,
                    max: recordModel.totalDuration??0,
                    onChanged: (value) async{
                      cubit.changeVoicePosition(value, index);
                    },
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

class RecorderWithCustomForm extends StatelessWidget {
  const RecorderWithCustomForm({super.key,required this.cubit,required this.height,required this.width});
  final double width;
  final double height;
  final TestAudioCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width:width*0.7,
          child:  CustomTextFormField(
            onChanged: (value){
              cubit.onChangeText(value);
            },
            controller:cubit.controller,
            suffix:PopupMenuButton<SampleItem>(
              padding: const EdgeInsets.all(10),
              splashRadius: 15,
              position: PopupMenuPosition.over,
              constraints: BoxConstraints(
                maxWidth: width*0.4,
                maxHeight: height*0.2,
              ),
              icon:const Icon(Icons.attach_file,color: entertainmentColor,) ,
              initialValue: SampleItem.camera,
              onSelected: (SampleItem item) {
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
                 PopupMenuItem<SampleItem>(
                  value: SampleItem.camera,
                  onTap: (){
                    cubit.getImageFromCamera();
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 5.0),
                    child: Column(
                      children: [
                        Icon(Icons.camera_alt_rounded),
                        Divider(color: entertainmentColor,thickness: 2,),
                      ],
                    ),
                  ),
                ),
                 PopupMenuItem<SampleItem>(
                  onTap: (){cubit.getImageFromGallery();},
                  value: SampleItem.gallery,
                  child:const Padding(
                    padding: EdgeInsets.only(bottom: 5.0),
                    child: Column(
                      children: [
                        Icon(Icons.image),
                        Divider(color: entertainmentColor,thickness: 2,),
                      ],
                    ),
                  ),
                ),
                const PopupMenuItem<SampleItem>(
                  onTap: null,
                  value: SampleItem.location,
                  child:Padding(
                    padding: EdgeInsets.only(bottom: 5.0),
                    child: Column(
                      children: [
                        Icon(Icons.location_on),
                        Divider(color: entertainmentColor,thickness: 2,),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            label: 'Enter Your message',
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
        ),
        CircleAvatar(
            radius: 30,
            backgroundColor: cubit.isRecording?thirdColor:forthColor,
            child:!cubit.isTyping?
            GestureDetector(
                onLongPress: (){
                  cubit.startRecordingVoice();
                },
                onLongPressUp: (){
                  cubit.stopRecording();
                },
                child: const Icon(Icons.mic,color: whiteColor,)) :
            GestureDetector(
                onTap: (){
                  cubit.addToChatModel('string');
                },
                child: const Icon(Icons.send,color: Colors.white,))),
      ],
    );
  }
}

enum SampleItem {camera,gallery,location }

class ChatItemWithDiffTypes extends StatelessWidget {
  const ChatItemWithDiffTypes({super.key,required this.index,required this.cubit,required this.type,required this.model,required this.width,required this.height});
final String type;
final double height;
final double width;
final CompleteChatModel model;
final TestAudioCubit cubit;
final int index;
  @override
  Widget build(BuildContext context) {
    switch(type){
      case 'string':
        return TouristBubble(message: model.normalLetters??"", isLoading: true);
      case 'image':
        return ImageMessageInChat(showImagePreview: (value){
          cubit.selectPreviewImage(value);
        }, model: model, width: width, height: height);
      case 'record':
        return VoiceSlider(width: width, cubit: cubit, index: index );
      default:
        return TouristBubble(message: model.normalLetters??"", isLoading: true,isNormalChat: true,);
    }
  }
}

class ImageMessageInChat extends StatelessWidget {
  const ImageMessageInChat({
    super.key,
    required this.showImagePreview,
    required this.model,
    required this.width,
    required this.height,
  });

  final void Function(String path)?showImagePreview;
  final CompleteChatModel model;
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
          alignment: Alignment.centerRight,
          child: Container(
            width: width*0.67,
            height: height*0.31,
            decoration: BoxDecoration(
              image:model.imageModel!.filePath!=null? DecorationImage(image: FileImage(File(model.imageModel!.filePath!,),),opacity: 0.3, alignment: Alignment.centerRight, fit: BoxFit.fill,):null,
              color: forthColor,
              backgroundBlendMode: BlendMode.darken,
              borderRadius: const BorderRadius.only(topLeft:Radius.circular(12),topRight:Radius.circular(12),bottomLeft: Radius.circular(12) ),
            ),
            padding: const EdgeInsets.all(5),
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child:model.imageModel!.isLoading?null:Image.network(
                    '${model.imageModel!.imageNetworkPath}',
                    width: width*0.65,
                    alignment: Alignment.centerRight,
                    height: height*0.3,
                    fit: BoxFit.fill, // Or BoxFit.contain or BoxFit.cover depending on your needs
                  ),
                ),
                model.imageModel!.isLoading?const CircularProgressIndicator(color: Colors.white,):const SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomImagePreview extends StatelessWidget {
  const CustomImagePreview({super.key,required this.imageModel,required this.height,required this.width,required this.onDismissed,this.enableSendImage=false, this.sendImage});
final ImageModel imageModel;
final double height;
final double width;
final void Function()onDismissed;
final void Function()?sendImage;
final bool enableSendImage;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.vertical,
      onDismissed: (direction){
        if(direction==DismissDirection.up||direction==DismissDirection.down){
          onDismissed();
        }
      },
      key: const Key('value'),
      child: Material(
        child: SizedBox(
          height: height,
          child: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom+5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(onPressed: (){
                    onDismissed();
                  }, icon: const Icon(Icons.clear)),
                  SizedBox(height: height*0.2,),
                  Center(
                      child:imageModel.imageNetworkPath!=null?
                      Image.network(imageModel.imageNetworkPath!,fit: BoxFit.fill,height:height*0.4,width: double.infinity,) :
                      Image.file(File(imageModel.filePath!),fit: BoxFit.fill,height:height*0.4,width: double.infinity,)),
                  SizedBox(height: height*0.2,),
                  enableSendImage?
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width:width*0.7,
                          child:  const CustomTextFormField(
                            //controller:cubit.controller,
                            label: 'Add Description For Image',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                        ),
                        CircleAvatar(
                            radius: 30,
                            backgroundColor:forthColor,
                            child: GestureDetector(
                                onTap: sendImage,
                                child: const Icon(Icons.send,color: Colors.white,))),
                      ],
                    ),
                  ):
                  const SizedBox()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



