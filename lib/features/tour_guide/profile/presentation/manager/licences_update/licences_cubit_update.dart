import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/features/tour_guide/profile/data/model/guide_personal_info_model.dart';
import 'package:prepare_project/features/tour_guide/profile/data/repos/tour_guide_profile_repo.dart';
import 'package:prepare_project/features/tour_guide/profile/presentation/manager/licences_update/licences_state_update.dart';
import 'package:url_launcher/url_launcher.dart';

class LicencesCubit extends Cubit<LicencesStates>{
  LicencesCubit({required this.tourGuideProfileRepo,this.cvUrl}):super(InitialLicencesState());
  FilePickerResult? result;
  File?cvFile;
  String?name;
  String?extension;
  String? cvUrl;
  bool isLoading=false;
  TourGuideProfileRepo tourGuideProfileRepo;
  void pickFile()async{
    result=await FilePicker.platform.pickFiles();
    if(result!=null){
      double fileLength=(result!.files.single.size)/1000;
      if(fileLength>1000){
        emit(FailureUpdateLicencesState(errMessage: 'the file exceed 1 Mb'));
      }
      else {
        cvFile=File(result!.files.single.path!);
        name=result!.files.single.name;
        extension=result!.files.single.extension;
        emit(ChangeUpdateButtonColorLicencesState());
      }
    }
  }
  void removePickedFile(){
    cvFile=null;
    emit(RemovedPickedFileState());
  }
  Future<void> updateCvInfo()async{
    isLoading=true;
    emit(LoadingUpdateLicencesState());
    FormData cvData= await TourGuidePersonalInfoModel(
      cvFile:cvFile?.path,
    ).updateCvFile();
    var result=await tourGuideProfileRepo.updateCvFile(infoModel: cvData);
    result.fold(
            (failure) {
              isLoading=false;
              emit(FailureUpdateLicencesState(errMessage: failure.errMessage));
            },
            (success){
              isLoading=false;
              emit(SuccessUpdateLicencesState());

    });

  }
  Future<void> downloadAndOpenFile() async {
    Uri url=Uri.parse(cvUrl!);
    try {
      await launchUrl(url,mode: LaunchMode.externalNonBrowserApplication);
    } catch (error) {
      emit(FailureUpdateLicencesState(errMessage: "Error launching URL: $error"));
    }

  }

}