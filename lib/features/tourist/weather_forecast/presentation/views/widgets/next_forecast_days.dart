import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/tourist/weather_forecast/data/models/weather_forecast_model.dart';
import 'package:prepare_project/features/tourist/weather_forecast/presentation/views/widgets/next_day_weather_item.dart';
class NextForecastDays extends StatelessWidget {
  const NextForecastDays({
    super.key,
    required this.height,
    required this.width,
    required this.weatherForecastModel,
    required this.onTap,
    required this.currDay,
  });

  final double height;
  final double width;
  final List<WeatherForecastModel>?weatherForecastModel;
  final void Function(int index)?onTap;
  final int currDay;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color:const Color(0xff104084).withOpacity(0.33),
        borderRadius: commonBorderRadius(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Next Forecast',style: CustomTextStyle.font16BoldWhite,),
          SizedBox(height: height*0.02,),
          SizedBox(
            height: height*0.2,
            child: ListView.separated(
                padding: EdgeInsets.zero,
                separatorBuilder: (context,index){
                  return  SizedBox(width: width*0.05,);
                },
                scrollDirection: Axis.horizontal,
                itemCount: weatherForecastModel?.length??0,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context,index){
                  return GestureDetector(
                      onTap: (){
                        onTap!(index);
                      },
                      child: NextDayWeatherItem(height: height, width: width, value: weatherForecastModel?[index].weatherModelValue,enable: index==currDay,));
                }),
          )
        ],
      ),
    );
  }
}