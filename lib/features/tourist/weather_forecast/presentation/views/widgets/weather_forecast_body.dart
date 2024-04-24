import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/sign_up_edit/custom_drop_down_button.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:prepare_project/features/tourist/weather_forecast/presentation/managers/weather_forecast_cubit.dart';
import 'package:prepare_project/features/tourist/weather_forecast/presentation/views/widgets/details_weather_curr_day.dart';
import 'package:prepare_project/features/tourist/weather_forecast/presentation/views/widgets/next_forecast_days.dart';

class WeatherForecastBody extends StatelessWidget {
  const WeatherForecastBody({
    super.key,
    required this.width,
    required this.height,
    required this.cubit,

  });

  final double width;
  final WeatherForecastCubit cubit;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child:cubit.weatherForecastModel.isEmpty?
        const Center(
          child: CircularProgressIndicator(color: Colors.white,),):Column(children: [
            CustomGeneratedAiTripAppBar(appBarWidth: width*0.4,height: height, width: width,menuToSaveTrip:  Row(children: [
              const Icon(Icons.location_on_rounded,color: Colors.white,),
              Text('${cubit.city}',style: CustomTextStyle.commonSignThinAlwaysWhite,),
              const SizedBox(width: 3,),
              CustomDropDownButton(list: governments, onChanged: (selectedGovernorate){
                cubit.changeCityFromList(selectedGovernorate);
              }, maxHeight: height*0.2,)
            ],),),
            Image.asset('${cubit.weatherForecastModel[cubit.currDay].weatherModelValue?.iconOfDay}',height: height*0.22,width: width*0.5,fit: BoxFit.fitHeight,),
            Text('${cubit.weatherForecastModel[cubit.currDay].weatherModelValue?.avgTemp} °C',style: CustomTextStyle.resetPassTitle.copyWith(fontSize: 40,color: Colors.white),),
            SizedBox(height: height*0.02,),
            Text('${cubit.weatherForecastModel[cubit.currDay].weatherModelValue?.statusOfDay}',style: CustomTextStyle.commonSignAlwaysWhite,),
            SizedBox(height: height*0.02,),
            Text('Max.: ${cubit.weatherForecastModel[cubit.currDay].weatherModelValue?.maxTemp} °C   Min.: ${cubit.weatherForecastModel[cubit.currDay].weatherModelValue?.minTemp} °C',style: CustomTextStyle.commonSignThinAlwaysWhite,),
            SizedBox(height: height*0.05,),
            DetailsWeatherOfDay(modelValue:cubit.weatherForecastModel[cubit.currDay].weatherModelValue,),
            SizedBox(height: height*0.05,),
            NextForecastDays(
                currDay: cubit.currDay,
                height: height, width: width, weatherForecastModel: cubit.weatherForecastModel,onTap:(int index){
              cubit.changeDayToShow(index);
            })
          ],),
      ),
    );
  }
}