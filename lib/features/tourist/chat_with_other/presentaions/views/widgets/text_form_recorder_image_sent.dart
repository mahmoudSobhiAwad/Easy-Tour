import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/managers/one_to_one/chat_one_to_one_cubit.dart';
class RecorderWithImagePickerWithCustomForm extends StatelessWidget {
  const RecorderWithImagePickerWithCustomForm({super.key,required this.cubit,required this.height,required this.width});
  final double width;
  final double height;
  final ChatOneToOneCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,bottom: 8,top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width:width*0.75,
            child:  CustomTextFormField(
              onChanged: (value){
                cubit.checkExistOfText(value);
              },
              controller:cubit.messageController,
              suffix:PopupMenuButton<SampleItem>(
                padding: const EdgeInsets.all(10),
                splashRadius: 15,
                position: PopupMenuPosition.over,
                constraints: BoxConstraints(
                  maxWidth: width*0.4,
                  maxHeight: height*0.2,
                ),
                icon:const Icon(Icons.attach_file,color: entertainmentColor,) ,
                initialValue: SampleItem.camera,
                onSelected: (SampleItem item) {
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
                  PopupMenuItem<SampleItem>(
                    value: SampleItem.camera,
                    onTap: (){
                      cubit.getImageFromCamera();
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: Column(
                        children: [
                          Icon(Icons.camera_alt_rounded),
                          Divider(color: entertainmentColor,thickness: 2,),
                        ],
                      ),
                    ),
                  ),
                  PopupMenuItem<SampleItem>(
                    onTap: (){cubit.getImageFromGallery();},
                    value: SampleItem.gallery,
                    child:const Padding(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: Column(
                        children: [
                          Icon(Icons.image),
                          Divider(color: entertainmentColor,thickness: 2,),
                        ],
                      ),
                    ),
                  ),
                  const PopupMenuItem<SampleItem>(
                    onTap: null,
                    value: SampleItem.location,
                    child:Padding(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: Column(
                        children: [
                          Icon(Icons.location_on),
                          Divider(color: entertainmentColor,thickness: 2,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              label: 'Enter Your message',
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
          ),
          CircleAvatar(
              radius: 30,
              backgroundColor: cubit.isRecording?thirdColor:forthColor,
              child:cubit.enableSend?
              GestureDetector(
                  onTap: (){
                    cubit.addToChatModel('text');
                  },
                  child: const Icon(Icons.send,color: Colors.white,shadows: [
                  ],)):
              GestureDetector(
                  onLongPress: (){
                    cubit.startRecordingVoice();
                  },
                  onLongPressUp: (){
                    cubit.stopRecording();
                  },
                  child: const Icon(Icons.mic,color: whiteColor,shadows: [
                    Shadow(color: basicColor)
                  ],)),

          ),
        ],
      ),
    );
  }
}
enum SampleItem {camera,gallery,location }