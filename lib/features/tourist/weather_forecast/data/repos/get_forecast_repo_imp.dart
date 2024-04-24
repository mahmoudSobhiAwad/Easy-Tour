import 'package:dio/dio.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/core/utilities/network/crud_dio.dart';
import 'package:prepare_project/features/tourist/weather_forecast/data/repos/get_forecast_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:prepare_project/core/errors/failure_dio.dart';
import 'package:prepare_project/features/tourist/weather_forecast/data/models/weather_forecast_model.dart';
class GetForecastRepoImpl implements GetForecastRepo{
  final ApiServices apiServices;
  GetForecastRepoImpl(this.apiServices);
  @override
  Future<Either<Failure, List<WeatherForecastModel>>> getForecastWeather(String city) async {
    try {
      var data = await apiServices.normalGet('https://api.tomorrow.io/v4/weather/forecast?location=$city&timesteps=1d&apikey=$forecastingWeatherKey');
      List<WeatherForecastModel>weatherList = [];
      for (var item in data['timelines']['daily']) {
        weatherList.add(WeatherForecastModel.fromJson(item));
      }
      return right(weatherList);
    }
    catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      else {
        return left(ServerFailure(e.toString()));
      }
    }
  }
}