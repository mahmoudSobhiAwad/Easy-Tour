import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/features/tour_guide/profile/data/model/guide_personal_info_model.dart';
import 'package:prepare_project/features/tour_guide/profile/data/repos/tour_guide_profile_repo.dart';
import 'package:prepare_project/features/tour_guide/profile/presentation/manager/view_profile_state.dart';
import 'package:url_launcher/url_launcher.dart';

class TourGuideProfileViewCubit extends Cubit<TourGuideProfileViewState>{
  TourGuideProfileViewCubit({required this.tourGuideProfileRepo}):super(InitialTourGuideProfileView());
  TourGuideProfileRepo tourGuideProfileRepo;
  String? profileUrl;
  String phoneNum='';
  String describeText='';
  String address='';
  String firstName='';
  String lastName='';
  String date='';
  String cvUrl='';
  List languages=[];
  List<String>licenceNames=[];
  bool showLoading=false;
  Map<String,dynamic>socialLinks={};
  TourGuidePersonalInfoModel? tourGuidePersonalInfoModel;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  Future<void> getData()async{
    showLoading=true;
    emit(LoadingGetInfoTourGuideProfileView());
    var result=await tourGuideProfileRepo.getTourGuideInfo();
    result.fold((failure) {
      if(failure.statusCode==401){
        emit(RefreshTokenFailureState(errMessage: 'Error due to refresh token,try again'));
      }
      else{
      showLoading=false;
      emit(FailureGetInfoTourGuideProfileView(errMessage: failure.errMessage));
      }
    }, (profileTourGuideData){
      showLoading=false;
      prepareTourGuideDate(profileTourGuideData);
      emit(SuccessGetInfoTourGuideProfileView());
      completePersonalInfo();
    });
  }
  void prepareTourGuideDate(TourGuidePersonalInfoModel profileTourGuideData) async{
    firstName='${profileTourGuideData.firstName}';
    lastName='${profileTourGuideData.lastName}';
    languages=profileTourGuideData.lang??[];
    phoneNum=profileTourGuideData.phoneNumber??"";
    describeText=profileTourGuideData.describeText??"";
    address=profileTourGuideData.address??"";
    socialLinks.addAll(profileTourGuideData.contactInfo??{});
    pre();
    date=profileTourGuideData.date??'';
    profileUrl=profileTourGuideData.profileUrl;
    cvUrl=profileTourGuideData.cvUrl??'';
    licenceNames.addAll([profileTourGuideData.synId??'',profileTourGuideData.minId??'']);
  }
  void pre(){
    socialLinks.forEach((key, value) {
      if(value=='string'){
        socialLinks.remove(key);
      }
    });
  }
  String getLang() {
    return languages.join(',');
  }
  String getLicence(){
    return licenceNames.join(',');
  }
  void completePersonalInfo() {
    tourGuidePersonalInfoModel=TourGuidePersonalInfoModel(
        date: date,
        contactInfo: socialLinks,describeText: describeText,
        firstName: firstName, lastName: lastName,
        address: address, profileUrl: profileUrl,
        lang: languages, phoneNumber: phoneNum);
  }
  void openLauncherApp(Uri url)async{
    try {
      await launchUrl(url,mode: LaunchMode.externalApplication);
    } catch (error) {
      emit(FailureOpenAppUrlState(errMessage: "Error launching URL: $error"));
    }
  }
}
