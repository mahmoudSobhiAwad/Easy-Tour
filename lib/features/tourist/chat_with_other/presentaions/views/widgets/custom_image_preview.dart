import 'dart:io';
import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/features/tourist/chat_with_other/data/models/recent_chat_model.dart';
class CustomImagePreview extends StatelessWidget {
  const CustomImagePreview({super.key,required this.imageModel,required this.height,required this.width,required this.onDismissed,this.enableSendImage=false, this.sendImage});
  final ImageModel imageModel;
  final double height;
  final double width;
  final void Function()onDismissed;
  final void Function()?sendImage;
  final bool enableSendImage;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.vertical,
      onDismissed: (direction){
        if(direction==DismissDirection.up||direction==DismissDirection.down){
          onDismissed();
        }
      },
      key: const Key('value'),
      child: Material(
        child: SizedBox(
          height: height,
          child: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom+5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(onPressed: (){
                    onDismissed();
                  }, icon: const Icon(Icons.clear)),
                  SizedBox(height: height*0.2,),
                  Center(
                      child:imageModel.imageNetworkPath!=null?
                      InteractiveViewer(
                          maxScale: 4,
                          child: Image.network(imageModel.imageNetworkPath!,fit: BoxFit.fill,height:height*0.4,width: double.infinity,)) :
                      InteractiveViewer(
                          maxScale: 4,
                          child: Image.file(File(imageModel.filePath!),fit: BoxFit.fill,height:height*0.4,width: double.infinity,))),
                  SizedBox(height: height*0.2,),
                  enableSendImage?
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width:width*0.7,
                          child:  const CustomTextFormField(
                            //controller:cubit.controller,
                            label: 'Add Description For Image',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                        ),
                        CircleAvatar(
                            radius: 30,
                            backgroundColor:forthColor,
                            child: GestureDetector(
                                onTap: sendImage,
                                child: const Icon(Icons.send,color: Colors.white,))),
                      ],
                    ),
                  ):
                  const SizedBox()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}