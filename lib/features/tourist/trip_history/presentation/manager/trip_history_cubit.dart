import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/features/tourist/trip_history/data/model/trip_manager_model.dart';
import 'package:prepare_project/features/tourist/trip_history/data/repos/trip_manager_repo_impl.dart';
import 'package:prepare_project/features/tourist/trip_history/presentation/manager/trip_history_states.dart';

class TripManagerCubit extends Cubit<TripManagerState>{
  TripManagerCubit({required this.tripManagerRepoImpl}):super(InitialTripManagerState());
  int currIndex=0;
  bool isLoading=false;
  bool isEmpty=true;
  String firstDate='';
  String lastDate='';
  bool enableReminder=false;
  DateFormat formatterAI=DateFormat('d MMM y');
  late TripManagerModel tripHistory;
  final TripManagerRepoImpl tripManagerRepoImpl;
  void changeTripTypeIndex(int index){
    currIndex=index;
    emit(ChangeTripIndexState());
  }

  Future<void> getTripHistoryList()async{
    isLoading=true;
    tripHistory=TripManagerModel(customTripsList: [], generatedTripsList: [], tripsWithTourGuideList: []);
    emit(LoadingGetAllTripHistoryState());
    var result=await tripManagerRepoImpl.getAllTripsManager();
    result.fold((failure){
      isLoading=false;
      emit(FailureGetAllTripHistoryState(errMessage: failure.errMessage));
      print(failure.errMessage);
    }, (tripModel){
      emit(SuccessGetAllTripHistoryState());
      if(tripModel.tripsWithTourGuideList.isEmpty&&tripModel.generatedTripsList.isEmpty&&tripModel.customTripsList.isEmpty){
        isEmpty=true;
      }
      else{
        isEmpty=false;
      }
      isLoading=false;
      tripHistory=tripModel;
    });
  }
  Future<void>removeSpecificTrip({required String tripId,required String type})async{
    emit(LoadingDeleteTripState());
    var result=await tripManagerRepoImpl.delete({
      "tripID":tripId ,
      "tripType":type,
    });
    result.fold((failure){
      return FailureDeleteTripState(errMessage:failure.errMessage);
    }, (success){
      emit(SuccessDeleteTripState());
      getTripHistoryList();
    });

  }

  Future<void>repeatTrip({required String type,required String id,required String startDate,required String endDate})async{
    emit(LoadingRepeatTripState());
    var result=await tripManagerRepoImpl.repeatTripsManager({
      "tripID":id,
      "tripType":type,
      "from":startDate,
      "to":endDate
    });
    result.fold((failure){
      return FailureRepeatTripState(errMessage:failure.errMessage);
    }, (success){
      emit(SuccessRepeatTripState());
      getTripHistoryList();
    });

  }

  void getRangeDate({required BuildContext context,required int durationNum,required String id,required String tripType})async{
    await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days:durationNum)),
      currentDate:DateTime.now(),
      saveText: 'Pick',
    ).then((value) async{
      if(value!=null){
        print(id);
        print(tripType);
        firstDate=formatterAI.format(value.start);
        lastDate=formatterAI.format(value.end);
        await repeatTrip(type: tripType, id: id, startDate: firstDate, endDate: lastDate);
      }
      return null;
    });
  }

  void setReminder()async{
    enableReminder=!enableReminder;
    emit(ChangeReminderState());
    if(enableReminder){
     await AwesomeNotifications().isNotificationAllowed().then((value) async{
        if(value){
          await sendNotification();
        }
        else{
          await AwesomeNotifications().requestPermissionToSendNotifications();
        }
      });
    }
    else{
     await AwesomeNotifications().cancelNotificationsByChannelKey(reminderNotificationChannel);
    }
  }
Future<void> sendNotification()async{
    emit(LoadingSetReminderState());
    try{
      for(var item in tripHistory.customTripsList){
        if(DateFormat("d MMM y").parse(item.startDate!).isAfter(DateTime.now())){
          await AwesomeNotifications().createNotification(content: NotificationContent(
              id: 1,
              channelKey: reminderNotificationChannel,
              title: "Custom Trip Today",
              body: "${item.title}"
          ),schedule: NotificationCalendar.fromDate(date: DateFormat("d MMM y").parse(item.startDate!)));
        }
      }
      for(var item in tripHistory.generatedTripsList){
        if(DateFormat("dd MMM yyyy").parse(item.startDate!).isAfter(DateTime.now())){
          await AwesomeNotifications().createNotification(content: NotificationContent(
              id: 1,
              channelKey: reminderNotificationChannel,
              title: "Generated Trip ",
              body: "${item.title}"
          ),schedule: NotificationCalendar.fromDate(date: DateFormat("dd MMM yyyy").parse(item.startDate!)));
        }
      }
      emit(SuccessSetReminderState());
    }
    catch(e){
      print(e.toString());
      emit(FailureSetReminderState(errMessage: e.toString()));
    }

}
}