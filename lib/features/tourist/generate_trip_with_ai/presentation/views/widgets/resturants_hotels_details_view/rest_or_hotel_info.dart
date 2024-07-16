import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/tourist/nearby_places/data/models/nearby_places_model.dart';
import 'package:prepare_project/features/tourist/settings/presentaion/views/widgets/payment_setting_item.dart';
import 'package:url_launcher/url_launcher.dart';
class RestOrHotelInfo extends StatelessWidget {
  const RestOrHotelInfo({
    super.key,
    required this.width,
    required this.height,
    required this.model,
  });

  final double width;
  final double height;
  final NearbyPlacesModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: width*0.6,
                  child: Text('${model.displayName}',style: CustomTextStyle.fontBold21,)),
              Container(
                width: width*0.25,
                padding:const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: commonBorderRadius(),
                  color: thirdColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    const Icon(Icons.star,color: goldenColor,),
                    const SizedBox(width: 5,),
                    Text('${model.rating}',style: CustomTextStyle.fontBold16,)

                  ],),
              )

            ],),
          SizedBox(height: height*0.02,),
           Row(
            children: [
              const Icon(Icons.location_on_rounded,color: entertainmentColor,),
              SizedBox(
                  width: width*0.8,
                  child: Text('${model.address}',style: CustomTextStyle.font14Light,overflow: TextOverflow.ellipsis,maxLines: 2,))
            ],
          ),
          SizedBox(height: height*0.02,),
           Row(
            children: [
              const Icon(Icons.restaurant_menu_outlined,color: entertainmentColor,),
              Text('${model.displayType}',style: CustomTextStyle.font14Light)
            ],
          ),
          SizedBox(height: height*0.02,),
          ProfileSettingItem(text: 'Price',child: Text(model.priceLevel??"UnKnown",style: CustomTextStyle.fontNormal16,),),
          SizedBox(height: height*0.02,),
           Text('Social Contact',style: CustomTextStyle.fontNormal16),
          ProfileSettingItem(
            rightWidget: Row(
              children: [
                 model.nationalPhoneNum!=null?
                 IconButton(onPressed: ()async{
                   final url = 'tel:${model.nationalPhoneNum}';
                   if (await canLaunchUrl(Uri.parse(url))) {
                   await launchUrl(Uri.parse(url));
                   } else {
                   throw 'Could not launch $url';
                   }
                 }, icon:const Icon(Icons.phone))
                     :const SizedBox(),
                 model.websiteUri!=null?IconButton(onPressed: ()async{
                   final url=model.websiteUri;
                   if (await canLaunchUrl(Uri.parse(url!))) {
                     await launchUrl(Uri.parse(url));
                   } else {
                     throw 'Could not launch $url';
                   }
                 }, icon:const FaIcon(FontAwesomeIcons.globe)):const SizedBox(),
                ]
            ),),
        ],
      ),
    );
  }
}