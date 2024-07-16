import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/tourist/booking_collection/booking_hotels/data/models/get_hotel_model.dart';
import 'package:url_launcher/url_launcher.dart';
class ContactInfoWithSocialInfo extends StatelessWidget {
  const ContactInfoWithSocialInfo({super.key,required this.height,required this.width,this.phonesList,this.webUrl});
  final double height;
  final double width;
  final String?webUrl;
  final List<PhoneModel>?phonesList;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        phonesList!=null?
        SizedBox(
          height: height*0.15,
          child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context,index){
                return Container(
                  decoration: BoxDecoration(
                    color: thirdColor,
                    borderRadius: commonBorderRadius(),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.headset_mic_rounded,color: basicColor,),
                      Text('${phonesList?[index].phoneType}',style: CustomTextStyle.fontBold14.copyWith(color: basicColor),),
                      Text('${phonesList?[index].phoneNum}',style: CustomTextStyle.fontBold14.copyWith(color: basicColor),),
                    ],
                  ),
                );
              }, separatorBuilder: (context,index){
            return SizedBox(width: width*0.05,);
          }, itemCount: phonesList!.length),
        ) :
        const SizedBox(),
        SizedBox(height: height*0.025,),
        webUrl!=null?
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Visit Us'),
            SizedBox(width: width*0.075,),
            IconButton(onPressed: ()async{
              Uri url=Uri.parse(webUrl!);
              if (!await launchUrl(url)) {
                throw Exception('Could not launch $url');
              }
              }, icon:  const FaIcon(FontAwesomeIcons.globe),)
          ],
        ) :
        const SizedBox()
      ],
    );
  }
}