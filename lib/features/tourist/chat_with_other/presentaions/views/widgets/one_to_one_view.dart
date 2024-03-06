
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/managers/one_to_one/chat_one_to_one_cubit.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/managers/one_to_one/chat_one_to_one_state.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/views/widgets/chat_oto_body.dart';
class ChatTouristOneToOtherOne extends StatelessWidget {
  const ChatTouristOneToOtherOne({super.key,required this.height,required this.width});
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context)=>ChatOneToOneCubit()..connect(),
      child: BlocConsumer<ChatOneToOneCubit,ChatOneToOneStates>(builder: (context,state){
        var cubit=BlocProvider.of<ChatOneToOneCubit>(context);
        return Scaffold(
          body: ChatOneToOneBody(height: height, width: width, cubit: cubit),
        );
      }, listener: (context,state){

      }),
    );
  }
}



// STEP1:  Stream setup








