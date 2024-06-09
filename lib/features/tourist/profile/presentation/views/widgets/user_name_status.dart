import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
class UserNameAndStatus extends StatelessWidget {
  const UserNameAndStatus({
    super.key,
    required this.status,
    required this.userName
  });
final String?userName;
final String?status;
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(userName??"Name",style: CustomTextStyle.fontBold16,),
       const  SizedBox(width: 10,),
        Icon(Icons.circle,color: status=='Online'? const Color(0xff4BD37B):closeColor,size: 16,)
      ],);
  }
}