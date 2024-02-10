abstract class LicencesStates{}
class InitialLicencesState extends LicencesStates{}
class LoadingUpdateLicencesState extends LicencesStates{}
class ChangeUpdateButtonColorLicencesState extends LicencesStates{}
class SuccessUpdateLicencesState extends LicencesStates{}
class FailureUpdateLicencesState extends LicencesStates{
  final String?errMessage;
  FailureUpdateLicencesState({this.errMessage});
}
class RemovedPickedFileState extends LicencesStates{}
