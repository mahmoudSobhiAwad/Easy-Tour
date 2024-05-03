import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/features/tourist/chat_with_other/data/models/recent_chat_model.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/managers/one_to_one/chat_one_to_one_cubit.dart';
class VoiceSliderMessage extends StatelessWidget {
  const VoiceSliderMessage({
    super.key,
    required this.width,
    required this.cubit,
    required this.index,
    required this.model,
    required this.type,
  });
  final int index;
  final double width;
  final CompleteChatOTOModel model;
  final ChatOneToOneCubit cubit;
  final String type;
  @override
  Widget build(BuildContext context) {
    RecordModel recordModel=model.recordModel!;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment:type=='source'?Alignment.centerRight:Alignment.centerLeft,
        child: Container(
            decoration: BoxDecoration(
              color:type=='source'?forthColor:thirdColor,
              borderRadius: BorderRadius.circular(25),
            ),
            padding:const EdgeInsets.only(left: 5,right: 5),
            child: SizedBox(
              width: width*0.62,
              child: Column(
                children: [
                  Row(
                    children: [
                      recordModel.isLoading?const CircularProgressIndicator(color: Colors.white,):recordModel.isPlaying?
                      IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: (){
                        cubit.stopPlayingVoice(index);
                      }, icon: Icon(Icons.pause,color: type=='source'? whiteColor:basicColor,)) :
                      IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: (){
                        cubit.playVoice(index);
                      }, icon: Icon(Icons.play_arrow,color: type=='source'? whiteColor:basicColor,)),
                      Slider(
                        activeColor:type=='source'? whiteColor:basicColor,
                        inactiveColor:type=='source'?thirdColor:secondaryColor,
                        thumbColor:type=='source'? whiteColor:basicColor,
                        min: 0,
                        value:cubit.playingIndex==index?recordModel.currentPosition!.clamp(0,recordModel.totalDuration?.toDouble()??0).toDouble():0,
                        max: recordModel.totalDuration??0,
                        onChanged: (value) async{
                          cubit.changeVoicePosition(value, index);
                        },
                      ),
                    ],
                  ),
                  Align(
                      alignment: model.type=='source'?Alignment.bottomRight:Alignment.bottomLeft,
                      child: Text('${model.messageDate?.hour}:${model.messageDate?.minute} ${model.messageDate!.hour>12?'PM':'AM'}',style: TextStyle(
                        color: type=='source'? whiteColor:basicColor,
                      ),)),
                ],
              ),
            )),
      ),
    );
  }
}