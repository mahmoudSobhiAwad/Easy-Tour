import 'package:flutter/material.dart';
import 'package:prepare_project/features/tourist/chat_with_other/data/models/chat_to_other_model.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/views/widgets/chat_bubble_oto.dart';
class ListChatOneToOne extends StatelessWidget {
  const ListChatOneToOne({
    super.key,
    required this.messages,
    required this.controller,
    required this.stream,

  });

  final List<ChatToOtherModel> messages;
  final ScrollController controller;
final Stream stream;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:messages.isNotEmpty? StreamBuilder(stream: stream, builder: (BuildContext context, AsyncSnapshot snapshot){
        return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            controller: controller,
            reverse: true,
            itemCount: messages.length,
            itemBuilder: (context,index){
              return ChatBubbleOfOTO(message: messages[index].message!, index: index,replacedWord: messages[index].type,);
            });
      }):
      ListView(
        children: const [
          Center(child: Text('Lets Send Your First Message')),
        ],
      ),
    );
  }
}