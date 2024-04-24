abstract class WeatherForecastStates {}
class InitialWeatherForecastState extends WeatherForecastStates {}
class ChangeCurrentDayToShow extends WeatherForecastStates {}
class LoadingGetWeatherForecastingState extends WeatherForecastStates {}
class AllowLocationFailedState extends WeatherForecastStates {
  final String?errMessage;
  AllowLocationFailedState({this.errMessage});
}
class AllowLocationSuccessState extends WeatherForecastStates {}
class ChangeCityValueState extends WeatherForecastStates {}
class SuccessGetWeatherForecastingState extends WeatherForecastStates {}
class FailureGetWeatherForecastingState extends WeatherForecastStates {
  final String?errMessage;
  FailureGetWeatherForecastingState({this.errMessage});
}