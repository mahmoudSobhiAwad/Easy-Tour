import 'package:flutter/material.dart';
import 'package:prepare_project/features/tourist/chat_bot/presentation/views/widgets/bot_message_bubble.dart';
import 'package:prepare_project/features/tourist/chat_bot/presentation/views/widgets/tourist_message_bubble.dart';
class ChatBubbleOfOTO extends StatelessWidget {
  const ChatBubbleOfOTO({super.key,required this.message,required this.index,required this.replacedWord});
  final String message;
  final int index;
  final String? replacedWord;
  @override
  Widget build(BuildContext context) {
    return replacedWord=='destination'?
    OtherChatBubble(
      replacedMessage:'',
      message: message,
      isLoading:index==0,
    ):
    TouristBubble(
      isNormalChat: true,
        message:message,
        isLoading:true);
  }
}
//return ChatItemWithDiffTypes(message: messages[index].message!, index: index,replacedWord: messages[index].type, cubit: null, type: '', model: null, width: null, height: null,);
