import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:prepare_project/features/tourist/chat_bot/data/model/chat_bot_model.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/managers/one_to_one/chat_one_to_one_state.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatOneToOneCubit extends Cubit<ChatOneToOneStates>{

  ChatOneToOneCubit():super(InitialChatOneToOneState());
  final TextEditingController messageController=TextEditingController();
  final ScrollController scrollController=ScrollController();
  bool enableSend=false;
  List<ChatBotModel>messages=[];
  late IO.Socket socket ;
  void addToMessageModel(){
    enableSend=false;
    ChatBotModel model=ChatBotModel(message: '');
    model.message=messageController.text;
    model.sent=true;
    model.messageDateTime=DateTime.now();
    messageController.clear();
    messages.add(model);
    emit(SuccessAddToMessageOTOState());
    sortMessages();
  }
  void connect(){
    socket= IO.io('http://192.168.1.10:8000',{"transports":['websocket'],"autoConnect":false,} );
    socket.connect();
    socket.emit('/test','i am mahmoud sobhi');
    socket.onConnect((data) => print('connected Success'));
  }
  void sortMessages(){
    messages.sort((a, b) => b.messageDateTime!.compareTo(a.messageDateTime!));
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
}