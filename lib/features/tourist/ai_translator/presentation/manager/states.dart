abstract class AiTranslatorState {}

class InitialAiTranslatorState extends AiTranslatorState {}

class ChangePageIndex extends AiTranslatorState {}

class SuccessInitMicState extends AiTranslatorState {}

class FailureInitMicState extends AiTranslatorState {
  final String?errMessage;
  FailureInitMicState({this.errMessage});
}

class StartListeningState extends AiTranslatorState {}

class StopListeningState extends AiTranslatorState {}

class ConvertListeningSpeechToTextState extends AiTranslatorState {}

class SwapLanguagesAiTranslatorState extends AiTranslatorState {}

class EnableVoiceToSpeakAiTranslatorState extends AiTranslatorState {}

class ChangeCountryAiTranslatorState extends AiTranslatorState {}

class LoadingSendTextToTranslate extends AiTranslatorState {}

class SuccessSendTextToTranslate extends AiTranslatorState {}

class FailureSendTextToTranslate extends AiTranslatorState {
  final String?errMessage;
  FailureSendTextToTranslate({this.errMessage});
}