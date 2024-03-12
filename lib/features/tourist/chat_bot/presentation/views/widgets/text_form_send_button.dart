import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/features/tourist/chat_bot/presentation/manager/chat_bot_cubit.dart';
import 'package:prepare_project/features/tourist/chat_bot/presentation/views/widgets/bot_circle_avatar.dart';
class TextFormAndSendMessage extends StatelessWidget {
  const TextFormAndSendMessage({
    super.key,
    required this.width,
    required this.cubit,
  });

  final double width;

  final ChatBotCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0,right: 12,top: 12,bottom: MediaQuery.viewInsetsOf(context).bottom+10),
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
              minLine: 1,
              maxLines: 3,
              suffix: IconButton(onPressed: (){
                cubit.startListening();
              }, icon:Icon(cubit.speechToText.isNotListening?Icons.mic_off:Icons.mic)),
              controller: cubit.messageController,
              filled: true,
              fillColor: Colors.white,
              label: 'ask what you want....',
              enableOutLine: false,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: 25,
              onChanged: (String message)
              {
                cubit.checkExistOfText();
              },
            ),
          ),
          GestureDetector(
            onTap: ()async{
              await cubit.sendQuestion();
              cubit.scrollController.animateTo(
                0,
                duration: const Duration(microseconds: 20),
                curve: Curves.fastOutSlowIn,
              );
            },
            child:BotCircle(height: 50, blurRadius: 20, icon: Icon(Icons.send_rounded,color:cubit.enableSend?basicColor:secondaryColor,),xOffset: 5,),
          )
        ],
      ),
    );
  }
}