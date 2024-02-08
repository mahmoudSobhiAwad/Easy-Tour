import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key,this.title,this.onPressed});
  final String? title;
  final void Function()?onPressed;
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: MediaQuery.of(context).size.height*0.05,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: onPressed,
            icon: const Icon(Icons.arrow_back_ios_new),padding: EdgeInsets.zero,),
          // const Expanded(child: SizedBox(width: 5,)),
          Text(title??'',),
          SizedBox(width: MediaQuery.of(context).size.width*0.09,),
        ],
      ),
    );
  }
}