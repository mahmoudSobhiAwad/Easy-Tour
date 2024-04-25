abstract class CurrencyConverterState{}
class InitialCurrencyConverterState extends CurrencyConverterState {}
class SwapBetweenBasedAndTargetState extends CurrencyConverterState {}
class LoadingGetCurrencyCodeState extends CurrencyConverterState {}
class SuccessGetCurrencyCodeState extends CurrencyConverterState {}
class FailureGetCurrencyCodeState extends CurrencyConverterState {
  final String?errMessage;
  FailureGetCurrencyCodeState({this.errMessage});}
class LoadingGetCurrencyConvertedState extends CurrencyConverterState {}
class SuccessGetCurrencyConvertedState extends CurrencyConverterState {}
class FailureGetCurrencyConvertedState extends CurrencyConverterState {
  final String?errMessage;
  FailureGetCurrencyConvertedState({this.errMessage});
}
class ChangeBasedOrTargetCodeState extends CurrencyConverterState {}
class LoadingGetNearbyBanksState extends CurrencyConverterState {}
class SuccessGetNearbyBanksState extends CurrencyConverterState {}
class FailureGetNearbyBanksState extends CurrencyConverterState {
  final String?errMessage;
  FailureGetNearbyBanksState({this.errMessage});
}

