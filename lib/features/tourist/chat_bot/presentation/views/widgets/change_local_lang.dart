import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/features/tourist/chat_bot/presentation/manager/chat_bot_cubit.dart';
class ChangeLocalLanguage extends StatelessWidget {
  const ChangeLocalLanguage({
    super.key,
    required this.width,
    required this.height,
    required this.cubit,
  });

  final double width;
  final double height;
  final ChatBotCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.only(bottom:MediaQuery.viewInsetsOf(context).bottom,right: 20,left: 20),
      child: Container(
        width: width,
        height: height*0.38,
        decoration: BoxDecoration(
          color: thirdColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: entertainmentColor,width: 1),),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(onPressed: (){
                  cubit.openOrCloseChangeWidget(false);
                }, icon:const Icon(Icons.close)),
              ),
              SizedBox(
                width:width*0.6,
                child:  CustomTextFormField(
                  maxLines: 1,
                  controller: cubit.langController,
                  onChanged: (value){
                    cubit.searchForLocalId(value);
                  },
                  suffix: RotatedBox(
                    quarterTurns:cubit.showListLang?-1:1,
                    child: IconButton(onPressed:(){
                      cubit.changeShowListOfLang();
                    },icon:const Icon(Icons.arrow_forward_ios_outlined)),),
                ),
              ),
              cubit.showListLang?
              Container(
                height: height*0.2,
                width: width*0.6,
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child:SingleChildScrollView(
                  child: Column(
                    children: [
                      ...List.generate(cubit.searchedList.length, (index) => TextButton(onPressed: (){
                        cubit.setLocalId(cubit.searchedList[index]);
                      },child:Text(cubit.searchedList[index].name,textAlign: TextAlign.center,))),
                    ],
                  ),
                ),
              ) :
              const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
