import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prepare_project/core/utilities/function/crop_image.dart';
import 'package:prepare_project/features/tour_guide/private_tour/data/model/private_tour_model.dart';
import 'package:prepare_project/features/tour_guide/private_tour/data/repos/private_tour_repo.dart';
import 'package:prepare_project/features/tour_guide/private_tour/presentation/manager/edit_create_tour/edit_create_state.dart';
class CreateEditPrivateTourCubit extends Cubit<CreateEditPrivateTourState>{
  CreateEditPrivateTourCubit({required this.privateTourRepo,this.trip}):super(InitialCreateEditPrivateState());
  TextEditingController  titleTextController=TextEditingController();
  TextEditingController  briefTextController=TextEditingController();
  TextEditingController  pricePerPersonTextController=TextEditingController();
  TextEditingController  minimumPersonTextController=TextEditingController();
  String bgPath='';
  final ImagePicker picker=ImagePicker();
  File?bgFile;
  ///new
  bool isLoading=false;
  bool showAddDay=false;
  bool editDay=false;
  String?tripId;
  PrivateTourRepo privateTourRepo;
  Trip? trip;
  List<TripDay>tripDay=[];
  List<Place> places=[Place(placeName: '', placeType: '', activity: '')];
  void prepareFields(){
    if(trip!=null){
      tripId=trip?.tripId;
      titleTextController.text=trip?.title??"";
      briefTextController.text=trip?.brief??"";
      tripDay.addAll(trip?.tripDetails??[]);
      minimumPersonTextController.text=trip?.minimumNumber?.toString()??"";
      pricePerPersonTextController.text=trip?.ticketPerPerson?.toString()??"";
      bgPath=trip?.bgImagePath??'';
    }
  }
  void clearPlaceInOneDay(int index){
    places.removeAt(index);
    emit(AddAnotherPlaceInOneDay());
  }
  void deleteImage() {
    if(bgPath!=''&&bgFile?.path==null){
      bgPath='';
    }
    else if(bgFile?.path!=null){
      bgFile=null;
    }
    emit(DeleteBGTourState());

  }
  Future<void> getImageFromCamera()async{
    XFile? imageCamera=await picker.pickImage(source:ImageSource.camera);
    if(imageCamera!=null){
      bgFile=File(imageCamera.path);
      emit(GetImageFromCameraState());
    }
  }
  Future<void> getImageFromGallery()async{
    XFile? imageGallery=await picker.pickImage(source:ImageSource.gallery);
    if(imageGallery!=null){
      bgFile=File(imageGallery.path);
      emit(GetImageFromGalleryState());
    }

  }
  Future<void> cropImage()async{
    if(bgPath!=''){
     bgFile =File.fromUri(Uri.parse(bgPath));
      final cropFile=await getImageCropped(bgFile!.path);
      if(cropFile!=null){
        bgFile=File(cropFile.path);
        emit(EditBGTourSuccessState());
      }
    }
    else if(bgFile?.path!=null){
      final cropFile=await getImageCropped(bgFile!.path);
      if(cropFile!=null){
        bgFile=File(cropFile.path);
        emit(EditBGTourSuccessState());
      }
    }

  }
  void addNewPlaceInNewDay()
  {
    places.add(Place(placeName: '',placeType: '',activity: ''));
    emit(AddAnotherPlaceInOneDay());
  }

  void addNewPlaceInExistedDay(int index){
    tripDay[index].dayPlaces?.add(Place(placeName: '',placeType: '',activity: ''));
    emit(AddAnotherPlaceInOneDay());
  }

  void addTripDay(int index)
  {
    tripDay.add(TripDay(dayName:'Day${tripDay.length+1}' ,dayPlaces:places));
    emit(AddDetailsDaySuccessState());
    places=[Place(placeName: '',placeType: '',activity: '')];

  }

  void removeTripDay(int index){
    tripDay.removeAt(index);
    emit(RemoveDetailsDaySuccessState());
  }

  Future<void> createNewTrip() async {
    trip=Trip(
      title: titleTextController.text,
      brief:briefTextController.text,
      bgImagePath: bgFile?.path,
      minimumNumber:num.parse(minimumPersonTextController.text),
      ticketPerPerson: double.parse(pricePerPersonTextController.text),
      tripDetails: tripDay,
    );
    isLoading=true;
    emit(LoadingCreateTrip());
    var result=await privateTourRepo.createPrivateTrip(tripModel: await trip!.toFormData());
    result.fold(
            (failure){
              if(failure.statusCode==401){
                createNewTrip();
              }
              isLoading=false;
              emit(FailureCreateTrip(errMessage: failure.errMessage));
    },
            (trip) {
              isLoading=false;
              emit(SuccessCreateTrip());
    });
  }


  Future<void> editCurrentTrip() async {
    isLoading=true;
    trip=Trip(
      tripId: tripId,
      title: titleTextController.text,
      brief:briefTextController.text,
      bgImagePath: bgFile?.path,
      minimumNumber:num.parse(minimumPersonTextController.text),
      ticketPerPerson: num.parse(pricePerPersonTextController.text),
      tripDetails: tripDay,
    );
    emit(LoadingEditTrip());
    var result=await privateTourRepo.editPrivateTrip(tripModel: await trip!.updateTrip());
    result.fold(
            (failure){
              if(failure.statusCode==401){
                editCurrentTrip();
              }
    isLoading=false;
    emit(FailureEditTrip(errMessage: failure.errMessage));
    },
            (trip) {

    isLoading=false;
    emit(SuccessEditTrip());
    });

  }
  void changeShowAddDays(){
    showAddDay=!showAddDay;
    emit(ChangeShowAddDayState());
  }
  bool checkIsThereChanges(){
    if(trip?.brief==briefTextController.text&&trip?.title==titleTextController.text
        &&bgFile==null
    ) {
      return false;
    }
    return true;
  }

}