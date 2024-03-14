import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/core/utilities/function/set_app_state.dart';
import 'package:prepare_project/features/tourist/chat_with_other/data/models/one_to_one_chat_model.dart';
import 'package:prepare_project/features/tourist/chat_with_other/data/models/recent_chat_model.dart';
import 'package:prepare_project/features/tourist/chat_with_other/data/models/stream_socket.dart';
import 'package:prepare_project/features/tourist/chat_with_other/data/repos/chat_oto/chat_oto_repo_imp.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/managers/one_to_one/chat_one_to_one_state.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatOneToOneCubit extends Cubit<ChatOneToOneStates>{

  ChatOneToOneCubit({required this.chatOTORepoImp,this.chatID,required this.targetEmail}):super(InitialChatOneToOneState());
  final TextEditingController messageController=TextEditingController();
  final ScrollController scrollController=ScrollController();
  final ChatOTORepoImp chatOTORepoImp;
  bool enableSend=false;
  bool loadingGetChat=false;
  final String?chatID;
  String?targetEmail;
  String?targetProfile;
  StreamSocket streamSocket =StreamSocket();
  List<OneMessageModel>messagesList=[];
  String?requestMessage;
  late io.Socket socket ;
  final String sourceEmail=SetAppState.prefs?.getString('email')??"";
  void addToMessageModel() {
    OneMessageModel model=OneMessageModel();
    enableSend=false;
    model.message=messageController.text;
    model.sent=false;
    model.messageDate=DateTime.now();
    requestMessage=messageController.text;
    messageController.clear();
    messagesList.add(model);
    sortMessages();
    // scrollController.animateTo(scrollController.position.maxScrollExtent,
    //     duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }
  void sortMessages(){
    messagesList.sort((a, b) => b.messageDate!.compareTo(a.messageDate!));
  }
  void checkExistOfText(){
    if(messageController.text.trim()!=""){
      enableSend=true;
    }
    else{
      enableSend=false;
    }
    emit(EnableSendMessageInOTOState());
  }
 Stream socketMessage(){
   socket.onConnect((data) {
     socket.on("receiveMessage", (data){
       log('receiving message is ON');
       emit(LoadingAddToMessageOTOState());
       if(data!=null)
       {
         String type=sourceEmail==data['from']?'source':'destination';
         if(type=='source'){
           messagesList.first.sent=true;
         }
         else{
           getFromOther(data['message']);
         }
          streamSocket.addResponse;
         emit(SuccessAddToMessageOTOState());
       }
       else{
         emit(FailureAddToMessageOTOState());
       }
     });
   });

   return streamSocket.getResponse;
}
  void sendMessage()async{
    addToMessageModel();
    emit(LoadingSendMessageToOtherState());
    var result=await chatOTORepoImp.sendMessageToOther(SendOTOMessageModel(desID: targetEmail, contentMessage: requestMessage).toJson());
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
  void getFromOther(String response) {
    OneMessageModel model=OneMessageModel(message: response,type:'destination',messageDate: DateTime.now());
    messagesList.add(model);
    emit(SuccessAddToMessageOTOState());
    sortMessages();
  }
  void getAllChatOTO(String?chatId)async{
    socket = io.io(baseUrl,
        OptionBuilder()
            .setTransports(['websocket'])// for Flutter or Dart VM
            .disableAutoConnect()  // disable auto-connection
            .setExtraHeaders({'email': sourceEmail}) // optional
            .build()
    );
    socket.connect();
    if(chatId==null){}
    else{
      loadingGetChat=true;
      emit(LoadingGetAllChatOTOState());
      var result=await chatOTORepoImp.getAllChatOTO(chatId);
      result.fold(
              (failure) {
                loadingGetChat=false;
                emit(FailureGetAllChatOTOState(errMessage:failure.errMessage));
              },
              (otoModel){
                messagesList.addAll(otoModel.messagesList!.toList());
                editMessagesToChat(messagesList);
                getDestinationData(pOne:otoModel.personOne ,pTwo: otoModel.personTwo);
                emit(SuccessGetAllChatOTOState());
                loadingGetChat=false;
              }
      );

    }
  }
  void editMessagesToChat(List<OneMessageModel>message){
    for (var element in message) {

      if(element.fromPerson!=sourceEmail){
        element.type='destination';
      }
    }
    sortMessages();
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
}