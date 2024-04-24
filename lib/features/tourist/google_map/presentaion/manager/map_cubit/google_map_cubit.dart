import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:prepare_project/features/tourist/google_map/data/models/route_poly_lines_model.dart';
import 'package:prepare_project/features/tourist/google_map/data/models/text_search_model.dart';
import 'package:prepare_project/features/tourist/google_map/data/repo/text_search_repo/text_search_repo_imp.dart';
import 'package:prepare_project/features/tourist/google_map/presentaion/manager/map_cubit/google_map_states.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../../core/utilities/basics.dart';
import '../../../../../../core/utilities/function/decode_poly_lines.dart';

class GoogleMapCubit extends Cubit<GoogleMapStates>{
  GoogleMapCubit({required this.textSearchRepoImp}):super(InitialGoogleMapState());
  Set<Marker>markers={};
  List<TextSearchModel>textSearchList=[];
  List<RoutePolyLinesModel>routePolyLinesList=[];
  final GoogleSearchRepoImp textSearchRepoImp;
  TextEditingController textController=TextEditingController();
  bool enableMyLocation=false;
  Position? myLocation;
  bool enableLiveLocation=false;
  List<LatLng> routePoly=[];
  Timer?debounce;
  Set<Polyline>polyLinesSets={};
  void initPolyLines() {
    polyLinesSets.clear();
    Polyline polyline=Polyline(
      width: 5,
      jointType: JointType.bevel,
      color: closeColor,
      endCap: Cap.squareCap,
      polylineId: const PolylineId('1'),
      points: routePoly,
    );
    polyLinesSets.add(polyline);
  }
  void enableLiveLocationMethod(){
    enableLiveLocation=true;
  }
  void getMarkAtSpecificLatLng(Set<Marker>markers,LatLng latLng){
    markers.add(Marker(markerId: const MarkerId('new place'),position: latLng));
    if(markers.contains(const Marker(markerId: MarkerId('markerRoute')))){
      markers.remove(const Marker(markerId: MarkerId('markerRoute')));
    }
    emit(AddNewMarkersWhenPushOnMap());
  }
  Future<bool>askToEnableLocationServices()async{
    bool serviceEnabled;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled)
    {
      emit(AllowLocationFailedState(errMessage:'Location services are disabled.Please Enable it.' ));
      return false;
    }
    else{
      return true;
    }
  }

  Future<bool>askToEnableMyLocation()async{
    LocationPermission permission;
    if(await askToEnableLocationServices()){
      permission = await Geolocator.checkPermission();
      if(permission==LocationPermission.deniedForever){
        emit(AllowLocationFailedState());
        return false;
      }
      else if (permission == LocationPermission.denied)
      {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.always||permission==LocationPermission.whileInUse) {
          myLocation=await Geolocator.getCurrentPosition();
          emit(AllowLocationSuccessState());
          return true;
        }
        else{
          emit(AllowLocationFailedState());
        return false;
        }
      }
      else{
        return true;
      }
    }
    else{
      emit(AllowLocationFailedState());
    return false;
    }
  }

  Future<void> requestAllowLocation() async {
    if(await askToEnableMyLocation()){
      enableMyLocation=true;
    }
  }

  Future<void>getListOfTextSearch()async{
    textSearchList.clear();
    if(textController.text.isNotEmpty&&textController.text.trim().isNotEmpty){
      if(debounce?.isActive??false){
        debounce?.cancel();
      }
      else{
        debounce=Timer(const Duration(milliseconds: 250), () async{
          emit(LoadingGetTextSearchList());
          var result=await textSearchRepoImp.getTextSearchList({'textQuery':textController.text});
          result.fold(
                  (failure){
                emit(FailureGetTextSearchList(errMessage: failure.errMessage));
              },
                  (result) {
                textSearchList.clear();
                for(var item in result){
                  textSearchList.add(item);
                }
                enableLiveLocation=false;
                emit(SuccessGetTextSearchList());
              });
        });
      }
    }
    else{
      textSearchList.clear();
      emit(ClearAllPlacesSearchList());
    }
  }
  Future<void>getListOfRoutes(int index)async{
    RoutePolyLinesModel model=RoutePolyLinesModel();
    emit(LoadingGetRoutePolyLinesList());
    var result=await textSearchRepoImp.getRoutePolyLines(model.toJson(
        destination: OriginOrDestinationModel(latitude:textSearchList[index].locationModel?.lat ,longitude:textSearchList[index].locationModel?.long),
        origin: OriginOrDestinationModel(longitude: myLocation?.longitude,latitude:myLocation?.latitude )));
    result.fold(
            (failure){
          emit(FailureGetRoutePolyLinesList(errMessage: failure.errMessage));
        },
            (result) {
              routePolyLinesList.clear();
              routePoly.clear();
              for(var item in result){
                routePolyLinesList.add(item);
              }
              enableLiveLocation=false;
              emit(SuccessGetRoutePolyLinesList());
        });
  }
  void makeMarkerAndAnimateToNewPlace(int index,{Set<Marker>? markers,GoogleMapController?controller}){
    textController.clear();
    emit(ClearAllPlacesSearchList());
    LatLng latLng=LatLng(textSearchList[index].locationModel!.lat!,textSearchList[index].locationModel!.long!);
    markers?.add(Marker(markerId: const MarkerId('markerRoute'),position:latLng));
    controller?.animateCamera(CameraUpdate.newLatLngZoom(latLng, 12));
    emit(UpdateLatLngBoundsAfterGetRoute());
  }
  /// while tap on direction
  void drawRoute(GoogleMapController? controller){
    routePoly.clear();
    routePoly = decodePolyline(routePolyLinesList[0].polyLineModel!.encodedPolyLine!);
    initPolyLines();
    if(controller!=null){
      LatLngBounds bounds=LatLngBounds(southwest:getSouthAndNorthEastBounds(routePoly)['southEast']!, northeast:getSouthAndNorthEastBounds(routePoly)['northEast']!);
      controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 16));
      emit(UpdateLatLngBoundsAfterGetRoute());
    }
  }

}


