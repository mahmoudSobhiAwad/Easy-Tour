import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/managers/one_to_one/chat_one_to_one_cubit.dart';
import 'package:prepare_project/features/tourist/google_map/presentaion/view/google_map_view.dart';
class RecorderWithImagePickerWithCustomForm extends StatefulWidget {
  const RecorderWithImagePickerWithCustomForm({super.key,required this.cubit,required this.height,required this.width});
  final double width;
  final double height;
  final ChatOneToOneCubit cubit;

  @override
  State<RecorderWithImagePickerWithCustomForm> createState() => _RecorderWithImagePickerWithCustomFormState();
}

class _RecorderWithImagePickerWithCustomFormState extends State<RecorderWithImagePickerWithCustomForm> with SingleTickerProviderStateMixin{
  @override
  void initState() {
    super.initState();
    widget.cubit.animationController= AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300), // Adjust animation duration as needed
    );
    widget.cubit.scaleAnimation = Tween<double>(begin: 1.0, end: 1.2) // Scale animation
        .animate(widget.cubit.animationController);
  }
  @override
  void dispose() {
    widget.cubit.animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,bottom: 8,top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width:widget.width*0.75,
            child: widget.cubit.timerOn?Container(
              decoration: BoxDecoration(
                color: thirdColor,
                borderRadius: commonBorderRadius(),
              ),
              padding:const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
              child: Text('${widget.cubit.minutes}:${widget.cubit.seconds.toString().padLeft(2, '0')}'),
            ):CustomTextFormField(
              onChanged: (value){
                widget.cubit.checkExistOfText(value);
              },
              controller:widget.cubit.messageController,
              suffix:PopupMenuButton<SampleItem>(
                padding: const EdgeInsets.all(10),
                splashRadius: 15,
                position: PopupMenuPosition.over,
                constraints: BoxConstraints(
                  maxWidth: widget.width*0.4,
                  maxHeight: widget.height*0.2,
                ),
                icon:const Icon(Icons.attach_file,color: entertainmentColor,) ,
                initialValue: SampleItem.camera,
                onSelected: (SampleItem item) {
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
                  PopupMenuItem<SampleItem>(
                    value: SampleItem.camera,
                    onTap: (){
                      print(widget.cubit.requestLatLng);
                      //widget.cubit.getImageFromCamera();
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
                    onTap: (){widget.cubit.getImageFromGallery();},
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
                   PopupMenuItem<SampleItem>(
                    onTap: ()async{
                      await Navigator.push(context, MaterialPageRoute(builder: (context)=>GoogleMapView(requestLat: widget.cubit.requestLatLng,))).then((value){
                       widget.cubit.requestLatLng=value;
                        widget.cubit.addToChatModel("video");
                      });
                    },
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
          ScaleTransition(
            scale: widget.cubit.scaleAnimation!,
            child: CircleAvatar(
                radius: 30,
                backgroundColor: widget.cubit.isRecording?thirdColor:forthColor,
                child:widget.cubit.enableSend?
                GestureDetector(
                    onTap: (){
                      widget.cubit.addToChatModel('text');
                    },
                    child: const Icon(Icons.send,color: Colors.white,shadows: [
                    ],)):
                GestureDetector(
                    onLongPress: (){
                      widget.cubit.startRecordingVoice();
                    },
                    onLongPressUp: (){
                      widget.cubit.stopRecording();
                    },
                    child: const Icon(Icons.mic,color: whiteColor,shadows: [
                      Shadow(color: basicColor)
                    ],)),

            ),
          ),
        ],
      ),
    );
  }
}
enum SampleItem {camera,gallery,location }