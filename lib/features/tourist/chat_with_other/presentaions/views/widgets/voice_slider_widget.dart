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
            padding:const EdgeInsets.all(5),
            child: SizedBox(
              width: width*0.62,
              child: Row(
                children: [
                  recordModel.isLoading?const CircularProgressIndicator(color: Colors.white,):recordModel.isPlaying?
                  IconButton(onPressed: (){
                    cubit.stopPlayingVoice(index);
                  }, icon: const Icon(Icons.pause,color: whiteColor,)) :
                  IconButton(onPressed: (){
                    cubit.playVoice(index);
                  }, icon: const Icon(Icons.play_arrow,color: whiteColor,)),
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
            )),
      ),
    );
  }
}