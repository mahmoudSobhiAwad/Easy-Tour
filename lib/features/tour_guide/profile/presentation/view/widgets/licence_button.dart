import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/views/widgets/show_licenece_for_tourist.dart';
import 'package:prepare_project/features/tourist/settings/presentaion/views/widgets/payment_setting_item.dart';
class LicenceButton extends StatelessWidget {
  const LicenceButton({
    super.key,
    required this.height,
    required this.width,
    this.licenceNames,
    this.cvUrl
  });

  final double height;
  final double width;
  final List<String>?licenceNames;
  final String?cvUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height*0.11,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          const Text('Licence',style: CustomTextStyle.commonSignThinDark),
          const Expanded(child:  SizedBox(height: 10,)),
          ProfileSettingItem(text: 'Ministry ID,Syndicate ID', onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowGuideLicenceForTourist(height: height,licences:licenceNames??[],width: width,cvUrl:cvUrl??"",)));
          },height: height*0.07,child: const Icon(Icons.arrow_forward_ios),),
        ],
      ),
    );
  }
}

