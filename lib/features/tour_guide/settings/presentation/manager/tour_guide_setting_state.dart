abstract class TourGuideSettingState {}
class InitialTourGuideSettingState extends TourGuideSettingState {}

class ChangeToggleOfModeState extends TourGuideSettingState {}

class ChangeNotificationModeState extends TourGuideSettingState {}

class LoadingSendFcmNotificationState extends TourGuideSettingState {}

class SuccessSendFcmNotificationState extends TourGuideSettingState {}

class FailureSendFcmNotificationState extends TourGuideSettingState {
  final String?errMessage;
  FailureSendFcmNotificationState({this.errMessage});
}
