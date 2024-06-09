import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/delete_account/presentation/view/delete_acc_view.dart';
import 'package:prepare_project/features/tourist/settings/presentaion/views/widgets/payment_setting_item.dart';
import 'package:prepare_project/features/tourist/settings/presentaion/views/widgets/setting_details_view.dart';

import '../../../../../../core/utilities/basics.dart';

class GeneralSettings extends StatelessWidget {
  const GeneralSettings({super.key,required this.height,});
  final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height*0.33,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('General Settings',style: CustomTextStyle.fontNormal16,),
          const Expanded(child:  SizedBox(height: 10,)),
          ...List.generate(4, (index) => GestureDetector(
            onTap: [
                  (){},
                  (){},
                  (){},
                  (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return SettingDetailsView(appBarTitle: 'Delete Account', child: DeleteAccountView( height: height));
                    }));
                  },
            ][index],
            child: ProfileSettingItem(
              height: height*0.07,
              text: ['Support','Help','FAQ','delete account'][index],
              child: const [
                Icon(Icons.arrow_forward_ios,color: basicColor,),
                Icon(Icons.arrow_forward_ios,color: basicColor,),
                Icon(Icons.arrow_forward_ios,color: basicColor,),
                Icon(Icons.delete_rounded,color: closeColor,),
              ][index],
            ),
          ),
          ),
        ],
      ),
    );
  }
}