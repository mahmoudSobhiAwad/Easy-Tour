import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/features/tourist/chat_bot/presentation/views/widgets/tourist_message_bubble.dart';
import 'package:prepare_project/features/tourist/chat_with_other/data/models/recent_chat_model.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/managers/one_to_one/chat_one_to_one_cubit.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/views/widgets/image_message_widget.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/views/widgets/voice_slider_widget.dart';
import 'package:prepare_project/features/tourist/google_map/presentaion/view/google_map_view.dart';
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
                  child: Text('${model.messageDate!.hour>12?model.messageDate!.hour-12:model.messageDate?.hour}:${model.messageDate?.minute} ${model.messageDate!.hour>12?'PM':'AM'}',style: const TextStyle(

                  ),)),
            ],
          );
        }
        return Column(
          children: [
            OtherChatBubble(message: model.message??"",isLoading: model.isLoading??true, replacedMessage: '',),
            Align(
                alignment:Alignment.bottomLeft,
                child: Text('${model.messageDate!.hour>12?model.messageDate!.hour-12:model.messageDate?.hour}:${model.messageDate?.minute} ${model.messageDate!.hour>12?'PM':'AM'}',style: const TextStyle(

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
      case 'video':
        return Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Align(
            alignment:type=="source"?Alignment.centerRight:Alignment.centerLeft,
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>GoogleMapView(markers: {
                  Marker(markerId: MarkerId('markerChat',),position: model.locationMessage!)
                },)));
              },

              child: Container(
                padding: EdgeInsets.only(bottom: 5,right: 5,left: 5,top: 5),
                width: width*0.56,
                height: height*0.2,
                decoration: BoxDecoration(
                  color:type=="source"?forthColor:thirdColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network('https://th.bing.com/th/id/R.caf6ae72543eaee2599552d00704983c?rik=GatD%2bl%2fAmV0dzA&pid=ImgRaw&r=0',fit: BoxFit.fitWidth,width: width*0.52,height: height*0.15,)),
                    Row(
                      children: [
                        Icon(Icons.location_on_rounded,color: type=="source"?Colors.white:basicColor,),
                        Text('Location',style: TextStyle(color: type=="source"?Colors.white:basicColor),),
                        Spacer(),
                        Text('${model.messageDate!.hour>12?model.messageDate!.hour-12:model.messageDate?.hour}:${model.messageDate?.minute} ${model.messageDate!.hour>12?'PM':'AM'}',style: TextStyle(
                          color: type=="source"?Colors.white:basicColor,
                        ),)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      default:
        if(type=='source'){
          return TouristBubble(message: model.message??"", isLoading: model.isLoading??true,isNormalChat: true,);
        }
        return OtherChatBubble(message: model.message??"",isLoading: model.isLoading??true, replacedMessage: '',);
    }
  }
}