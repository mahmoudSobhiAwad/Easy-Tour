import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/tourist/settings/presentaion/views/widgets/payment_setting_item.dart';
class RestOrHotelInfo extends StatelessWidget {
  const RestOrHotelInfo({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

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
                  child: const Text('مطعم قصر الكبابجي',style: CustomTextStyle.privateTourTitle,)),
              Container(
                width: width*0.25,
                padding:const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: commonBorderRadius(),
                  color: thirdColor,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Icon(Icons.star,color: goldenColor,),
                    SizedBox(width: 5,),
                    Text('4.4',style: CustomTextStyle.commonSignDark,)

                  ],),
              )

            ],),
          SizedBox(height: height*0.02,),
          const Row(
            children: [
              Icon(Icons.location_on_rounded,color: entertainmentColor,),
              Text('Giza,Egypt',style: CustomTextStyle.commonFontThinLight)
            ],
          ),
          SizedBox(height: height*0.02,),
          const Row(
            children: [
              Icon(Icons.restaurant_menu_outlined,color: entertainmentColor,),
              Text('Barbecue restaurant',style: CustomTextStyle.commonFontThinLight)
            ],
          ),
          SizedBox(height: height*0.02,),
          const ProfileSettingItem(text: 'Menu Price',child: Text('Medium Price',style: CustomTextStyle.commonSignThinDark,),),
          SizedBox(height: height*0.02,),
          const Text('Social Contact',style: CustomTextStyle.commonSignThinDark),
          // SizedBox(height: height*0.02,),
          ProfileSettingItem(
            rightWidget: Row(
              children: [...List.generate(2,(index){
                return const [IconButton(onPressed: null, icon:Icon(Icons.facebook,color: forthColor,size: 30,)),IconButton(onPressed: null, icon: FaIcon(FontAwesomeIcons.whatsapp,color: whatsAppColor,size: 30,),)][index];
              })],
            ),),
        ],
      ),
    );
  }
}