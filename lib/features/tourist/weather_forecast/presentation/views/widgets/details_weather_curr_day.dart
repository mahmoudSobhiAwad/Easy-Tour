import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/tourist/weather_forecast/data/models/weather_forecast_model.dart';
class DetailsWeatherOfDay extends StatelessWidget {
  const DetailsWeatherOfDay({
    super.key,
    required this.modelValue,
  });
final WeatherDayModelValue? modelValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color:const Color(0xff104084).withOpacity(0.33),
        borderRadius: commonBorderRadius(),
      ),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.cloudy_snowing,color: Colors.white,),
              Text('${modelValue?.rainAvg??"0"} %',style: CustomTextStyle.font16NormalWhite,),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.thermostat_outlined,color: Colors.white,),
              Text('${modelValue?.humidityAvg??'0'} %',style: CustomTextStyle.font16NormalWhite,),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.wind_power_rounded,color: Colors.white,),
              Text('${modelValue?.windSpeed??"0"} Km/h ',style: CustomTextStyle.font16NormalWhite,),
            ],
          )
        ],
      ),
    );
  }
}