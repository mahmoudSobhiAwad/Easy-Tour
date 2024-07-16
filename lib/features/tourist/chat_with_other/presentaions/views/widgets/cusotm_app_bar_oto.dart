import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/views/widgets/guide_profile_from_toursit_view.dart';
import 'package:prepare_project/features/tourist/profile/presentation/views/widgets/pic_profile_widget.dart';

class CustomChatOneToOneAppBar extends StatelessWidget {
  const CustomChatOneToOneAppBar({
    super.key,
    required this.height,
    required this.width,
    this.profileUrl,
    this.name,
    this.status,
    required this.email,
  });

  final double height;
  final double width;
  final String?profileUrl;
  final String?name;
  final String?status;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Container(
      height:height*0.08,
      width: width,
      decoration: const BoxDecoration(
        color: Colors.white,
        border:Border(bottom: BorderSide(color:secondaryColor)),
      ),
      child: Row(
        children: [
          IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: const Icon(Icons.arrow_back_ios_new,color: basicColor,)),
          ProfilePicWidget(imageUrl: profileUrl??'', height: height*0.06,),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0,left: 5),
            child: SizedBox(
              width: width*0.4,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Text(name??"",style: CustomTextStyle.fontNormal14WithEllipsis.copyWith(color: basicColor),),
                    Icon(Icons.circle,color: status=='Online'?whatsAppColor:closeColor,size: 15,),
                  ],
                ),
              ),
            ),
          ),
          const Spacer(),
          IconButton(onPressed:(){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewGuideProfileFromTouristView(email: email)));
          } ,padding: EdgeInsets.only(right: 10),icon:Icon(Icons.info,color: basicColor,size: 30,)),
        ],
      ),
    );
  }
}