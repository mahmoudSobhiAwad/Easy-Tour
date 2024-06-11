import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/features/tourist/custom_trip/data/model/custom_trip_model.dart';
import 'package:prepare_project/features/tourist/custom_trip/data/repos/custom_trip_repo_impl.dart';
import 'package:prepare_project/features/tourist/custom_trip/presentation/manager/get_custom_trip/get_custom_trips_states.dart';

class GetCustomTripCubit extends Cubit<GetCustomTripsState>{
  GetCustomTripCubit({required this.customTripRepoImpl}):super(InitialGetCustomTripState());
  List<CustomTripModel>customTripList=[];
  final CustomTripRepoImpl customTripRepoImpl;
  bool isLoading=false;

  void getAllTrips()async{
    isLoading=true;
    emit(LoadingGetCustomTripState());
    var result=await customTripRepoImpl.getAllCustomTrips();
    result.fold((failure){
      isLoading=false;
      emit(FailureGetCustomTripState(errMessage: failure.errMessage));
    } , (data){
      customTripList=[];
      for(var item in data){
        customTripList.add(item);
      }
      isLoading=false;
      emit(SuccessGetCustomTripState());
    }
    );
  }

  void deleteTrip({required int index})async{
    isLoading=true;
    emit(LoadingGetCustomTripState());
    var result=await customTripRepoImpl.deleteCustomTrip(tripId: customTripList[index].tripId!);
    result.fold((failure){
      isLoading=false;
      emit(FailureGetCustomTripState(errMessage: failure.errMessage));
    } , (data) {
      emit(SuccessGetCustomTripState());
      getAllTrips();
    }
    );
  }

  List<String>getCategoriesList(int index) {
    List<String>categoryList=[];
    for(var item in customTripList[index].tripDetailsList??[]){
      for(var element in item.daysDetailsList!){
        categoryList.add(element.category);
      }
    }
    return categoryList;
  }
}