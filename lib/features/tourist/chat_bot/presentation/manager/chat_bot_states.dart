abstract class ChatBotState{}
class InitialChatBotState extends ChatBotState {}
class LoadingSendRequestChatBotState extends ChatBotState {}
class SuccessSendRequestChatBotState extends ChatBotState {}
class FailureSendRequestChatBotState extends ChatBotState {
  final String?errMessage;
  FailureSendRequestChatBotState({required this.errMessage});
}
class AddedToListMessagesChatBotState extends ChatBotState {}
class DeleteChatBotMessagesState extends ChatBotState {}
class EnableSendRequestState extends ChatBotState {}
class ChangePageCurrentState extends ChatBotState {}
