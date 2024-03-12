abstract class TouristsChatWithOtherStates{}
class InitialTouristsChatWithOtherStates extends TouristsChatWithOtherStates {}
class LoadingGetGuidesMetaDataState extends TouristsChatWithOtherStates {}
class SuccessGetGuidesMetaDataState extends TouristsChatWithOtherStates {}
class FailureGetGuidesMetaDataState extends TouristsChatWithOtherStates {
  final String?errMessage;
  FailureGetGuidesMetaDataState({this.errMessage});
}
class LoadingGetChatsMetaDataState extends TouristsChatWithOtherStates {}
class SuccessGetChatsMetaDataState extends TouristsChatWithOtherStates {}
class FailureGetChatsMetaDataState extends TouristsChatWithOtherStates {
  final String?errMessage;
  FailureGetChatsMetaDataState({this.errMessage});
}