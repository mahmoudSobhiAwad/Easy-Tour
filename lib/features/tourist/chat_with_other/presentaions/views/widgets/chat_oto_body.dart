import 'package:flutter/material.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/managers/one_to_one/chat_one_to_one_cubit.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/views/widgets/cusotm_app_bar_oto.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/views/widgets/list_chat_oto.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/views/widgets/send_message_form_field_oto.dart';
class ChatOneToOneBody extends StatelessWidget {
  const ChatOneToOneBody({
    super.key,
    required this.height,
    required this.width,
    required this.cubit,
  });

  final double height;
  final double width;
  final ChatOneToOneCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:height*0.03,bottom: 10),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomChatOneToOneAppBar(height: height, width: width),
          ListChatOneToOne(messages: cubit.messages, stream: cubit.socketMessage(),controller: cubit.scrollController,),
          SendMessageFormField(
            width: width,
            controller: cubit.scrollController,
            messageController: cubit.messageController,
            enableSend: cubit.enableSend,
            checkExistOfText: () {
              cubit.checkExistOfText();
            }, addToMessageModel: (){
              cubit.sendMessage();
            },),
        ],
      ),
    );
  }
}