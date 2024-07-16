// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:prepare_project/features/tourist/ai_translator/data/repos/translator_repo.dart';
import 'package:prepare_project/features/tourist/ai_translator/presentation/manager/cubit.dart';
import 'package:prepare_project/features/tourist/ai_translator/presentation/manager/states.dart';
import 'package:prepare_project/features/tourist/profile/presentation/views/widgets/pick_country.dart';

class AiTranslatorView extends StatelessWidget {
  const AiTranslatorView({super.key});

  @override
  Widget build(BuildContext context) {
    
    final double height=BasicDimension.screenHeight(context);
    final double width=BasicDimension.screenWidth(context);
    return BlocProvider(
      create: (context)=>AiTranslatorCubit(translatorRepoImp: getIt.get<TranslatorRepoImp>())..initSpeech(),
      child:BlocConsumer<AiTranslatorCubit,AiTranslatorState>(
          builder: (context,state){
            var cubit=BlocProvider.of<AiTranslatorCubit>(context);
            return WillPopScope(
              onWillPop: ()async{
                if(cubit.pageIndex==1){
                  cubit.changePageIndex(0);
                  return false;
                }
                else{
                  return true;
                }

              },
              child: Scaffold(
                body: SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                    child:[
                      Column(children: [
                        CustomGeneratedAiTripAppBar(height: height, width: width,appBarTitle: 'Ai-Translator',appBarStyle: CustomTextStyle.fontBold18,),
                        SizedBox(height: height*0.025,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PickCountry(onSelect: (value){
                              cubit.initCountry(source: true, value: value);
                            }, width: width*0.38,maxLine: 2,countryName: cubit.sourceCountry?.name??"Pick Country",countryFlag: cubit.sourceCountry?.flagEmoji??"",),
                            IconButton(onPressed: (){
                              cubit.swapCountry();
                            },icon: const Icon(Icons.change_circle_rounded,),iconSize: width*0.125,),
                            PickCountry(onSelect: (value){
                              cubit.initCountry(source: false, value: value);
                            }, width: width*0.38,maxLine: 2,countryName: cubit.destCountry?.name??"Pick Country",countryFlag: cubit.destCountry?.flagEmoji??"",),
                          ],
                        ),
                        SizedBox(height: height*0.025,),
                        TranslatorWidget(width: width, height: height,sourceOrDest: true,cubit: cubit,),
                        SizedBox(height: height*0.033,),
                        TranslatorWidget(width: width, height: height,sourceOrDest: false,cubit: cubit,)
                      ],),
                      ListeningToSpeechWidget(height: height, width: width, cubit: cubit)
                    ][cubit.pageIndex]
                  ),
                ),
              ),
            );
      }, listener: (context,state){}) ,
    );
  }
}

class TranslatorWidget extends StatelessWidget {
  const TranslatorWidget({
    super.key,
    required this.width,
    required this.height,
    required this.sourceOrDest,
    required this.cubit,
  });

  final double width;
  final double height;
  final AiTranslatorCubit cubit;
  final bool sourceOrDest;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: thirdColor,width: 2),
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          SingleChildScrollView(
            child: SizedBox(
                width:width,
                height: height*0.25,
                child: sourceOrDest?CustomTextFormField(enableOutLine: true,borderColor: thirdColor,maxLines: 8,controller: cubit.sourceController,onChanged: (String?value){
                  cubit.translateText();
                },):Text(cubit.translatedText,style: CustomTextStyle.fontBold14,),
            ),
          ),
          SizedBox(
            height: height*0.05,
          ),
          SizedBox(
            width: width,
            child: const Divider(
              height: 2,
              color: secondaryColor,
              thickness: 2,
            ),
          ),
          Row(
            children: [
              sourceOrDest?Text('${cubit.sourceController.text.length}/1000'):Text('${cubit.translatedText.length}/1000'),
              Spacer(),
              IconButton(onPressed: (){
                cubit.speakLanguage(sourceOrDest);
              }, icon: Icon(Icons.volume_up_outlined)),
              sourceOrDest?IconButton(onPressed: (){
                cubit.enableStartListening();
              }, icon: Icon(Icons.mic)):IconButton(onPressed: (){
                Clipboard.setData(ClipboardData(text: '${cubit.translatedText}')).then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Copied"),duration: Duration(milliseconds: 300),backgroundColor: whatsAppColor,));
                });
              }, icon: Icon(Icons.copy_rounded)),
            ],
          )
        ],
      )
    );
  }
}
class ListeningToSpeechWidget extends StatelessWidget {
  const ListeningToSpeechWidget({super.key,required this.height,required this.width,required this.cubit});
final double height;
final double width;
final AiTranslatorCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomGeneratedAiTripAppBar(height: height, width: width,appBarTitle: 'Listening...',appBarStyle: CustomTextStyle.fontBold18,extraOnBack: (){
          cubit.changePageIndex(0);
        },backDirect: false,),
        SizedBox(height: height*0.05,),
        PickCountry(onSelect: (value){
          cubit.initCountry(source: true, value: value);
        }, width: width*0.38,maxLine: 2,countryName: cubit.sourceCountry?.name??"Pick Country",countryFlag: cubit.sourceCountry?.flagEmoji??"",),
        SizedBox(height: height*0.05,),
        SingleChildScrollView(
          child: SizedBox(
              height: height*0.3,
              child: cubit.sourceController.text.isEmpty?Text('Start Talking.....',style: CustomTextStyle.fontBold18,):Text('${cubit.sourceController.text}',style: CustomTextStyle.fontBold18,maxLines: 10,textAlign: TextAlign.center,)),
        ),
        SizedBox(height: height*0.1,),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: (){
                  cubit.startListening();
                }, icon: Icon(Icons.mic),iconSize: width*0.15,),
                IconButton(onPressed: (){
                  cubit.stopListening();
                }, icon: Icon(Icons.stop_circle,),iconSize:  width*0.2),

              ],
            ),
            SizedBox(height: height*0.025,),
            IconButton(onPressed: (){
              cubit.translateText();
              cubit.changePageIndex(0);
            }, icon: Icon(Icons.translate,),iconSize:  width*0.2),
          ],
        ),
      ],
    );
  }
}

