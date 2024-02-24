import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/managers/one_to_one/chat_one_to_one_cubit.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/managers/one_to_one/chat_one_to_one_state.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/views/widgets/cusotm_app_bar_oto.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/views/widgets/list_chat_oto.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/views/widgets/send_message_form_field_oto.dart';
class ChatTouristOneToOtherOne extends StatelessWidget {
  const ChatTouristOneToOtherOne({super.key,required this.height,required this.width});
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context)=>ChatOneToOneCubit(),
      child: BlocConsumer<ChatOneToOneCubit,ChatOneToOneStates>(builder: (context,state){
        var cubit=BlocProvider.of<ChatOneToOneCubit>(context);
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: Padding(
            padding: EdgeInsets.only(top:height*0.03,bottom: 10),
            child: Column(
              children: [
                CustomChatOneToOneAppBar(height: height, width: width),
                ListChatOneToOne(messages: cubit.messages,controller: cubit.scrollController,),
                SendMessageFormField(width: width, controller: cubit.scrollController, messageController: cubit.messageController,
                  enableSend: cubit.enableSend,
                  checkExistOfText: () {
                  cubit.checkExistOfText();
                  }, addToMessageModel: () {
                  cubit.addToMessageModel();
                  },),
              ],
            ),
          ),
        );
      }, listener: (context,state){

      }),
    );
  }
}








