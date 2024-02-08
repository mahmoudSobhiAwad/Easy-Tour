import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/features/tourist/chat_bot/data/model/chat_bot_model.dart';
import 'package:prepare_project/features/tourist/chat_bot/presentation/manager/chat_bot_states.dart';

import '../../data/repo/chat_bot_repo.dart';

class ChatBotCubit extends Cubit<ChatBotState>{
  ChatBotCubit({required this.chatBotRepo}):super(InitialChatBotState());
  final ChatBotRepo chatBotRepo;
  final TextEditingController messageController=TextEditingController();
  final ScrollController scrollController=ScrollController();
  String? requestMessage;
  bool enableSend=false;
  List<ChatBotModel>messages=[];
  void getFromBot(String response){
    ChatBotModel model=ChatBotModel(message: '');
    response='$response<bot>';
    model.message=response;
    model.messageDateTime=DateTime.now();
    Future.delayed(const Duration(seconds: 2),(){
      messages.add(model);
      emit(AddedToListMessagesChatBotState());
      sortMessages();
    });
  }
  Future<void> sendQuestion()async{
    if(messageController.text.isNotEmpty)
    {
      addToMessageModel();
      emit(LoadingSendRequestChatBotState());
      var result=await chatBotRepo.sendRequest(data: ChatBotModel(message:requestMessage).toJson());
      messages.first.sent=true;
      return result.fold(
              (failure) {
            emit(FailureSendRequestChatBotState(errMessage: failure.errMessage));
          },
              (response) {

            emit(SuccessSendRequestChatBotState());
            getFromBot(response.message??"");
          }
      );
    }
}
   void addToMessageModel(){
     ChatBotModel model=ChatBotModel(message: '');
     model.message=messageController.text;
     model.messageDateTime=DateTime.now();
     requestMessage=messageController.text;
     messageController.clear();
     messages.add(model);
     emit(AddedToListMessagesChatBotState());
     sortMessages();
   }
   void sortMessages(){
     messages.sort((a, b) => b.messageDateTime!.compareTo(a.messageDateTime!));
   }
   void deleteChat(){
    messages.clear();
    emit(DeleteChatBotMessagesState());
   }
   void checkExistOfText(){
    if(messageController.text.trim()!=""){
      enableSend=true;
    }
    else{
      enableSend=false;
    }
    emit(EnableSendRequestState());
   }
}