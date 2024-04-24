import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/tourist/weather_forecast/data/models/weather_forecast_model.dart';
class NextDayWeatherItem extends StatelessWidget {
  const NextDayWeatherItem({super.key,required this.height,required this.width,required this.value,this.enable=false});
  final double height;
  final double width;
  final WeatherDayModelValue? value;
  final bool enable;
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: commonBorderRadius(),
        border: Border.all(
          color: enable?Colors.white:Colors.white.withOpacity(0.3),
          width: 2,
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${value?.avgTemp??"0"} °C',style: CustomTextStyle.commonSignAlwaysWhite),
          Image.asset('${value?.iconOfDay}',height: height*0.07,width: width*0.1,fit: BoxFit.fitHeight,),
          Text(value?.nameOfDay??"",style: CustomTextStyle.commonSignAlwaysWhite,)
        ],
      ),
    );
  }
}