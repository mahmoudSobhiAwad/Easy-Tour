import 'dart:io';
import 'package:firebase_core/firebase_core.dart'as firebase_core;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:prepare_project/core/utilities/function/record_config.dart';
import 'package:prepare_project/features/tourist/test_audio/manager/test_auio_state.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
class TestAudioCubit extends Cubit<TestAudioState>{
  TestAudioCubit():super(InitialTestAudioState());
  final AudioPlayer audioPlayer = AudioPlayer();
  final AudioRecorder recorder = AudioRecorder();
  final storageRef = FirebaseStorage.instance.ref('chat');
  bool isRecording=false;
  bool isTyping=false;
  ImageModel selectedImageModel=ImageModel();
  bool enableImagePreview=false;
  bool enableSendImageInImagePreview=false;
  final TextEditingController controller=TextEditingController();
  bool allowedToRecord=false;
  List<CompleteChatModel>completeChatModel=[];
  int playingIndex=0;
  List<RecordModel>recordPaths=[];
  final ImagePicker picker=ImagePicker();
  String filePath='';
  String? imagePath;
  void dispose()async{
    await audioPlayer.dispose();
    await recorder.dispose();
  }
  void selectPreviewImage(String path,{bool enableSend=false}){
    if(enableSend){
      selectedImageModel.imageNetworkPath=null;
      selectedImageModel.filePath=path;
      enableSendImageInImagePreview=true;
    }
    else{
      selectedImageModel.imageNetworkPath=path;
      enableSendImageInImagePreview=false;
    }
    enableImagePreview=true;
    emit(EnableImagePreviewState());
  }
  void disableImagePreview({bool?enableSend}){
    enableImagePreview=false;
    emit(DisableImagePreviewState());
  }
  void onChangeText(String value){
    if(value.isEmpty){
      isTyping=false;
    }
    else{
      isTyping=true;
    }
    emit(ChangeTextEmptyOrFullState());
  }
  void addToChatModel(String type)async{
    if(type=='string'){
      String letters=controller.text;
      controller.clear();
      completeChatModel.add(CompleteChatModel(
        type: 'string',
        dateTimeMess: DateTime.now(),
        normalLetters:letters,
      ));
    }
    else if(type=='image'){
      if(imagePath!=null){
        int index=completeChatModel.length;
        completeChatModel.add(CompleteChatModel(
          type: 'image',
          dateTimeMess: DateTime.now(),
          imageModel: ImageModel(filePath: imagePath),
        ));
        enableImagePreview=false;
        emit(AddFileLocallySuccessState());
        var imageRef=storageRef.child('image');
        String? imageUrl;
        imageUrl=await uploadFileToFireBase(imageRef,imagePath!);
        completeChatModel[index].imageModel?.imageNetworkPath=imageUrl;
        completeChatModel[index].imageModel?.filePath=null;
        completeChatModel[index].imageModel?.isLoading=false;
      }
    }

    else if(type=='record'){
      if(recordPaths.last.recordPath!=null){
        int index=completeChatModel.length;
        completeChatModel.add(CompleteChatModel(
          type: 'record',
          recordModel:recordPaths.last,
          dateTimeMess: DateTime.now(),
        ));
        emit(AddFileLocallySuccessState());
        var recordRef=storageRef.child('records');
        String?recordUrl= await uploadFileToFireBase(recordRef,recordPaths.last.recordPath!);
        completeChatModel[index].recordModel?.recordPath=recordUrl;
        completeChatModel[index].recordModel?.isLoading=false;
      }
    }
    emit(AddAudioToListState());
  }
  Future<String?>uploadFileToFireBase(Reference ref,String filePath)async{
    emit(UploadImageLoadingState());
    var fileName=basename(filePath);
    var imageRef=ref.child(fileName);
    File file=File(filePath);
    try {
      await imageRef.putFile(file);
      String url=await imageRef.getDownloadURL();
      emit(UploadImageSuccessState());
      return url;
    } on firebase_core.FirebaseException catch (e) {
      emit(UploadImageFailureState(errMessage: e.message.toString()));
      return null;
    }
  }
  Future<void>getPermissionToRecord()async{
    final bool isPermissionGranted = await recorder.hasPermission();
    if (!isPermissionGranted) {
      emit(FailureToHavePermissionToRecord(errMessage:'Please Allow device to record audio'));
    }
    else{
      allowedToRecord=true;
      emit(SuccessToAllowPermissionToRecord());
    }
  }
  Future<void> startRecordingVoice() async {
    if(allowedToRecord){
      final directory = await getApplicationDocumentsDirectory();
      String fileName = 'recording_${DateTime.now().millisecondsSinceEpoch}.m4a';
      filePath = '${directory.path}/$fileName';
      await recorder.start(config, path: filePath);
      isRecording=true;
      emit(RecordingStartedState());
    }
  }
  Future<void> stopRecording() async {
    isRecording=false;
    await recorder.stop();
    emit(RecordingStoppedState());
    recordPaths.add(
        RecordModel(
          recordPath: filePath,
          totalDuration: audioPlayer.duration?.inMilliseconds.toDouble(),
        ));
    emit(AddAudioToListState());
    addToChatModel('record');
  }
  Future<void>playVoice(int index)async{
    playingIndex=index;
    if (completeChatModel[index].recordModel?.recordPath != null) {
      completeChatModel[index].recordModel?.isPlaying=true;
      emit(UpdateVoiceButtonShape());
      await audioPlayer.setUrl(completeChatModel[index].recordModel!.recordPath!,initialPosition: Duration(seconds:completeChatModel[index].recordModel!.currentPosition!.toInt()));
      completeChatModel[index].recordModel?.totalDuration=audioPlayer.duration?.inMilliseconds.toDouble();
      await audioPlayer.play();
      audioPlayer.positionStream.listen((position) {
        completeChatModel[index].recordModel?.currentPosition= position.inMilliseconds.toDouble();
        emit(UpdateCurrentPositionOfVoice());
        if(completeChatModel[index].recordModel?.currentPosition==completeChatModel[index].recordModel?.totalDuration){
          onFinishedRecord(index);
        }
      },
      );
    }
  }
  void onFinishedRecord(int index)async{
    completeChatModel[index].recordModel?.isPlaying=false;
    completeChatModel[index].recordModel?.currentPosition=0.0;
    await audioPlayer.stop();
    emit(UpdateVoiceButtonShape());
  }
  Future<void>stopPlayingVoice(int index)async{
    if (completeChatModel[index].recordModel?.recordPath != null) {
      completeChatModel[index].recordModel?.isPlaying=false;
      await audioPlayer.setUrl(completeChatModel[index].recordModel!.recordPath!);
      await audioPlayer.stop();
      emit(StopAudioState());
    }
  }

