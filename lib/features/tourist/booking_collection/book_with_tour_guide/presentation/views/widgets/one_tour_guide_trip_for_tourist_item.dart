// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/tour_guide/private_tour/data/model/private_tour_model.dart';
import 'package:prepare_project/features/tour_guide/private_tour/presentation/view/widgets/tour_info_without_image.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/views/widgets/guide_profile_from_toursit_view.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/views/widgets/request_trip_widgets/request_trip_view.dart';
import 'package:prepare_project/features/tourist/profile/presentation/views/widgets/pic_profile_widget.dart';
class OneTourGuideTripForTourist extends StatelessWidget {
  const OneTourGuideTripForTourist({super.key,required this.width,required this.height,this.model,this.viewProfile=true});
  final double height;
  final double width;
  final Trip? model;
  final bool viewProfile;
  @override
  Widget build(BuildContext context) {
    final String?imagePath=model?.guidePic;
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Stack(
        children: [
          Container(
            width: width,
            padding: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(color: thirdColor,borderRadius: commonBorderRadius()),
            child: Column(
              children: [
                ClipRRect(
                    borderRadius: const BorderRadius.only(topLeft:Radius.circular(20) ,topRight:Radius.circular(20)),
                    child: model?.bgImagePath!=''?Image.network(model!.bgImagePath!,fit: BoxFit.cover,height:height*0.15,width: width,errorBuilder: (context,_,s){
                      return const Center( child: Icon(Icons.warning,color: goldenColor,size: 40,));
                    }):
                    Image.network(defaultCoverTrip,fit: BoxFit.cover,height:height*0.15,width: width,)
                ),
                PrivateTourWithoutImage(height: height, width: width,model: model,moreDet: true,text: 'Start With',),
                SizedBox(height: height*0.02,),
                CustomLoginButton(color: forthColor,label: 'Request',onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return RequestTripView(tripId: model!.tripId!,tripTicket: model?.tripTicket,tripDays: model?.tripDetails?.length.toString(),);
                  }));
                },),
              ],
            ),
          ),
          viewProfile?
          Positioned(
              left: width*0.68,
              top: height*0.08,
              child: GestureDetector(
                  onTap:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewGuideProfileFromTouristView(email: model?.guideEmail??"",)));
                  },
                  child: ProfilePicWidget(height: height*0.1, imageUrl: "https://1.bp.blogspot.com/-Vj0Gxg73G1Q/VlS_uddJciI/AAAAAAAAAQQ/4CrBYorGi7U/s1600-r/hatsh.jpg",))) :
          const SizedBox(),
        ],
      ),
    );
  }
}