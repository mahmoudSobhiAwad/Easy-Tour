abstract class CheckPriceStates{}

class InitialCheckPriceState extends CheckPriceStates {}

class LoadingCheckPriceState extends CheckPriceStates {}

class SuccessCheckPriceState extends CheckPriceStates {}

class FailureCheckPriceState extends CheckPriceStates {
  final String?errMessage;
  FailureCheckPriceState({this.errMessage});
}