import 'package:flutter/material.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/managers/one_to_one/chat_one_to_one_cubit.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/views/widgets/one_message_item_with_diff_types.dart';
class ListChatOneToOne extends StatelessWidget {
  const ListChatOneToOne({
    super.key,
    required this.cubit,
    required this.width,
    required this.height,
  });

  final ChatOneToOneCubit cubit;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:cubit.completeChatOTOModelList.isNotEmpty?
      StreamBuilder(stream: cubit.streamSocket.getResponse, builder: (BuildContext context, AsyncSnapshot snapshot){
        return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            controller: cubit.scrollController,
            reverse: true,
            itemCount: cubit.completeChatOTOModelList.length,
            itemBuilder: (context,index){
              return ChatItemWithDiffTypes(index: index, cubit: cubit, type: cubit.completeChatOTOModelList[index].type??"source", model: cubit.completeChatOTOModelList[index], width: width, height: height);
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