import 'package:flutter/material.dart';
import 'package:prepare_project/features/tourist/chat_bot/presentation/manager/chat_bot_cubit.dart';
import 'package:prepare_project/features/tourist/chat_bot/presentation/views/widgets/bot_message_bubble.dart';
import 'package:prepare_project/features/tourist/chat_bot/presentation/views/widgets/tourist_message_bubble.dart';

class MessagesListView extends StatelessWidget {
  const MessagesListView({
    super.key,
    required this.cubit,
  });

  final ChatBotCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:cubit.messages.isNotEmpty? ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          controller: cubit.scrollController,
          reverse: true,
          itemCount: cubit.messages.length,
          itemBuilder: (context,index){
            return cubit.messages[index].message!.endsWith('<bot>')?
            Column(

              children: [
                OtherChatBubble(
                  replacedMessage:'<bot>',
                  message: cubit.messages[index].message??"",
                  isLoading: index==0,
                ),
                Row(
                  children: [
                    Icon(Icons.copy_rounded),
                    Icon(Icons.volume_up_outlined),
                  ],
                )
              ],
            ):
            TouristBubble(
              message: cubit.messages[index].message??"",
              isLoading: cubit.messages[index].sent,);
          }):
      const Center(child: Text('Lets Send Your First Message'),),
    );
  }
}