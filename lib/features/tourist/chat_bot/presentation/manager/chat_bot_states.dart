abstract class ChatBotState{}
class InitialChatBotState extends ChatBotState {}
class LoadingSendRequestChatBotState extends ChatBotState {}
class SuccessSendRequestChatBotState extends ChatBotState {}
class InitialChatBotMessagesState extends ChatBotState {}
class FailureSendRequestChatBotState extends ChatBotState {
  final String?errMessage;
  FailureSendRequestChatBotState({required this.errMessage});
}
class AddedToListMessagesChatBotState extends ChatBotState {}
class DeleteChatBotMessagesState extends ChatBotState {}
class EnableSendRequestState extends ChatBotState {}
class ChangePageCurrentState extends ChatBotState {}
class InitializeSpeechToTextRecognition extends ChatBotState {}
class StartListeningToVoiceState extends ChatBotState {}
class StopListeningToVoiceState extends ChatBotState {}
class ChangeVoiceToTextState extends ChatBotState {}
class ClearMessagesOfChatBotState extends ChatBotState {}