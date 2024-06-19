import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/features/tour_guide/requested_trips/data/repos/get_all_request_repo/get_all_request_with_feedback_repo_imp.dart';
import 'package:prepare_project/features/tour_guide/requested_trips/presentaions/manager/handle_request_cubit/handle_request_states.dart';

class HandleRequestCubit extends Cubit<HandleRequestStates>{
  HandleRequestCubit({required this.tripID,required this.requestID,required this.handleRequestRepImp}):super(InitialHandleRequestState());
  bool isLoadingAccept=false;
  bool isLoadingReject=false;
  String requestID;
  final GetAllRequestedTripRepoImpl handleRequestRepImp;
  String tripID;
  Future<void>sendHandleFeedBack({required String answer})async{
    answer=='yes'?isLoadingAccept=true:isLoadingReject=true;
    emit(LoadingSendHandleRequestState());
    var result=await handleRequestRepImp.handleRequestBack({
      "requestID":requestID,
      "answer":answer,
      "tripID":tripID,
    });
    result.fold((failure){
      answer=='yes'?isLoadingAccept=false:isLoadingReject=false;
      emit(FailureSendHandleRequestState(errMessage: failure.errMessage));
    }, (message) {
      answer=='yes'?isLoadingAccept=false:isLoadingReject=false;
      emit(SuccessSendHandleRequestState(message: message));
    });

  }
}