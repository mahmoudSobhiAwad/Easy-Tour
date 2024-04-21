import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/features/tour_guide/requested_trips/data/models/handle_request_model.dart';
import 'package:prepare_project/features/tour_guide/requested_trips/data/repos/get_all_request_repo/get_all_request_with_feedback_repo_imp.dart';
import 'package:prepare_project/features/tour_guide/requested_trips/presentaions/manager/requested_trip_for_guide/requested_trip_for_guide_states.dart';
class RequestedTripForGuideCubit extends Cubit<RequestedTripForGuideStates>{
  RequestedTripForGuideCubit({required this.getAllRequestedTripRepoImpl}):super(InitialRequestedTripForGuideStates());
  bool isLoading=false;
  final GetAllRequestedTripRepoImpl getAllRequestedTripRepoImpl;
  List<RequestsTripForTGModel>requestedList=[];
  Future<void>getAllRequested()async{
    requestedList.clear();
    emit(LoadingGetRequestedTripForGuideStates());
    isLoading=true;
    var result=await getAllRequestedTripRepoImpl.getAllRequestedTrips();
    result.fold((failure){
      isLoading=false;
      emit(FailureGetRequestedTripForGuideStates(errMessage: failure.errMessage));
    }, (list){
      isLoading=false;
      for(var item in list ){
        requestedList.add(item);
      }
      emit(SuccessGetRequestedTripForGuideStates());
    });
  }
}