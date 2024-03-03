import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';

class AddIncOrExcModelBottomSheet extends StatelessWidget {
  const AddIncOrExcModelBottomSheet({
    super.key,
    required this.height,
    required this.title,
    required this.icon,
    required this.iconColor,
    this.controller,
    required this.width,
    this.addIncOrExc,
  });

  final double height;
  final String title;
  final IconData icon;
  final Color iconColor;
  final TextEditingController? controller;
  final double width;
  final void Function()? addIncOrExc;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder:(context){
              return SingleChildScrollView(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  padding:const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: thirdColor,
                    borderRadius: commonBorderRadius(),
                    boxShadow: [buildBoxShadow()],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                          alignment:Alignment.topRight,
                          onPressed: (){
                            Navigator.pop(context);
                          }, icon: const Icon(Icons.close,)),
                      Row(
                        children: [
                          Text(title),
                          const SizedBox(width: 10,),
                          Icon(icon,color:iconColor),
                        ],
                      ),
                      CustomTextFormField(controller: controller,maxLines: 2,),
                      const SizedBox(height: 20,),
                      Center(child: CustomLoginButton(label: 'Add',altWidth: width*0.35,onTap: addIncOrExc,)),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: const CircleAvatar(backgroundColor: basicColor,radius: 20,child: Center(child: Icon(Icons.add,color: Colors.white,)),));
  }
}