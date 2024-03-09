import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/constant_var/constant.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/tour_guide/private_tour/data/model/private_tour_model.dart';
import 'package:prepare_project/features/tour_guide/private_tour/presentation/view/widgets/tour_info_without_image.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/views/widgets/request_trip_view.dart';
import 'package:prepare_project/features/tourist/profile/presentation/views/widgets/pic_profile_widget.dart';
class OneTourGuideTripForTourist extends StatelessWidget {
  const OneTourGuideTripForTourist({super.key,required this.width,required this.height,this.model});
  final double height;
  final double width;
  final Trip? model;
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
                    child: model?.bgImagePath!=''?Image.network(model!.bgImagePath!,fit: BoxFit.cover,height:height*0.15,width: width,):
                    Image.network(defaultCoverTrip,fit: BoxFit.cover,height:height*0.15,width: width,)
                ),
                PrivateTourWithoutImage(height: height, width: width,model: model,moreDet: true,text: 'Start With',),
                SizedBox(height: height*0.02,),
                CustomLoginButton(color: forthColor,label: 'Request',onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return const RequestTripView();
                  }));
                },),
              ],
            ),
          ),
          // Positioned(
          //   top: height*0.04,
          //   child: SizedBox(
          //     width: width*0.7,
          //     child: Wrap(
          //       runSpacing: 5,
          //       spacing: 5,
          //       children: [
          //         ...List.generate(5, (index) {
          //           if(index==4){
          //             return Container(
          //               width: width*0.25,
          //               padding: const EdgeInsets.all(5),
          //               decoration: BoxDecoration(color: forthColor,borderRadius: commonBorderRadius()),
          //               child: Row(
          //                 children: [
          //                   Text('show less',style: CustomTextStyle.commonFontThin.copyWith(color: Colors.white,fontSize: 10),),
          //                   const Icon(Icons.keyboard_arrow_up_rounded,color: Colors.white,),
          //                 ],
          //               ),
          //             );
          //           }
          //           else{
          //             return Container(
          //               width: width*0.2,
          //               height: height*0.05,
          //               padding:const EdgeInsets.all(5),
          //               decoration: BoxDecoration(
          //                   color: forthColor,borderRadius: commonBorderRadius()),
          //               child: Text('Cultural',style: CustomTextStyle.commonSignLight.copyWith(color: Colors.white),),
          //             );
          //           }
          //         },
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          Positioned(
              left: width*0.68,
              top: height*0.08,
              child: ProfilePicWidget(height: height*0.1, imageUrl: imagePath??"",)),
        ],
      ),
    );
  }
}