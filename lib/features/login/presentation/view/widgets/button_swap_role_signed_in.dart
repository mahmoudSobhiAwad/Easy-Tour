import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';

class SwapButtonRole extends StatelessWidget {
  const SwapButtonRole({super.key,required this.changToggle,this.enableSwap=true,required this.toggleRoleIndex,required this.height,required this.width});
  final bool enableSwap;
  final int? toggleRoleIndex;
  final double height;
  final double width;
  final void Function(int index) changToggle;
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: (){
            changToggle(0);
          },
          child: Container(
            padding: EdgeInsets.zero,
            height: height*0.05,
            width:width*0.25,
            decoration: BoxDecoration(
              color: toggleRoleIndex==0?basicColor:const Color(0xffFEFEFD),
              border: Border.all(color:const Color(0xffD8D0D0)),
              borderRadius: const BorderRadius.only(
                topLeft:  Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child:  Center(child: Text('Tourism',style: TextStyle(color:toggleRoleIndex==0?Colors.white:Colors.black),)),
          ),
        ),
        GestureDetector(
          onTap: (){
            changToggle(1);
          },
          child: Container(
            padding: EdgeInsets.zero,
            height: height*0.05,
            width:width*0.25,
            decoration: BoxDecoration(
              color:toggleRoleIndex==1? basicColor:const Color(0xffFEFEFD),
             border: Border.all(color:const Color(0xffD8D0D0)),
              borderRadius:const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Center(child: Text('Tour Guide',style: TextStyle(color:toggleRoleIndex==1?Colors.white:Colors.black),)),
          ),
        ),
      ],
    );
  }
}

