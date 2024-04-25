abstract class TouristSettingState {}
class InitialTouristSettingState extends TouristSettingState {}

class ChangeToggleOfModeState extends TouristSettingState {}

class ChangeNotificationModeState extends TouristSettingState {}

class LoadingSendFcmNotificationState extends TouristSettingState {}

class SuccessSendFcmNotificationState extends TouristSettingState {}

class FailureSendFcmNotificationState extends TouristSettingState {
  final String?errMessage;
  FailureSendFcmNotificationState({this.errMessage});
}
