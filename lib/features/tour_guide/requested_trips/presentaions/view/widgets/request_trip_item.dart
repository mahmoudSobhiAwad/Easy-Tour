import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tour_guide/requested_trips/data/models/handle_request_model.dart';
import 'package:prepare_project/features/tourist/profile/presentation/views/widgets/pic_profile_widget.dart';
class RequestedTripForGuideItemWidget extends StatelessWidget {
  const RequestedTripForGuideItemWidget({super.key,required this.height,required this.width,required this.model});
  final double height;
  final double width;
  final RequestsTripForTGModel model;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: SizedBox(
        width: width,
        height: height*0.1,
        child: ListTile(
          leading: ProfilePicWidget(imageUrl:model.requestedBy?.image??"", height: height*0.07),
          title:  Text(model.requestedBy?.userName??"unKnown",style:CustomTextStyle.commonSignDark,),
          subtitle: SizedBox(width: width*0.5,child: const Text('Send You request to book a trip',style: CustomTextStyle.commonFontThinLight,)),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Sun 12:40 PM',style: CustomTextStyle.commonSignLight.copyWith(fontSize: 12),),
              getRequestStatusWidget(context, model.requestStatus??"notHandled"),
            ],
          ),
        ),
      ),
    );
  }
}
Widget getRequestStatusWidget(BuildContext context,String status){
  if(status=='notHandled'){
    return const CircleAvatar(backgroundColor: forthColor,radius: 7.5,);
  }
  else if(status=='accepted'){
    return const Icon(Icons.check,color: whatsAppColor,);
  }
  else {
    return const CircleAvatar(backgroundColor: closeColor,child: Icon(Icons.close,color: Colors.white,),);
  }
}