import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/get_hotel_model.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/presentaion/manager/room_view_cubit/rooms_view_states.dart';

class RoomsViewCubit extends Cubit<RoomsViewState>{
  RoomsViewCubit():super(InitialRoomsViewState());
  List<String>facilityStringList=[];
  Future<void> loadFacilityFromLocal(BuildContext context,HotelsModel model)async{
    emit(LoadingFacilityDataState());
    DefaultAssetBundle.of(context).loadString('assets/hotels/facilities.json').then((value){
      var response=json.decode(value);
      for (var item in model.facilitiesList??[]){
        for(var element in response['facilities']){
          if(item.facilityGroupCode==element['facilityGroupCode']&&item.facilityCode==element['code']){
            facilityStringList.add(element['description']['content']);
            break;
          }
        }
      }
      emit(SuccessFacilityDataState());
    }).catchError((e){
      emit(FailureFacilityDataState(errMessage: e.toString()));
    });
  }
}