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
      padding:EdgeInsets.only(bottom:MediaQuery.viewInsetsOf(context).bottom),
      child: Container(
        width: width,
        height: height*0.33,
        decoration: BoxDecoration(
          border: Border.all(color: thirdColor,width: 1),),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width:width*0.6,
                child:  CustomTextFormField(
                  controller: cubit.langController,
                  onChanged: (value){
                    cubit.searchForLocalId(value);
                  },
                  suffix: RotatedBox(
                    quarterTurns:cubit.showChangeLang?-1:1,
                    child: IconButton(onPressed:(){
                      cubit.changeShowListOfLang();
                    },icon:const Icon(Icons.arrow_forward_ios_outlined)),),
                ),
              ),
              cubit.showChangeLang?
              Container(
                height: height*0.2,
                width: width*0.6,
                decoration: BoxDecoration(
                  color: thirdColor,
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
