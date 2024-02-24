import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/views/widgets/app_bar_with_search.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/views/widgets/chat_with_other_list.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/views/widgets/other_pic_with_name.dart';
class TouristChatWithOtherView extends StatelessWidget {
  const TouristChatWithOtherView({super.key});

  @override
  Widget build(BuildContext context) {
    double width=BasicDimension.screenWidth(context);
    double height=BasicDimension.screenHeight(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(top:height*0.03,bottom: MediaQuery.of(context).viewInsets.bottom,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            AppBarWithSearchWidget(height: height),
            OtherPeoplePicWithName(height: height, width: width),
            ChatWithOtherList(width: width, height: height),
          ],
        ),
      ),
    );
  }
}







