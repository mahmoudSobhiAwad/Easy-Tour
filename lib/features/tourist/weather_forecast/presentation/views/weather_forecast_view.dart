import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/features/tourist/weather_forecast/data/repos/get_forecast_repo_imp.dart';
import 'package:prepare_project/features/tourist/weather_forecast/presentation/managers/weather_forecast_cubit.dart';
import 'package:prepare_project/features/tourist/weather_forecast/presentation/managers/weather_forecast_states.dart';
import 'package:prepare_project/features/tourist/weather_forecast/presentation/views/widgets/weather_forecast_body.dart';

class WeatherForecastView extends StatelessWidget {
  const WeatherForecastView({super.key});
  @override
  Widget build(BuildContext context) {
    final double height=BasicDimension.screenHeight(context);
    final double width=BasicDimension.screenWidth(context);
    return  BlocProvider(create: (context)=> WeatherForecastCubit(forecastRepoImpl: getIt.get<GetForecastRepoImpl>())..getLocationDetails(),
      child:BlocConsumer<WeatherForecastCubit,WeatherForecastStates>(
        builder:(context,state){
          var cubit=BlocProvider.of<WeatherForecastCubit>(context);
          return Scaffold(
            backgroundColor: const Color(0xff81C4E1),
            body: WeatherForecastBody(width: width, height: height,cubit: cubit,),
          );
        } ,listener:(context,state)async{
        var cubit=BlocProvider.of<WeatherForecastCubit>(context);
          if(state is AllowLocationSuccessState){
            await cubit.getForecastWeatherList();
          }
      } ,) ,);
  }
}









