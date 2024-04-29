abstract class CommonSettingState {}
class InitialTourGuideSettingState extends CommonSettingState {}

class ChangeToggleOfModeState extends CommonSettingState {}

class ChangeNotificationModeState extends CommonSettingState {}

class LoadingSendFcmNotificationState extends CommonSettingState {}

class SuccessSendFcmNotificationState extends CommonSettingState {}

class FailureSendFcmNotificationState extends CommonSettingState {
  final String?errMessage;
  FailureSendFcmNotificationState({this.errMessage});
}