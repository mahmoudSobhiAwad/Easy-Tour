import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/function/set_app_state.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/tourist/chat_bot/presentation/views/chat_bot_view.dart';


class ChatBotIntro extends StatelessWidget {
  const ChatBotIntro({super.key});
  @override
  Widget build(BuildContext context) {
    final double height =BasicDimension.screenHeight(context);
    final double width =BasicDimension.screenHeight(context);
    return  Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 20.0,right: 20,bottom: 20,top: height*0.08),
        child: Column(
          children: [
            const Text('Tourism Chat Bot',style: CustomTextStyle.homePartTitle,),
            const SizedBox(height: 20,),
            const Text('You can ask what you want about the tourism in Egypt in different Fields',style: CustomTextStyle.commonSignLight,textAlign: TextAlign.center,),
            const SizedBox(height: 20,),
            Image.asset('assets/tourist_home/Vector_Robot_3.webp',fit: BoxFit.fill,height: height*0.5,),
            const Expanded(child: SizedBox(height: 20,)),
            CustomLoginButton(altWidth: width,label: 'Start',onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const ChatBotView()));
              SetAppState.chatBotStart(start: true);
            },),
          ],
        ),
      ),
    );
  }
}