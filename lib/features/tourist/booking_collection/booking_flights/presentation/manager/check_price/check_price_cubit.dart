import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/data/flight_repos/get_tickets_repo_impl.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_flights/presentation/manager/check_price/check_price_states.dart';

class CheckPriceCubit extends Cubit <CheckPriceStates>{
  CheckPriceCubit({required this.getTicketsRepoImpl,required this.index}):super(InitialCheckPriceState());
  bool isLoading=false;
  int index;
  String accessToken='';
  final GetTicketsRepoImpl getTicketsRepoImpl;
  Future<void>getAccessToken()async{
    var result=await getTicketsRepoImpl.getAccessToken(data:{
      'client_id':'AirgInEAzLk1QDoIeEHHk0vns2G8c7G8',
      'client_secret':'oHm6NcXleQeTVSwY',
      'grant_type':'client_credentials',
    });
    result.fold((failure){
    }, (token){
      accessToken=token;

    });
  }

  Future<void>checkPrice()async{
    isLoading=true;
    emit(LoadingCheckPriceState());
    var response=await getTicketsRepoImpl.getOfferPrice(accessToken: accessToken, index: index);
    response.fold((failure)async{
      isLoading=false;
      if(failure.statusCode==401){
        await getAccessToken();
      }
      emit(FailureCheckPriceState(errMessage: failure.errMessage));
    }, (data) {
      emit(SuccessCheckPriceState());
    });
  }

}