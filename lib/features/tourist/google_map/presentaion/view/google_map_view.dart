import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prepare_project/features/tourist/google_map/presentaion/manager/map_cubit/google_map_cubit.dart';
import 'package:prepare_project/features/tourist/google_map/presentaion/manager/map_cubit/google_map_states.dart';
class GoogleMapView extends StatelessWidget {
  const GoogleMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context)=>GoogleMapCubit()..requestAllowLocation(),
      child:BlocConsumer<GoogleMapCubit,GoogleMapStates>(builder:(context,state){
        var cubit=BlocProvider.of<GoogleMapCubit>(context);
        return GoogleMapBody(cubit: cubit,);
      } ,listener: (context,state){},),
    );
  }
}

class GoogleMapBody extends StatefulWidget {
  const GoogleMapBody({
    super.key,
    required this.cubit,
  });

  final GoogleMapCubit cubit;

  @override
  State<GoogleMapBody> createState() => _GoogleMapBodyState();
}

class _GoogleMapBodyState extends State<GoogleMapBody> {
  @override
  void initState() {
    updateMyLocation();
    super.initState();
  }
  @override
  void dispose(){
    super.dispose();
  }
  GoogleMapController? googleMapController;
  Set<Marker>markers={};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GoogleMap(
        onMapCreated:(controller){
          googleMapController=controller;
        },
        markers:markers,
        initialCameraPosition: const CameraPosition(zoom: 14,target:LatLng(29.97416777 ,31.1339477975),)
      ),
    );
  }

  void getPositionStream(){
    LocationSettings locationSetting=const LocationSettings(distanceFilter: 2,);
    Geolocator.getPositionStream(locationSettings: locationSetting).listen((locationData)
    {
      markers.add(Marker(markerId: const MarkerId('liveMarker'),position: LatLng(locationData.latitude, locationData.longitude)));
      setState(() {

      });
      googleMapController?.animateCamera(CameraUpdate.newLatLng(LatLng(locationData.latitude,locationData.longitude,)));
    });

  }

  void updateMyLocation() async {
    if(await widget.cubit.askToEnableMyLocation()){
      getPositionStream();
    }
  }
}
// Future<bool>askToEnableLocationServices()async{
//   bool serviceEnabled;
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled)
//   {
//     // emit(AllowLocationFailedState(errMessage:'Location services are disabled.Please Enable it.' ));
//     return false;
//   }
//   else{
//     return true;
//   }
// }
// Future<bool>askToEnableMyLocation()async{
//   LocationPermission permission;
//   if(await askToEnableLocationServices()){
//     permission = await Geolocator.checkPermission();
//     if(permission==LocationPermission.deniedForever){
//       // emit(AllowLocationFailedState());
//       return false;
//     }
//     else if (permission == LocationPermission.denied)
//     {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.always||permission==LocationPermission.whileInUse) {
//         // emit(AllowLocationSuccessState());
//         return true;
//       }
//       else{
//         // emit(AllowLocationFailedState());
//         return false;
//       }
//     }
//     else{
//       return true;
//     }
//   }
//   else{
//     // emit(AllowLocationFailedState());
//     return false;
//   }
// }
// Future<void> requestAllowLocation() async {
//   if(await askToEnableMyLocation()){
//     // enableMyLocation=true;
//   }
//   //   bool serviceEnabled;
//   //   LocationPermission permission;
//   //
//   //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   //   if (!serviceEnabled)
//   //   {
//   //     emit(AllowLocationFailedState(errMessage:'Location services are disabled.Please Enable it.' ));
//   //     return Future.error('Location services are disabled.Please Enable it.');
//   //   }
//   //   else {
//   //   permission = await Geolocator.checkPermission();
//   //   if (permission == LocationPermission.denied) {
//   //     permission = await Geolocator.requestPermission();
//   //     if (permission == LocationPermission.denied) {
//   //       emit(AllowLocationFailedState(errMessage:'Location permissions are denied' ));
//   //       return Future.error('Location permissions are denied');
//   //     }
//   //   }
//   //
//   //   if (permission == LocationPermission.deniedForever) {
//   //     emit(AllowLocationFailedState(errMessage:'Location permissions are permanently denied, we cannot request permissions.' ));
//   //     return Future.error(
//   //         'Location permissions are permanently denied, we cannot request permissions.');
//   //   }
//   //   if(permission == LocationPermission.always||permission==LocationPermission.whileInUse){
//   //     enableMyLocation=true;
//   //     // position=await Geolocator.getCurrentPosition();
//   //     emit(AllowLocationSuccessState());
//   //   }
//   // }
// }
