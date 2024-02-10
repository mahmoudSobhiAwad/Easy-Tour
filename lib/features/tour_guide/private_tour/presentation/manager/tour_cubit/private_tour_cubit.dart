import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/features/tour_guide/private_tour/data/model/private_tour_model.dart';
import 'package:prepare_project/features/tour_guide/private_tour/data/repos/private_tour_repo.dart';
import 'package:prepare_project/features/tour_guide/private_tour/presentation/manager/tour_cubit/private_tour_state.dart';

class PrivateTourCubit extends Cubit<PrivateTourStates>{
  PrivateTourCubit({required this.privateTourRepo}):super(InitialPrivateTourState());
  bool isLoading=false;
  bool removeLoading=false;
  List<Trip>tripsList=[];
  PrivateTourRepo privateTourRepo;
  Future<void> getAllMyTrip()async{
    isLoading=true;
    emit(LoadingGetALLPrivateTourState());
   var result=await privateTourRepo.getPrivateTrip();
   result.fold(
           (failure) {
             if(failure.statusCode==401){
               getAllMyTrip();
             }
             else{
             isLoading=false;
             emit(FailureGetALLPrivateTourState(errMessage: failure.errMessage));
             }
           },
           (trips){
             isLoading=false;
             tripsList.clear();
             for (var element in trips) {
               tripsList.add(element);
             }
             emit(SuccessGetALLPrivateTourState());
           });
  }
  Future<void>deleteSpecificTrip(int index)async{
    removeLoading=true;
    String tripId=tripsList[index].tripId??"";
    var result=await privateTourRepo.deletePrivateTrip(data: {'trip_id':tripId});
    result.fold(
            (failure){
              if(failure.statusCode==401){
                deleteSpecificTrip(index);
              }
              else{
              removeLoading=false;
              emit(FailureDeletePrivateTourState(errMessage: failure.errMessage));
              }
            },
            (successDelete) async{
              removeLoading=false;
              emit(SuccessDeletePrivateTourState(successMessage: successDelete));
              tripsList.clear();
            })?.then((value) => getAllMyTrip()
    );
  }
}