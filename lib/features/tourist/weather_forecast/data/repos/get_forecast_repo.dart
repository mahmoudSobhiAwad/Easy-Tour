import 'package:dartz/dartz.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/features/tourist/weather_forecast/data/models/weather_forecast_model.dart';
abstract class GetForecastRepo{
  Future<Either<Failure,List<WeatherForecastModel>>>getForecastWeather(String city);
}