import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/features/tourist/historical_places/presentation/manager/historical_places_states.dart';

class HistoricalPlacesCubit extends Cubit<HistoricalPlacesState>{
  HistoricalPlacesCubit():super(InitialHistoricalPlacesState());
  bool isFav=false;
  int currIndex=0;
  List<int>paginationList=[1,2,3,4,5,6,7,8,9,10];
  ScrollController scrollController=ScrollController();
  void changeFavIcon(){
    isFav=!isFav;
    emit(ChangeFavIconsHistoricalPlacesState());
  }
  void changeIndex(int index){
    currIndex=index;
    emit(ChangePaginationIndexState());
  }
  void scrollToNextItem({bool isPrevious = false,required double width}) {
    if(currIndex<paginationList.length-1){
      double offset = (currIndex+ 1) * width;
      currIndex++;
      scrollController.animateTo(
         offset,
         duration: const Duration(milliseconds: 500),
         curve: Curves.easeInOut,);
      emit(ChangePaginationIndexState());
    }
  }
  void scrollToPrevItem({bool isPrevious = false,required double width}) {
    if(currIndex>0){
      double offset = (currIndex- 1) * width;
      currIndex--;
      scrollController.animateTo(
         offset,
         duration: const Duration(milliseconds: 500),
         curve: Curves.easeInOut,);
      emit(ChangePaginationIndexState());
    }

  }
}
