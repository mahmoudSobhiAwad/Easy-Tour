import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/features/tourist/chat_bot/presentation/views/widgets/bot_circle_avatar.dart';
class SendMessageFormField extends StatelessWidget {
  const SendMessageFormField({
    super.key,
    required this.width,
    required this.enableSend,
    required this.controller,
    required this.messageController,

    required this.checkExistOfText,
    required this.addToMessageModel,
  });

  final double width;
  final ScrollController controller;
  final TextEditingController messageController;
  final void Function()checkExistOfText;
  final void Function()addToMessageModel;
  final bool enableSend;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.only(left: 12.0,right: 12,top: 12,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: width*0.8,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 20,
                  offset: const Offset(5, 4),
                ),
              ],
            ),
            child: CustomTextFormField(
              onFiledSubmitted: (String?value){
                if(value!.isNotEmpty&&value.trim()!=''){
                  addToMessageModel();
                }
              },
              //autoFocus: true,
              maxLines: 3,
              controller: messageController,
              filled: true,
              fillColor: Colors.white,
              label: 'Send Message...',
              enableOutLine: false,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: 25,
              onChanged: (String message)
              {
                checkExistOfText();
              },

            ),
          ),
          GestureDetector(
            onTap: ()async{
              addToMessageModel();
              controller.animateTo(
                0,
                duration: const Duration(microseconds: 20),
                curve: Curves.fastOutSlowIn,
              );
            },
            child:BotCircle(height: 50, blurRadius: 20, icon: Icon(Icons.send_rounded,color:enableSend?basicColor:secondaryColor,),xOffset: 5,),
          )
        ],
      ),
    );
  }
}