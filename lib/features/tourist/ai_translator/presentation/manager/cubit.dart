import 'dart:async';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:prepare_project/features/tourist/ai_translator/data/repos/translator_repo.dart';
import 'package:prepare_project/features/tourist/ai_translator/presentation/manager/states.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class AiTranslatorCubit extends Cubit<AiTranslatorState>{
  AiTranslatorCubit({required this.translatorRepoImp}):super(InitialAiTranslatorState());
  TextEditingController sourceController=TextEditingController();
  bool enableMic=false;
  bool enableRecording=false;
  SpeechToText speechToText=SpeechToText();
  Country? sourceCountry;
  Country? destCountry;
  String?localId;
  bool sourceTtsState=false;
  bool destTtsState=false;

  List<LocaleName>list=[];
  late LocaleName localeName;
  FlutterTts flutterTts = FlutterTts();
  String translatedText='';
  Timer?debounce;

  int pageIndex=0;
  final TranslatorRepoImp translatorRepoImp;
  void changePageIndex(int index){
    if(pageIndex==0){
      stopListening();
    }
    pageIndex=index;
    emit(ChangePageIndex());

  }

  void initSpeech() async {
    enableMic = await speechToText.initialize();
    list=await speechToText.locales();
    print(list.first.name);
    if(enableMic){
      emit(SuccessInitMicState());
    }
    else{
      emit(FailureInitMicState(errMessage: 'Cant Initialise Text To Speech'));
    }
  }

  void enableStartListening(){
    pageIndex=1;
    emit(ChangePageIndex());
    startListening();
  }

  void startListening() async {
    if(!enableMic){
      emit(FailureInitMicState(errMessage: 'You don\'t Allow The Mic Permissions'));
    }
    else{
      enableRecording=true;
      await speechToText.listen(onResult: onSpeechResult,localeId: localeName.localeId,);
      emit(StartListeningState());
    }
  }

  void stopListening() async {
    await speechToText.stop();
    emit(StopListeningState());
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    sourceController.text=result.recognizedWords;

    emit(ConvertListeningSpeechToTextState());
  }

  LocaleName getLocalId(Country value){
    localeName=list.where((element) => element.name.contains(value.name)).toList().first;
    print(localeName.localeId);
    return localeName;
  }

  void initCountry({required bool source,required Country value}){
    if(source){
      sourceCountry=value;
      getLocalId(value);
    }
    else{
      destCountry=value;
    }
    emit(ChangeCountryAiTranslatorState());
  }

  void speakLanguage(bool source)async{
    if(source){
      if(!sourceTtsState){
        emit(ChangeTextToSpeechState());
        await flutterTts.setLanguage(getLocalId(sourceCountry!).localeId.split('_').first);
        await flutterTts.speak(sourceController.text);
      }
      else{
        sourceTtsState=false;
        emit(ChangeTextToSpeechState());
        await flutterTts.stop();
      }
    }
    else{
      if(!destTtsState){
        emit(ChangeTextToSpeechState());
        await flutterTts.setLanguage(getLocalId(destCountry!).localeId.split('_').first);
        await flutterTts.speak(translatedText);
      }
      else{
        destTtsState=false;
        emit(ChangeTextToSpeechState());
        await flutterTts.stop();
      }
    }

  }

  void translateText()async{
    translatedText='';
    if(sourceController.text.isNotEmpty&&sourceController.text.trim().isNotEmpty){
      if(debounce?.isActive??false){
        debounce?.cancel();
      }
      else{
        debounce=Timer(Duration(milliseconds: 300), ()async {
          emit(LoadingSendTextToTranslate());
          print(sourceController.text);
          var result=await translatorRepoImp.sendRequest(data: {
            'source':sourceCountry?.name,
            'destination':destCountry?.name,
            'text':sourceController.text,
          });
          result.fold((failure) {
            print(failure.errMessage);
            emit(FailureSendTextToTranslate(errMessage: failure.errMessage));
          }, (response) {
            print(response);
            translatedText=response;
            emit(SuccessSendTextToTranslate());
          });
        });

      }
    }

  }

  void swapCountry(){
    Country? tempCountry=sourceCountry;
    sourceCountry=destCountry;
    destCountry=tempCountry;
    getLocalId(sourceCountry!);
    emit(SwapLanguagesAiTranslatorState());
  }

}