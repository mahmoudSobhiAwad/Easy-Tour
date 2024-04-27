import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/features/tourist/chat_with_other/data/repos/chat_oto/chat_oto_repo_imp.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/managers/one_to_one/chat_one_to_one_cubit.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/managers/one_to_one/chat_one_to_one_state.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/views/widgets/chat_oto_body.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/views/widgets/custom_image_preview.dart';
class ChatTouristOneToOtherOne extends StatelessWidget {
  const ChatTouristOneToOtherOne({super.key,required this.height,required this.width,this.chatId, this.status,required this.profileUrl, this.name,this.destEmail});
  final double height;
  final double width;
  final String?chatId;
  final String?profileUrl;
  final String?name;
  final String?status;
  final String?destEmail;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context)=>ChatOneToOneCubit(chatID:chatId,targetEmail: destEmail,chatOTORepoImp: getIt.get<ChatOTORepoImp>())..getAllChatOTO(chatId)..connectToServer()..getPermissionToRecord(),
      child: BlocConsumer<ChatOneToOneCubit,ChatOneToOneStates>(builder: (context,state){
        var cubit=BlocProvider.of<ChatOneToOneCubit>(context);
        return Scaffold(
          body: WillPopScope(
              onWillPop: ()async{
                if(cubit.enableImagePreview){
                  cubit.disableImagePreview();
                  return false;
                }
                return true;
              },
              child: Stack(
                children: [
                  ChatOneToOneBody(height: height, width: width, cubit: cubit, name: name,profileUrl: profileUrl,destEmail: destEmail,status: status,),
                  cubit.enableImagePreview? CustomImagePreview(imageModel:cubit.selectedImageModel,height: height, onDismissed: () {
                    cubit.disableImagePreview();
                  }, width: width,enableSendImage: cubit.enableSendImageInImagePreview,sendImage: (){
                    cubit.addToChatModel('image');
                  },):const SizedBox(),
                ],
              )),
        );
      }, listener: (context,state){

      }),
    );
  }
}









