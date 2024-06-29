import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prepare_project/core/utilities/function/crop_image.dart';
import 'package:prepare_project/features/tour_guide/private_tour/data/data_ui.dart';
import 'package:prepare_project/features/tour_guide/private_tour/data/model/private_tour_model.dart';
import 'package:prepare_project/features/tour_guide/private_tour/data/repos/private_tour_repo.dart';
import 'package:prepare_project/features/tour_guide/private_tour/presentation/manager/edit_create_tour/edit_create_state.dart';
import '../../../../../tourist/generate_trip_with_ai/data/model/type_of_places_toursim.dart';
class CreateEditPrivateTourCubit extends Cubit<CreateEditPrivateTourState> {
  CreateEditPrivateTourCubit({required this.privateTourRepo,this.trip}):super(InitialCreateEditPrivateState());
  TextEditingController  titleTextController=TextEditingController();
  TextEditingController  briefTextController=TextEditingController();
  TextEditingController  includedTextController=TextEditingController();
  TextEditingController  excludedTextController=TextEditingController();
  TextEditingController  maxPersonTextController=TextEditingController();
  String bgPath='';
  final ImagePicker picker=ImagePicker();
  File?bgFile;
  bool isLoading=false;
  bool showAddDay=false;
  bool editDay=false;
  String?tripId;
  int pickedPlane=0;
  PrivateTourRepo privateTourRepo;
  Trip? trip;
  List<TripDay>tripDay=[];
  List<dynamic>included=[];
  List<dynamic>excluded=[];
  int currDay=0;
  List<TextEditingController>planeController=[
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  List<TripPlace> places=[TripPlace(placeName: '', placeType: '', activity: '')];
  List<TypeOfTourism>planType=[
    TypeOfTourism(typeImage: standardPlan, typeName: 'standard', picked: true),
    TypeOfTourism(typeImage: comfortPlan, typeName: 'comfort', picked: false),
    TypeOfTourism(typeImage: luxuryPlan, typeName: 'VIP', picked: false),
  ];
  void prepareFields(){
    if(trip!=null){
      tripId=trip?.tripId;
      titleTextController.text=trip?.title??"";
      briefTextController.text=trip?.brief??"";
      tripDay.addAll(trip?.tripDetails??[]);
      maxPersonTextController.text=trip?.maximumNumber?.toString()??"";
      bgPath=trip?.bgImagePath??'';
      planeController[0].text=trip?.tripTicket?['standard']?.toString()??"";
      planeController[1].text=trip?.tripTicket?['luxury'].toString()??"";
      planeController[2].text=trip?.tripTicket?['VIP'].toString()??"";
      included=trip?.included??[];
      excluded=trip?.excluded??[];
    }
  }
  void goToSelectedDay(int index)
  {
    currDay=index;
    emit(MoveToNextDayOfTripDays());
  }
  void clearPlaceInOneDay(int index){
    places.removeAt(index);
    emit(AddAnotherPlaceInOneDay());
  }
  void removeSpecificTripFromDay(int dayIndex,int tripIndex){
   tripDay[dayIndex].dayPlaces?.removeAt(tripIndex);
   if(tripDay[dayIndex].dayPlaces!.isEmpty)
   {
     tripDay.removeAt(dayIndex);
   }
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
    places.add(TripPlace(placeName: '',placeType: '',activity: ''));
    emit(AddAnotherPlaceInOneDay());
  }

  void addNewPlaceInExistedDay(int index){
    tripDay[index].dayPlaces?.add(TripPlace(placeName: '',placeType: '',activity: ''));
    emit(AddAnotherPlaceInOneDay());
  }

  void addTripDay(int index)
  {
    tripDay.add(TripDay(dayName:'Day${tripDay.length+1}',dayPlaces:places));
    emit(AddDetailsDaySuccessState());
    places=[TripPlace(placeName: '',placeType: '',activity: '')];

  }

  // void removeTripDay(int index){
  //   tripDay.removeAt(index);
  //   emit(RemoveDetailsDaySuccessState());
  // }
  void changeTypeDay(){
    emit(ChangePlaceTypeInTripDayState());
  }
  Future<void> createNewTrip() async {
    trip=Trip(
      // included: included,
      // excluded: excluded,
      title: titleTextController.text,
      brief:briefTextController.text,
      bgImagePath: bgFile?.path,
      maximumNumber:num.parse(maxPersonTextController.text),
      tripDetails: tripDay,
      tripTicket: planeTicketMap(),
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
      included: included,
      excluded: excluded,
      tripId: tripId,
      title: titleTextController.text,
      brief:briefTextController.text,
      bgImagePath: bgFile?.path,
      maximumNumber:num.parse(maxPersonTextController.text),
      tripDetails: tripDay,
      tripTicket: planeTicketMap(),
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
  void addToIncludedList(){
    included.add(includedTextController.text);
    includedTextController.clear();
    emit(AddIncludedValueState());
  }
  void addToExcludedList(){
    excluded.add(excludedTextController.text);
    excludedTextController.clear();
    emit(AddExcludedValueState());
  }
  void removeFromIncludedList(int index){
    included.removeAt(index);
    emit(RemoveIncludedValueState());
  }
  void removeFromExcludedList(int index){
    excluded.removeAt(index);
    emit(RemoveExcludedValueState());
  }
  void changePickedCategory(int index){
    for(var item in planType){
      item.picked==true?item.picked=false:null;
    }
    planType[index].picked=true;
    pickedPlane=index;

    emit(ChangePlanTypePickedState());
  }
  Map<String,dynamic>planeTicketMap(){
    return {
      'standard':double.parse(planeController[0].text),
      'luxury':double.parse(planeController[1].text),
      'VIP':double.parse(planeController[2].text),
    };
  }
}