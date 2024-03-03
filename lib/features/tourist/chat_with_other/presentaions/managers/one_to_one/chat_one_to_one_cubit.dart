import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/core/utilities/function/set_app_state.dart';
import 'package:prepare_project/features/tourist/chat_with_other/data/models/chat_to_other_model.dart';
import 'package:prepare_project/features/tourist/chat_with_other/data/models/stream_socket.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/managers/one_to_one/chat_one_to_one_state.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatOneToOneCubit extends Cubit<ChatOneToOneStates>{

  ChatOneToOneCubit():super(InitialChatOneToOneState());
  final TextEditingController messageController=TextEditingController();
  final ScrollController scrollController=ScrollController();
  bool enableSend=false;
  StreamSocket streamSocket =StreamSocket();
  List<ChatToOtherModel>messages=[];
  String?requestMessage;
  late io.Socket socket ;
  final String sourceEmail=SetAppState.prefs?.getString('email')??"";
  final String role=SetAppState.prefs?.getString('role')??"";
  void addToMessageModel(){
    ChatToOtherModel model=ChatToOtherModel();
    enableSend=false;
    model.message=messageController.text;
    model.sent=false;
    model.dateTime=DateTime.now();
    requestMessage=messageController.text;
    messageController.clear();
    messages.add(model);
    sortMessages();
    // scrollController.animateTo(scrollController.position.maxScrollExtent,
    //     duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }
  void connect()
  {
    //http://192.168.56.1:8000--home
    socket= io.io(baseUrl,{"transports":['websocket'],"autoConnect":false,} );
    socket.connect();
    socket.emit('signing',sourceEmail);
    socket.onConnect((data) {
      debugPrint('connected Success');
      socket.on("message", (data){
        streamSocket.addResponse;
        debugPrint(data);
        debugPrint('working');
      });
    });

    socket.onDisconnect((_) => debugPrint('disconnect'));

  }
  void sortMessages(){
    messages.sort((a, b) => b.dateTime!.compareTo(a.dateTime!));
  }
  void deleteChat(){
    messages.clear();
   // emit(DeleteChatBotMessagesState());
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
    socket.on("message", (data){
      emit(LoadingAddToMessageOTOState());
      if(data!=null){
        String type=sourceEmail==data['source']?'source':'destination';
        if(type=='source'){
          messages.first.sent=true;
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
   return streamSocket.getResponse;
}
  void sendMessage(){
    addToMessageModel();
    String targetID='';
    role=='tourist'?targetID='sobhimahmoud003@gmail.com':targetID='modyelgen243@gmail.com';
    socket.emit('message',{'message':requestMessage,'source':sourceEmail,'targetId':targetID});
    emit(SuccessAddToMessageOTOState());
  }
  void getFromOther(String response){
    ChatToOtherModel model=ChatToOtherModel(message: response,type: 'destination',dateTime: DateTime.now());
    Future.delayed(const Duration(seconds: 1),()
    {
      messages.add(model);
      emit(SuccessAddToMessageOTOState());
      sortMessages();
    });
  }
}