import 'package:flutter/material.dart';
import 'package:prepare_project/features/tourist/chat_bot/data/model/chat_bot_model.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/views/widgets/chat_bubble_oto.dart';
class ListChatOneToOne extends StatelessWidget {
  const ListChatOneToOne({
    super.key,
    required this.messages,
    required this.controller,
  });

  final List<ChatBotModel> messages;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:messages.isNotEmpty? ListView.builder(
          // shrinkWrap: true,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          cacheExtent: double.infinity, // And this one
          padding: const EdgeInsets.symmetric(horizontal: 16),
          controller: controller,
          reverse: true,
          itemCount: messages.length,
          itemBuilder: (context,index){
            return ChatBubbleOfOTO(message: messages[index].message!, index: index,replacedWord: '<##Guide##>',);
          }):
      const Center(child: Text('Lets Send Your First Message'),),
    );
  }
}