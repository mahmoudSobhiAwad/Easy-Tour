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
  bool isFirstCall=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GoogleMap(
        onMapCreated:(controller){
          googleMapController=controller;
        },
        markers:markers,
        initialCameraPosition: const CameraPosition(zoom: 1,target:LatLng(29.97416777 ,31.1339477975),)
      ),
    );
  }

  void getPositionStream()async{
    LocationSettings locationSetting=const LocationSettings(distanceFilter: 2,);
    BitmapDescriptor iconImage=BitmapDescriptor.fromBytes(await getImageFormRawData('assets/google_map_assets/live location.png', 100));
    Geolocator.getPositionStream(locationSettings: locationSetting).listen((locationData)
    {
      markers.add(Marker(infoWindow: const InfoWindow(title: 'My Location'),icon:iconImage,markerId: const MarkerId('liveMarker'),position: LatLng(locationData.latitude, locationData.longitude)));
      if(mounted){
        setState(() {
        });
        if(isFirstCall){
          googleMapController?.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(zoom: 17,target: LatLng(locationData.latitude,locationData.longitude,))));
        }
        else{
          googleMapController?.animateCamera(CameraUpdate.newLatLng(LatLng(locationData.latitude,locationData.longitude,)));
        }
      }

    });

  }

  void updateMyLocation() async {
    if(await widget.cubit.askToEnableMyLocation()){
      getPositionStream();
    }
  }
}
