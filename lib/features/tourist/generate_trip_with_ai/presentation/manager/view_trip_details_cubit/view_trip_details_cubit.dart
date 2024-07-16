
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/model/generated_trip_model.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/data/repos/generate_trip_repo_imp.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/manager/view_trip_details_cubit/view_trip_details_state.dart';

class ViewTripDetailsCubit extends Cubit<ViewTripDetailsState>{
  ViewTripDetailsCubit({this.generatedTripModel,this.generateTripRepoImp,required this.endDate,required this.startDate}):super(InitialViewTripDetailsState());
  int currentDay=0;
  final GeneratedTripModel? generatedTripModel;
  final GenerateTripRepoImp? generateTripRepoImp;
  final String? startDate;
  final String? endDate;
  final formatter = DateFormat('d MMM y');
  List<String>daysDatesName=[];
  PageController pageController=PageController();
  bool isLoading=false;
  List<LatLng>polyLinesList=[];
  TextEditingController titleController=TextEditingController();
  FocusNode focusNode=FocusNode();
  ScrollController controller=ScrollController();
  void pageChange(int index){
    currentDay=index;
    emit(MoveToNextDayState());
    fillLatLangList();
  }
  void addDaysDates(){
    int days=generatedTripModel?.days.length??0;
    DateTime firstDay=formatter.parse(startDate!);
    for(int i=0;i<days;i++){
      daysDatesName.add(formatter.format(firstDay.add(Duration(days: i+1))));
    }
  }
  void moveToNextDay(double width)
  {
    if(currentDay<generatedTripModel!.days.length-1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,);
      double offset = (currentDay + 1) * width;
      currentDay++;
      controller.animateTo(
        offset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      emit(MoveToNextDayState());
    }

  }
  void moveToPrevDay(double width,)
  {
    if(currentDay>0){
      pageController.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
      double offset = (currentDay - 1) * width;
      currentDay--;
      controller.animateTo(
        offset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      emit(MoveToPrevDayState());
    }
  }
  void moveToSpecificDay(int pageNum)
  {
    currentDay=pageNum;
    pageController.jumpToPage(pageNum);
    emit(MoveToPrevDayState());
  }
  Future<void> uploadTrip()async
  {
    isLoading=true;
    Map<String,dynamic>data={
      "title":titleController.text,
      "from":startDate,
      "to":endDate,
    };
    emit(LoadingUploadTripState());
    var result=await generateTripRepoImp!.uploadGeneratedDate(data: data);
    result.fold(
            (failure){
              isLoading=false;
              emit(FailedToUploadTripState());
            },
            (success){
              isLoading=false;
              titleController.clear();
              emit(SuccessToUploadTripState());
            }
    );

  }


  void fillLatLangList(){
    polyLinesList.clear();
    for(var item in generatedTripModel!.days[currentDay].places){
      polyLinesList.add(LatLng(item.latitude, item.longitude));
    }
    emit(ChangeCoordinatesOfMap());
  }
}
