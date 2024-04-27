abstract class TestAudioState{}
class InitialTestAudioState extends TestAudioState{}
class FailureToHavePermissionToRecord extends TestAudioState{
  final String?errMessage;
  FailureToHavePermissionToRecord({this.errMessage});
}
class SuccessToAllowPermissionToRecord extends TestAudioState {}
class RecordingStartedState extends TestAudioState {}
class RecordingStoppedState extends TestAudioState {}
class AddAudioToListState extends TestAudioState{}
class PlayAudioState extends TestAudioState{}
class UpdateCurrentPositionOfVoice extends TestAudioState{}
class StopAudioState extends TestAudioState{}
class UpdateVoiceButtonShape extends TestAudioState{}
class PickedImageSuccessState extends TestAudioState{}
class ChangeTextEmptyOrFullState extends TestAudioState{}
class EnableImagePreviewState extends TestAudioState{}
class DisableImagePreviewState extends TestAudioState{}
class UploadImageSuccessState extends TestAudioState{}
class UploadImageLoadingState extends TestAudioState{}
class UploadImageFailureState extends TestAudioState{
  final String?errMessage;
  UploadImageFailureState({this.errMessage});

}
class AddFileLocallySuccessState extends TestAudioState{}
