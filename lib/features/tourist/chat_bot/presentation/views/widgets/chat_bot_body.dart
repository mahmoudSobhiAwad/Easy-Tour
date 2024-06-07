import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/chat_bot/presentation/manager/chat_bot_cubit.dart';
import 'package:prepare_project/features/tourist/chat_bot/presentation/views/widgets/bot_circle_avatar.dart';
import 'package:prepare_project/features/tourist/chat_bot/presentation/views/widgets/change_local_lang.dart';
import 'package:prepare_project/features/tourist/chat_bot/presentation/views/widgets/menu_bar_item.dart';
import 'package:prepare_project/features/tourist/chat_bot/presentation/views/widgets/message_list_view.dart';
import 'package:prepare_project/features/tourist/chat_bot/presentation/views/widgets/text_form_send_button.dart';
class ChatBotBody extends StatelessWidget {
  const ChatBotBody({super.key,required this.cubit});
final ChatBotCubit cubit;
  @override
  Widget build(BuildContext context) {
    double width=BasicDimension.screenWidth(context);
    double height=BasicDimension.screenHeight(context);
    return  Scaffold(
      appBar: AppBar(
        surfaceTintColor: thirdColor,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: (){
              context.pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new,color: basicColor,)),
        title:const Row(
          children: [
            BotCircle(height: 40, blurRadius: 4, icon:Icon(FontAwesomeIcons.robot,color: basicColor,)),
            SizedBox(width: 10,),
            Text('Tourism-Bot',style: CustomTextStyle.commonSignDark,),
          ],
        ),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.volume_up,color: basicColor,)),
          SubmenuButton(
            menuChildren: <Widget>[
              MenuItemButton(
                onPressed: () {
                  cubit.deleteChat();
                },
                child: const MenuItemAppBarButton(text: 'Delete Chat', icon: Icon(Icons.delete_rounded,color: closeColor,)),
              ),
              MenuItemButton(
                onPressed: (){
                  showModalBottomSheet(
                    isScrollControlled: true,
                      context: context, builder:(context){
                        return ChangeLocalLanguage(width: width, height: height, cubit: cubit);
                  });
                },
                child: const MenuItemAppBarButton(text: 'Change Language', icon: Icon(Icons.language_sharp,)),
              ),
            ],
            child: const Icon(Icons.more_vert_rounded,color: basicColor,),
          ),
        ],
      ),
      backgroundColor:const Color(0xffF7F7F9),
      body: Column(
        children: [
          MessagesListView(cubit: cubit),
          TextFormAndSendMessage(width: width, cubit: cubit,),
        ],
      ),

    );
  }
}