  void changeVoicePosition(double value,int index)async{
    completeChatModel[index].recordModel?.currentPosition=value;
    emit(UpdateCurrentPositionOfVoice());
  }
  Future<void> getImageFromCamera()async{
    XFile? imageCamera=await picker.pickImage(source:ImageSource.camera);
    if(imageCamera!=null){
      imagePath=imageCamera.path;
      emit(PickedImageSuccessState());
      selectPreviewImage(imagePath!,enableSend: true);
    }
  }
  Future<void> getImageFromGallery( )async{
    XFile? imageGallery=await picker.pickImage(source:ImageSource.gallery);
    if(imageGallery!=null){
      imagePath=imageGallery.path;
      emit(PickedImageSuccessState());
      selectPreviewImage(imagePath!,enableSend: true);
    }
  }
}

class RecordModel{
  String?recordPath;
  double?currentPosition;
  double?totalDuration;
  bool isPlaying;
  bool isLoading;
  RecordModel({this.currentPosition=0,this.totalDuration=0,this.recordPath,this.isPlaying=false,this.isLoading=true});
}
class VoiceNoteModel{
  String?name;
  String?path;
  DateTime?dateTime;
  bool isPlaying;

  VoiceNoteModel({this.name,this.path,this.dateTime,this.isPlaying=false});
}
class CompleteChatModel{
  String?normalLetters;
  DateTime?dateTimeMess;
  ImageModel?imageModel;
  RecordModel?recordModel;
  String?type;
  CompleteChatModel({this.recordModel,this.dateTimeMess,this.type,this.imageModel,this.normalLetters});
}
class ImageModel{
  String?filePath;
  String?description;
  String?imageNetworkPath;
  bool isLoading;
  ImageModel({this.filePath,this.imageNetworkPath,this.isLoading=true,this.description});
}