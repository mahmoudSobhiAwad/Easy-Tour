import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/function/set_app_state.dart';
import 'package:prepare_project/features/tourist/profile/data/models/tourist_info_model.dart';
import 'package:prepare_project/features/tourist/profile/data/repos/profile_repo.dart';
import 'package:prepare_project/features/tourist/profile/presentation/manager/profile_states.dart';

class ProfileCubit extends Cubit<ProfileStates>{
  ProfileCubit({required this.profileRepo,}):super(InitialProfileState());
  final ProfileRepo profileRepo;
  String?name=SetAppState.prefs?.getString('name');
  bool showGetLoading=false;
  TouristInfoModel? touristModel;
  Future<void>getProfileData()async {
    showGetLoading=true;
     emit(LoadingGetInfoTouristDataState());
      var result=await profileRepo.getTourismInfo();
      return  result.fold((failure) async {
        if(failure.statusCode==401)
        {
          getProfileData();
          //emit(RefreshTokenFailureState('Unknown Error,Please try again'));
        }
        else
        {
          emit(FailureGetInfoTouristDataState(failure.errMessage));
          showGetLoading=false;
        }
   }, (infoModel) {
      changeDataAfterGet(infoModel);
      emit(SuccessGetInfoTouristDataState());
      showGetLoading=false;
   });

  }
  void changeDataAfterGet(TouristInfoModel? model) async{
     touristModel=TouristInfoModel(
       status: model?.status,
       languages:model?.languages,
       profileUrl:model?.profileUrl,
       coverUrl:model?.coverUrl,
       phoneNumber:model?.phoneNumber,
       flagName:model?.flagName,
       nationality:model?.nationality,
       preferences:model?.preferences,
       gender: model?.gender,
     );

     await SetAppState.setProfilePic(profileUrl:touristModel?.profileUrl);

  }

}

