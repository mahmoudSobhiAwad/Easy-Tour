import 'package:flutter/material.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/managers/one_to_one/chat_one_to_one_cubit.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/views/widgets/cusotm_app_bar_oto.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/views/widgets/list_chat_oto.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/views/widgets/text_form_recorder_image_sent.dart';
class ChatOneToOneBody extends StatelessWidget {
  const ChatOneToOneBody({
    super.key,
    required this.height,
    required this.width,
    required this.cubit,
    required this.name,
    required this.profileUrl,
    required this.destEmail,
    required this.status,
  });

  final double height;
  final double width;
  final ChatOneToOneCubit cubit;
  final String?profileUrl;
  final String?name;
  final String?status;
  final String?destEmail;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:height*0.03,bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomChatOneToOneAppBar(height: height, width: width,profileUrl:profileUrl ,name: name,status: status,email: destEmail??"",),
          ListChatOneToOne(cubit: cubit,width: width,height: height,),
          RecorderWithImagePickerWithCustomForm(cubit: cubit, height: height, width: width)
        ],
      ),
    );
  }
}