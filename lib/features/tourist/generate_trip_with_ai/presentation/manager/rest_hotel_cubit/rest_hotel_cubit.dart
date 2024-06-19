import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/features/tourist/generate_trip_with_ai/presentation/manager/rest_hotel_cubit/rest_hotel_state.dart';
import 'package:prepare_project/features/tourist/nearby_places/data/models/nearby_places_model.dart';
import 'package:prepare_project/features/tourist/nearby_places/data/repos/photo_repo/get_photo_repo_imp.dart';

class RestHotelDetailsCubit extends Cubit<RestHotelDetailsState>{
  RestHotelDetailsCubit({required this.model,required this.photoOfPlaceRepoImp}):super(InitialRestHotelState());
  final NearbyPlacesModel model;
  final PhotoOfPlaceRepoImp photoOfPlaceRepoImp;
  List<String>photoUrlList=[];
  int currIndex=0;
  bool isLoadingPhotos=false;
  Future<void>getPhotoPlaceList()async{
    if(model.photosList!=null){
      int listLength=3;
      if(model.photosList!.length<3){
        listLength=model.photosList!.length;
      }
    emit(LoadingGetPhotoOfPlace());
    isLoadingPhotos=true;
    for(int i=0;i<listLength;i++){

      var result=await photoOfPlaceRepoImp.getPhotoOfPlace(model.photosList![i].photoName!.toString());
      result.fold((failure){
        emit(FailureGetPhotoOfPlace(errMessage: failure.errMessage));
      }, (photoImage){
        photoUrlList.add(photoImage);
        emit(SuccessGetPhotoOfPlace());
      });
    }

  }
  }
  void changeToReview(int index){
    currIndex=index;
    emit(ChangeToShowReviewState());
  }
}