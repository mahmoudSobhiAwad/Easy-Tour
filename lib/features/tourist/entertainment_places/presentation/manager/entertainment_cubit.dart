import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/features/tourist/entertainment_places/data/repos/entertainment_repo_imp.dart';
import 'package:prepare_project/features/tourist/entertainment_places/presentation/manager/entertainment_states.dart';

class StaticPlacesCubit extends Cubit<StaticPlacesState>{
  StaticPlacesCubit({required this.repoImp,}):super(InitialStaticPlacesState());
  final EntertainmentPlaceRepoImp repoImp;

  void getStaticPlace(String?endPoint)async{
    emit(LoadingFetchStaticPlacesState());
    var result=await repoImp.getPlacesInfo({'type':endPoint});
    result.fold((failure) {
      if(failure.statusCode==401){
        getStaticPlace(endPoint);
      }
      else{
      emit(FailureFetchStaticPlacesState(errMessage: failure.errMessage));

      }
    }, (success){
      emit(SuccessFetchStaticPlacesState());
    });
  }
}