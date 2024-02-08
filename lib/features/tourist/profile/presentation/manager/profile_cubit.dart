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
  /// mutual
  // String?country;
  // String?flag;
  // String?coverUrl;
  // String?imageUrl;
  /// edit cubit
  // String?countryCode='20';
  // String?gender;
  // String?language;
  // bool showEdit=false;
  // String?status;
  // File?profileFile;
  // File?coverFile;
  // bool showPrefDrop=false;
  late TouristInfoModel touristModel;
  // TextEditingController phoneController=TextEditingController();
  // Set preferences={};
  //final ImagePicker picker=ImagePicker();
   Future<void>getProfileData()async {
     showGetLoading=true;
     emit(LoadingGetInfoTouristDataState());
      var result=await profileRepo.getTourismInfo();
      return  result.fold((failure) {
      emit(FailureGetInfoTouristDataState(failure.errMessage));
      showGetLoading=false;
   }, (infoModel) {
      changeDataAfterGet(infoModel);
      emit(SuccessGetInfoTouristDataState());
      showGetLoading=false;
   });

  }
  // void showEditStack(){
  //    showEdit=!showEdit;
  //    emit(ChangeShowEditWidgetState());
  // }
  void changeDataAfterGet(TouristInfoModel? model) {
    touristModel.status=model?.status;
    touristModel.languages=model?.languages;
    touristModel.profileUrl=model?.profileUrl;
    touristModel.coverUrl=model?.coverUrl;
    touristModel.phoneNumber=model?.phoneNumber;
    touristModel.flagName=model?.flagName;
    touristModel.nationality=model?.nationality;
    touristModel.preferences=model?.preferences;
    touristModel.gender=model?.gender;
    SetAppState.setProfilePic(profileUrl: model?.profileUrl);
    // gender=model?.gender;
    // status=model?.status;
    // imageUrl=model?.profileUrl;
    // coverUrl=model?.coverUrl;
    // country=model?.nationality;
    // // language=model?.languages;
    // // phoneController.text=model?.phoneNumber??"";
    // // preferences=model?.preferences?.toSet()??{};
    // flag=model?.flagName;

  }
  // Future<void>updateProfileDate()async {
  //    final FormData formData=await TouristInfoModel(
  //      profileFile: profileFile,
  //      coverFile: coverFile,
  //      preferences: preferences.toList(),
  //      nationality: country,
  //      gender: gender,
  //      languages: language,
  //      phoneNumber: phoneController.text,
  //      flagName: flag,
  //    ).toFormData();
  //
  //    emit(LoadingSetUpProfileDataState());
  //    var result=await profileRepo.updateTourismInfo(infoModel: formData,
  //    );
  //    return result.fold((failure) {
  //
  //      emit(FailureUpdateInfoTouristDataState(failure.errMessage));
  //    }, (tourismInfo) {
  //      emit(SuccessUpdateInfoTouristDataState());
  //      profileFile=coverFile=null;
  //      changeDataAfterGet(tourismInfo);
  //    });
  //  }
  //  void editGender(String?value){
  //   gender=value;
  //   emit(ChangeGenderSuccessState());
  //  }
  //  void editCountry(Country?value){
  //   country=value?.name;
  //   flag=value?.flagEmoji.toString();
  //
  //   emit(ChangeCountrySuccessState());
  //  }
  //  void editLang(String?value){
  //   language=value;
  //   emit(ChangeLanguageSuccessState());
  //  }
  //  void editListOfPrefs(String?value){
  //   preferences.add(value!);
  //   emit(AddItemInPrefsListState());
  //  }
  //  void removeFromPrefs(String?value){
  //    preferences.remove(value);
  //    emit(RemoveItemFromPrefsListState());
  //  }
  // Future<void> getImageFromCamera(String?photoName)async{
  //   XFile?imageCamera=await picker.pickImage(source:ImageSource.camera);
  //   if(imageCamera!=null){
  //     if(photoName=='profile'){
  //       profileFile=File(imageCamera.path);
  //     }
  //     else if(photoName=='cover'){
  //       coverFile=File(imageCamera.path);
  //     }
  //     emit(GetImageFromGalleryState());
  //   }
  // }
  // Future<void> getImageFromGallery(String?photoName)async{
  //    XFile? pickedFile=await picker.pickImage(source: ImageSource.gallery);
  //   if(pickedFile!=null){
  //     if(photoName=='profile'){
  //       profileFile=File(pickedFile.path);
  //     }
  //     else if(photoName=='cover'){
  //       coverFile=File(pickedFile.path);
  //     }
  //     emit(GetImageFromGalleryState());
  //   }
  // }
  // void changePrefsMenuDrop()
  // {
  //    showPrefDrop=!showPrefDrop;
  //    emit(ChangeMenuDropState());
  //  }


}
// Future<void>cropImage(String?photoName)async{
//   String sourcePath='';
//   if(photoName=='profile'){
//     sourcePath=imageUrl!;
//   }
//   else if(photoName=='cover'){
//     sourcePath=coverUrl!;
//   }
//   final cropFile=await getImageCropped(sourcePath);
//   if(cropFile!=null){
//     if(photoName=='profile'){
//       imageUrl=File(cropFile.path).path;
//
//     }
//     else if(photoName=='cover'){
//       coverUrl=File(cropFile.path).path;
//     }
//     emit(EditPhotoOfIdState());
//   }
//
//
// }
