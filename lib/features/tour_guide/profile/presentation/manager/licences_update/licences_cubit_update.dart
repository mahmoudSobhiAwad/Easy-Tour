import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/features/tour_guide/profile/presentation/manager/licences_update/licences_state_update.dart';

class LicencesCubit extends Cubit<LicencesStates>{
  LicencesCubit():super(InitialLicencesState());
  FilePickerResult? result;
  File?cvFile;
  void pickFile()async{
    result=await FilePicker.platform.pickFiles();
    if(result!=null){
      emit(ChangeUpdateButtonColorLicencesState());
      cvFile=File(result!.files.single.path!);
    }
  }
}