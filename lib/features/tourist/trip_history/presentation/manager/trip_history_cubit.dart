import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/features/tourist/trip_history/data/model/trip_manager_model.dart';
import 'package:prepare_project/features/tourist/trip_history/data/repos/trip_manager_repo_impl.dart';
import 'package:prepare_project/features/tourist/trip_history/presentation/manager/trip_history_states.dart';

class TripManagerCubit extends Cubit<TripManagerState>{
  TripManagerCubit({required this.tripManagerRepoImpl}):super(InitialTripManagerState());
  int currIndex=0;
  bool isLoading=false;
  bool isEmpty=true;
  late TripManagerModel tripHistory;
  final TripManagerRepoImpl tripManagerRepoImpl;
  void changeTripTypeIndex(int index){
    currIndex=index;
    emit(ChangeTripIndexState());
  }

  Future<void> getTripHistoryList()async{
    isLoading=true;
    emit(LoadingGetAllTripHistoryState());
    var result=await tripManagerRepoImpl.getAllTripsManager();
    result.fold((failure){
      isLoading=false;
      emit(FailureGetAllTripHistoryState(errMessage: failure.errMessage));
    }, (tripModel){
      emit(SuccessGetAllTripHistoryState());
      if(tripModel.tripsWithTourGuideList.isEmpty&&tripModel.generatedTripsList.isEmpty&&tripModel.customTripsList.isEmpty){
        isEmpty=true;
      }
      else{
        isEmpty=false;
      }
      tripHistory=tripModel;
    });
  }
}