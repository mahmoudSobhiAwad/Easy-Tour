import 'package:flutter/material.dart';
import 'package:prepare_project/features/tourist/chat_bot/presentation/views/widgets/tourist_message_bubble.dart';
import 'package:prepare_project/features/tourist/chat_with_other/data/models/recent_chat_model.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/managers/one_to_one/chat_one_to_one_cubit.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/views/widgets/image_message_widget.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/views/widgets/voice_slider_widget.dart';
import '../../../../chat_bot/presentation/views/widgets/bot_message_bubble.dart';

class ChatItemWithDiffTypes extends StatelessWidget {
  const ChatItemWithDiffTypes({super.key,required this.index,required this.cubit,required this.type,required this.model,required this.width,required this.height});
  final String type;
  final double height;
  final double width;
  final CompleteChatOTOModel model;
  final ChatOneToOneCubit cubit;
  final int index;
  @override
  Widget build(BuildContext context) {
    switch(model.messageType){
      case 'text':
        if(type=='source'){
          return TouristBubble(message: model.message??"", isLoading: model.isLoading??true,isNormalChat: true,);
        }
        return OtherChatBubble(message: model.message??"",isLoading: model.isLoading??true, replacedMessage: '',);
      case 'image':
        return ImageMessageInChat(showImagePreview: (value){
          cubit.selectPreviewImage(value);
        }, model: model, width: width, height: height);
      case 'voice':
        return VoiceSliderMessage(width: width, cubit: cubit,index:index, model: model,type: type,);
      default:
        if(type=='source'){
          return TouristBubble(message: model.message??"", isLoading: model.isLoading??true,isNormalChat: true,);
        }
        return OtherChatBubble(message: model.message??"",isLoading: model.isLoading??true, replacedMessage: '',);
    }
  }
}