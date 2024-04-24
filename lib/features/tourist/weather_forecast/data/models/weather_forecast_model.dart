import 'package:intl/intl.dart';

class WeatherForecastModel{
  String?time;
  WeatherDayModelValue?weatherModelValue;
  WeatherForecastModel({
    this.weatherModelValue,
    this.time,
});
  factory WeatherForecastModel.fromJson(Map<String,dynamic>json){
    return WeatherForecastModel(
      time: json['time'],
      weatherModelValue:WeatherDayModelValue.fromJson(json['values'],json['time']),
    );
  }
}
class WeatherDayModelValue{
  num?rainAvg;
  num?humidityAvg;
  num?windSpeed;
  num?minTemp;
  num?maxTemp;
  num?avgTemp;
  String?iconOfDay;
  String?nameOfDay;
  String?statusOfDay;
  WeatherDayModelValue({
    this.avgTemp,
    this.humidityAvg,
    this.maxTemp,
    this.minTemp,
    this.rainAvg,
    this.windSpeed,
    this.iconOfDay,
    this.nameOfDay,
    this.statusOfDay,
});
 factory WeatherDayModelValue.fromJson(Map<String,dynamic>json,String date){
   return WeatherDayModelValue(
     rainAvg: json['rainAccumulationAvg'],
     humidityAvg: json['humidityAvg'],
     windSpeed: json['windSpeedAvg'],
     minTemp: json['temperatureMin'],
     maxTemp: json['temperatureMax'],
     avgTemp: json['temperatureAvg'],
     iconOfDay: DayStatus().getDayStatus(json['temperatureAvg']).iconName,
     statusOfDay: DayStatus().getDayStatus(json['temperatureAvg']).statusName,
     nameOfDay: DayStatus().getDayName(date),
   );
 }

}
class DayStatus{
  String?iconName;
  String?statusName;

  DayStatus({this.iconName,this.statusName});
  DayStatus getDayStatus(num temp){
    if(temp>35){
      return DayStatus(iconName:'assets/weather_status/very_hot.png' ,statusName:'Very Hot' );
    }
    else if(temp>27&&temp<35){
      return DayStatus(iconName:'assets/weather_status/hot.png' ,statusName:'Hot' );
    }
    else if(temp>10&&temp<27){
      return DayStatus(iconName:'assets/weather_status/fine.png' ,statusName:'Moderate' );
    }
    else if(temp>0&&temp<10){
      return DayStatus(iconName:'assets/weather_status/cold.png' ,statusName:'Cold' );
    }
    else if(temp<0){
      return DayStatus(iconName:'assets/weather_status/very_cold.png' ,statusName:'Very Cold' );
    }
    else{
      return DayStatus(iconName:'assets/weather_status/fine.png' ,statusName:'Moderate' );
    }
  }
  String getDayName(String date){
// Parse the date time string into a DateTime object
    DateTime dateTime = DateTime.parse(date);
// Format the day of the week as a full name (e.g., Tuesday)
    DateFormat dayFormatter = DateFormat('EEEE'); // EEEE for full weekday name
    String dayName = dayFormatter.format(dateTime);
    return dayName;
  }
}
String getIconOfDay(num temp){
  if(temp>35){
    return 'assets/weather_status/very_hot.png';
  }
  else if(temp>27&&temp<35){
    return 'assets/weather_status/hot.png';
  }
  else if(temp>10&&temp<27){
    return 'assets/weather_status/fine.png';
  }
  else if(temp>0&&temp<10){
    return 'assets/weather_status/cold.png';
  }
  else if(temp<0){
    return 'assets/weather_status/very_cold.png';
  }
  else{
    return 'assets/weather_status/fine.png';
  }

}