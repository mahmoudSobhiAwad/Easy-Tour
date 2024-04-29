import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart'as firebase_core;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/core/utilities/function/record_config.dart';
import 'package:prepare_project/core/utilities/function/set_app_state.dart';
import 'package:prepare_project/features/tourist/chat_with_other/data/models/one_to_one_chat_model.dart';
import 'package:prepare_project/features/tourist/chat_with_other/data/models/recent_chat_model.dart';
import 'package:prepare_project/features/tourist/chat_with_other/data/models/stream_socket.dart';
import 'package:prepare_project/features/tourist/chat_with_other/data/repos/chat_oto/chat_oto_repo_imp.dart';
import 'package:record/record.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/managers/one_to_one/chat_one_to_one_state.dart';
import 'package:socket_io_client/socket_io_client.dart';
class ChatOneToOneCubit extends Cubit<ChatOneToOneStates>{
  ChatOneToOneCubit({required this.chatOTORepoImp,this.chatID,required this.targetEmail}):super(InitialChatOneToOneState());
  final TextEditingController messageController=TextEditingController();
  final ScrollController scrollController=ScrollController();
  final AudioPlayer audioPlayer = AudioPlayer();
  final AudioRecorder recorder = AudioRecorder();
  final storageRef = FirebaseStorage.instance.ref('chat');
  bool isRecording=false;
  bool allowedToRecord=false;
  int playingIndex=0;
  final ImagePicker picker=ImagePicker();
  String? voicePath;
  String? imagePath;
  ImageModel selectedImageModel=ImageModel();
  bool enableImagePreview=false;
  bool enableSendImageInImagePreview=false;
  final ChatOTORepoImp chatOTORepoImp;
  bool enableSend=false;
  bool loadingGetChat=false;
  final String?chatID;
  String?targetEmail;
  String?targetProfile;
  StreamSocket streamSocket =StreamSocket();
  List<CompleteChatOTOModel>completeChatOTOModelList=[];
  late io.Socket socket;
  final String sourceEmail=SetAppState.prefs?.getString('email')??"";
  void sortMessages(){
    completeChatOTOModelList.sort((a, b) => b.messageDate!.compareTo(a.messageDate!));
  }
  void checkExistOfText(String value){
    if(value.trim()!=""){
      enableSend=true;
    }
    else{
      enableSend=false;
    }
    emit(EnableSendMessageInOTOState());
  }
  Future<void> sendMessage(String type,String content)async{
    emit(LoadingSendMessageToOtherState());
    var result=await chatOTORepoImp.sendMessageToOther(SendOTOMessageModel(desID: targetEmail, contentMessage: content,type:type).toJson());
    result.fold(
            (failure){
              emit(FailureSendMessageToOtherState(errMessage: failure.errMessage));
            },
            (successSent) {
              emit(SuccessSendMessageToOtherState());
            }
    );
    emit(SuccessAddToMessageOTOState());
  }
  void getFromOther(String response,String type) {
    CompleteChatOTOModel model;
    if(type=='image'){
      model=CompleteChatOTOModel(imageModel: ImageModel(imageNetworkPath: response,isLoading: false),type:'destination',messageDate: DateTime.now(),messageType:type);
    }
    else if(type=='voice'){
      model=CompleteChatOTOModel(recordModel: RecordModel(recordPath: response,isLoading: false),type:'destination',messageDate: DateTime.now(),messageType:type);
    }
    else{
      model=CompleteChatOTOModel(message: response,type:'destination',messageDate: DateTime.now(),messageType:type);
    }
    completeChatOTOModelList.add(model);
    emit(SuccessAddToMessageOTOState());
    sortMessages();
  }
  void connectToServer(){
    socket = io.io(baseUrl,
        OptionBuilder()
            .setTransports(['websocket'])// for Flutter or Dart VM
            .disableAutoConnect()  // disable auto-connection
            .setExtraHeaders({'email': sourceEmail}) // optional
            .build()
    );
    socket.connect();
    socket.onConnect((data) {
      log('Socking is ON');
    });
    socket.on("receiveMessage", (data)
    {
      log('receiving message is ON');
      addResponse(data);

    });
    socket.onDisconnect((_) => log('Disconnect'));
  }
  void addResponse(data){
    streamSocket.addResponse;
    if(data!=null)
    {
      String type=sourceEmail==data['from']?'source':'destination';
      if(type=='source'){
        completeChatOTOModelList.first.isLoading=false;
      }
      else{
        getFromOther(data['message'],data['type']);
      }
    }
    else {
      emit(FailureAddToMessageOTOState());
    }
  }
  void getAllChatOTO(String?chatId)async{
    if(chatId!=null){
      loadingGetChat=true;
      emit(LoadingGetAllChatOTOState());
      var result=await chatOTORepoImp.getAllChatOTO(chatId);
      result.fold(
              (failure) {
            loadingGetChat=false;
            emit(FailureGetAllChatOTOState(errMessage:failure.errMessage));
          },
              (otoModel){
            completeChatOTOModelList.addAll(otoModel.messagesList!.toList());
            sortMessages();
            getDestinationData(pOne:otoModel.personOne ,pTwo: otoModel.personTwo);
            emit(SuccessGetAllChatOTOState());
            loadingGetChat=false;
          }
      );
    }
  }
  void disableImagePreview({bool?enableSend}){
    enableImagePreview=false;
    emit(DisableImagePreviewState());
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
  void getImageFromGallery()async{
    imagePath=await imageFromGallery();
    if(imagePath!=null){
      selectPreviewImage(imagePath!,enableSend: true);
    }
  }
  void getImageFromCamera()async{
    imagePath=await imageFromCamera();
    if(imagePath!=null){
      selectPreviewImage(imagePath!,enableSend: true);
    }
  }
  Future<void> startRecordingVoice() async {
    if(allowedToRecord){
      final directory = await getApplicationDocumentsDirectory();
      String fileName = 'recording_${DateTime.now().millisecondsSinceEpoch}.m4a';
      voicePath = '${directory.path}/$fileName';
      await recorder.start(config, path: voicePath!);
      isRecording=true;
      emit(RecordingStartedState());
    }
  }
  Future<void> stopRecording() async {
    isRecording=false;
    await recorder.stop();
    emit(RecordingStoppedState());
     addToChatModel('voice');
  }
  Future<void>playVoice(int index)async{
    RecordModel? model=completeChatOTOModelList[index].recordModel;
    if (model?.recordPath != null) {
      model?.isPlaying=true;
      emit(UpdateVoiceButtonShape());
      await audioPlayer.setUrl(model!.recordPath!,initialPosition: Duration(seconds:model.currentPosition!.toInt()));
      model.totalDuration=audioPlayer.duration?.inMilliseconds.toDouble();
      await audioPlayer.play();
      audioPlayer.positionStream.listen((position) {
        model.currentPosition= position.inMilliseconds.toDouble();
        emit(UpdateCurrentPositionOfVoice());
        if(model.currentPosition==model.totalDuration){
          onFinishedRecord(index);
        }
      },
      );
    }
  }
  void onFinishedRecord(int index)async{
    RecordModel? model=completeChatOTOModelList[index].recordModel;
    model?.isPlaying=false;
    model?.currentPosition=0.0;
    await audioPlayer.stop();
    emit(UpdateVoiceButtonShape());
  }
  Future<void>stopPlayingVoice(int index)async{
    RecordModel? model=completeChatOTOModelList[index].recordModel;
    if (model?.recordPath != null) {
      model?.isPlaying=false;
      await audioPlayer.setUrl(model!.recordPath!);
      await audioPlayer.stop();
      emit(StopPlayingVoiceState());
    }
  }
  void changeVoicePosition(double value,int index)async{
    completeChatOTOModelList[index].recordModel?.currentPosition=value;
    emit(UpdateCurrentPositionOfVoice());
  }
  void getDestinationData({required PersonInChatData? pOne, required PersonInChatData? pTwo}) {
    if(pOne?.email==sourceEmail){
      targetEmail=pTwo?.email;
      targetProfile=pTwo?.profilePic;
    }
    else{
      targetEmail=pOne?.email;
      targetProfile=pOne?.profilePic;
    }

  }
  String sendTextFun(){
    String letters=messageController.text;
    messageController.clear();
    completeChatOTOModelList.add(CompleteChatOTOModel(
      messageType: 'text',
      type: 'source',
      messageDate: DateTime.now(),
      message: letters,
    ));
    return letters;
  }
  void addImageLocallyToList(){
    completeChatOTOModelList.add(CompleteChatOTOModel(
      messageType: 'image',
      type: 'source',
      messageDate: DateTime.now(),
      imageModel: ImageModel(filePath: imagePath),
    ));
    sortMessages();
    enableImagePreview=false;
    emit(AddFileLocallySuccessState());
  }
  void addVoiceLocallyToList(){
    completeChatOTOModelList.add(CompleteChatOTOModel(
      messageType: 'voice',
      type: 'source',
      recordModel:RecordModel(recordPath: voicePath),
      messageDate: DateTime.now(),
    ));
    sortMessages();
    emit(AddFileLocallySuccessState());
  }
  void addToChatModel(String type)async{
    if(type=='text'){
      String letters=sendTextFun();
      emit(AddFileLocallySuccessState());
      sortMessages();
      await sendMessage('text', letters);
    }
    else if(type=='image') {
      if(imagePath!=null){
        addImageLocallyToList();
        var imageRef=storageRef.child('image');
        String? imageUrl;
        imageUrl=await uploadFileToFireBase(imageRef,imagePath!);
        completeChatOTOModelList.first.imageModel?.imageNetworkPath=imageUrl;
        completeChatOTOModelList.first.imageModel?.filePath=null;
        completeChatOTOModelList.first.imageModel?.isLoading=false;
        if(imageUrl!=null){
          await sendMessage('image', imageUrl);
        }
      }
    }
    else if(type=='voice') {
      if(voicePath!=null){
        var recordRef=storageRef.child('records');
        String?recordUrl= await uploadFileToFireBase(recordRef,voicePath!);
        completeChatOTOModelList.first.recordModel?.recordPath=recordUrl;
        completeChatOTOModelList.first.recordModel?.isLoading=false;
        if(recordUrl!=null){
          await sendMessage('voice', recordUrl);
        }
      }
    }
  }
  Future<String?>uploadFileToFireBase(Reference ref,String filePath)async{
    emit(UploadFileLoadingState());
    var fileName=basename(filePath);
    var imageRef=ref.child(fileName);
    File file=File(filePath);
    try {
      await imageRef.putFile(file);
      String url=await imageRef.getDownloadURL();
      emit(UploadFileSuccessState());
      return url;
    } on firebase_core.FirebaseException catch (e) {
      emit(UploadFileFailureState(errMessage: e.message.toString()));
      return null;
    }
  }
}


Future<String?>imageFromCamera()async{
  ImagePicker picker=ImagePicker();
  XFile? imageCamera=await picker.pickImage(source:ImageSource.camera);
  if(imageCamera!=null){
    return imageCamera.path;
  }
  return null;
}
Future<String?> imageFromGallery()async{
  ImagePicker picker=ImagePicker();
  XFile? imageGallery=await picker.pickImage(source:ImageSource.gallery);
  if(imageGallery!=null){
    return imageGallery.path;
  }
  return null;
}