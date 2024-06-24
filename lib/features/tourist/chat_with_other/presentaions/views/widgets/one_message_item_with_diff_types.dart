import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
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
          return Column(
            children: [
              TouristBubble(message: model.message??"", isLoading: model.isLoading??true,isNormalChat: true,),
              Align(
                  alignment:Alignment.bottomRight,
                  child: Text('${model.messageDate?.hour}:${model.messageDate?.minute} ${model.messageDate!.hour>12?'PM':'AM'}',style: const TextStyle(
                    color:basicColor,
                  ),)),
            ],
          );
        }
        return Column(
          children: [
            OtherChatBubble(message: model.message??"",isLoading: model.isLoading??true, replacedMessage: '',),
            Align(
                alignment:Alignment.bottomLeft,
                child: Text('${model.messageDate?.hour}:${model.messageDate?.minute} ${model.messageDate!.hour>12?'PM':'AM'}',style: const TextStyle(
                  color:basicColor,
                ),)),
          ],
        );
      case 'image':
        return ImageMessageInChat(showImagePreview: (value){
          cubit.selectPreviewImage(value);
        }, model: model, width: width, height: height);
      case 'voice':
        return Column(
          children: [
            VoiceSliderMessage(width: width, cubit: cubit,index:index, model: model,type: type,),
            Align(
                alignment: model.type=='source'?Alignment.bottomRight:Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5.0,right: 5,left: 5),
                  child: Text('${model.messageDate?.hour}:${model.messageDate?.minute} ${model.messageDate!.hour>12?'PM':'AM'}',style: const TextStyle(
                    color: basicColor,
                  ),),
                )),
          ],
        );
      default:
        if(type=='source'){
          return TouristBubble(message: model.message??"", isLoading: model.isLoading??true,isNormalChat: true,);
        }
        return OtherChatBubble(message: model.message??"",isLoading: model.isLoading??true, replacedMessage: '',);
    }
  }
}