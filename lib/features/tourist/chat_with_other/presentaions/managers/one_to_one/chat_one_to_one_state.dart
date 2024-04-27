abstract class ChatOneToOneStates{}
class InitialChatOneToOneState extends ChatOneToOneStates{}
class LoadingAddToMessageOTOState extends ChatOneToOneStates{}
class SuccessAddToMessageOTOState extends ChatOneToOneStates{}
class FailureAddToMessageOTOState extends ChatOneToOneStates{}
class EnableSendMessageInOTOState extends ChatOneToOneStates{}
class LoadingGetAllChatOTOState extends ChatOneToOneStates{}
class SuccessGetAllChatOTOState extends ChatOneToOneStates{}
class FailureGetAllChatOTOState extends ChatOneToOneStates{
  final String? errMessage;
  FailureGetAllChatOTOState({this.errMessage});
}
class LoadingSendMessageToOtherState extends ChatOneToOneStates{}
class FailureSendMessageToOtherState extends ChatOneToOneStates{
  final String?errMessage;
  FailureSendMessageToOtherState({this.errMessage});
}
class SuccessSendMessageToOtherState extends ChatOneToOneStates{}
class AddFileLocallySuccessState extends ChatOneToOneStates{}
class UploadFileLoadingState extends ChatOneToOneStates{}
class UploadFileSuccessState extends ChatOneToOneStates{}
class UploadFileFailureState extends ChatOneToOneStates{
  final String?errMessage;
  UploadFileFailureState({this.errMessage});
}
class FailureToHavePermissionToRecord extends ChatOneToOneStates{
  final String?errMessage;
  FailureToHavePermissionToRecord({this.errMessage});
}
class SuccessToAllowPermissionToRecord extends ChatOneToOneStates{}
class RecordingStartedState extends ChatOneToOneStates{}
class RecordingStoppedState extends ChatOneToOneStates{}
class UpdateVoiceButtonShape extends ChatOneToOneStates{}
class UpdateCurrentPositionOfVoice extends ChatOneToOneStates{}
class StopPlayingVoiceState extends ChatOneToOneStates{}
class EnableImagePreviewState extends ChatOneToOneStates{}
class DisableImagePreviewState extends ChatOneToOneStates{}

