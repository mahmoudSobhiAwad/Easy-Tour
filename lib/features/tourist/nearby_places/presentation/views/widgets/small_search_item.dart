import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/tourist/nearby_places/data/models/nearby_places_model.dart';
import 'package:prepare_project/features/tourist/settings/presentaion/views/widgets/payment_setting_item.dart';
import 'package:url_launcher/url_launcher.dart';

class OneSearchSmallItem extends StatelessWidget {
  const OneSearchSmallItem({
    super.key,
    required this.height,
    required this.width,
    required this.model,
  });

  final double height;
  final double width;
  final NearbyPlacesModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: thirdColor,
          borderRadius: commonBorderRadius(),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(model.displayType=='Bank'?'assets/payment_images/bank.png':'assets/payment_images/atm.png',height: height*0.1,),
          SizedBox(
              width: width*0.5,
              child: Text(model.displayName??"",style: CustomTextStyle.commonFontThin,overflow: TextOverflow.ellipsis,maxLines: 2,textAlign: TextAlign.center,)),
          Text(model.displayType??"",style: CustomTextStyle.commonFontThin,overflow: TextOverflow.ellipsis,maxLines: 1,),
          Text(model.openNow! ?'Open Now':'Closed',style: CustomTextStyle.commonFontThin.copyWith(color: model.openNow!?whatsAppColor:closeColor)),
          model.internationalPhoneNum!=null?
          GestureDetector(
            onTap: ()async{
              final url = 'tel:${model.internationalPhoneNum}';
              if (await canLaunchUrl(Uri.parse(url))) {
              await launchUrl(Uri.parse(url));
              } else {
              throw 'Could not launch $url';
              }
            },
            child: ProfileSettingItem(
              enableDivider: false,
              rightWidget:const Padding(
                padding: EdgeInsets.only(right: 5.0),
                child: Row(
                  children: [
                    Icon(Icons.phone),
                    Text('International'),
                  ],
                ),
              ),
              child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(model.internationalPhoneNum??"")),
            ),
          ) :
          const SizedBox(),
          model.nationalPhoneNum!=null?
          GestureDetector(
            onTap: ()async{
              final url = 'tel:${model.nationalPhoneNum}';
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url));
              } else {
                throw 'Could not launch $url';
              }
            },
            child: ProfileSettingItem(
              enableDivider: false,
              rightWidget:const Padding(
                padding: EdgeInsets.only(right: 5.0),
                child: Row(
                  children: [
                    Icon(Icons.phone),
                    Text('National'),
                  ],
                ),
              ),
              child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(model.nationalPhoneNum??"")),
            ),
          ):
          const SizedBox(),
          Container(
            padding: const EdgeInsets.all(3),
            height: height*0.04,
            width: width*0.2,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: commonBorderRadius(),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                Text('Let\'s Go',style:TextStyle(color: Colors.white,fontSize: 10),),
                Icon(Icons.arrow_forward_rounded,color: Colors.white,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
