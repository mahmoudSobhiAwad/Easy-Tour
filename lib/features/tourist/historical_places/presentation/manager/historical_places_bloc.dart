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
  void increaseIndex(){
    if(currIndex<paginationList.length){
      currIndex++;
      scrollToNextItem();
    }
    else{

    }
    emit(ChangePaginationIndexState());

  }
  void decreaseIndex(){
    if(currIndex!=0){
      currIndex--;
      scrollToNextItem(isPrevious: true);
    }
    else{

    }
    emit(ChangePaginationIndexState());
  }
  void scrollToNextItem({bool isPrevious = false}) {
    double currentOffset = scrollController.offset;
    double nextItemOffset=currentOffset;
    if (isPrevious) {
      nextItemOffset -= currentOffset*0.1;
    } else {
      nextItemOffset += currentOffset*0.2;
    }
    scrollController.animateTo(nextItemOffset, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }
}