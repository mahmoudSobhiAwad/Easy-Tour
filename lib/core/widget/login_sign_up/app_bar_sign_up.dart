import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../utilities/basics.dart';
import '../../../features/login/presentation/view/widgets/button_swap_role_signed_in.dart';

class CustomSignInUpBar extends StatelessWidget {
  const CustomSignInUpBar({
    super.key,
    this.enableSwap,
    required this.progressIndex,
    required this.backwardProgressIndex,
    required this.toggleRoleIndex,
    required this.height,
    required this.width,
    required this.changeRole,
  });

  final int?progressIndex;
  final bool?enableSwap;
  final void Function() backwardProgressIndex;
  final void Function(int index) changeRole;
  final int?toggleRoleIndex;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:height*0.05,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           IconButton(
               padding: EdgeInsets.zero,
              onPressed: (){
                 if(toggleRoleIndex==0){
                   context.pop();
                 }
                 else{
                progressIndex==0?context.pop():backwardProgressIndex();}
              },
              icon:const Icon(Icons.arrow_back_ios_new,color:basicColor,size: 30,)),
          const Expanded(child: SizedBox(width: 5,)),
          SwapButtonRole(enableSwap: enableSwap??true,toggleRoleIndex: toggleRoleIndex,height: height,width: width, changToggle: (int index) {
            changeRole(index);
          },),
          const Expanded(child: SizedBox(width: 5,)),
          const Expanded(child: SizedBox(width: 5,)),
        ],
      ),
    );
  }
}