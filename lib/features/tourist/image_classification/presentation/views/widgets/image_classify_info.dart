import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
class ImageClassificationInfo extends StatelessWidget {
  const ImageClassificationInfo({super.key,required this.height,required this.width,required this.isVisible});
  final double height;
  final double width;
  final bool isVisible;
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isVisible?1:0,
      duration:const Duration(milliseconds: 500) ,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SizedBox(
          height: height*0.35,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Statue Name',style: CustomTextStyle.commonFontThin,),
              Container(
                height: height*0.07,
                width: width*0.4,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(blurRadius: 4,offset: Offset(0, 4)),
                  ],
                  color: thirdColor,
                  borderRadius: commonBorderRadius(),
                ),
                child:const Center(child:  Text('Akhenaton',style: CustomTextStyle.commonFontThin,)),
              ),
              const Expanded(child: SizedBox(height: 5,)),
              const Text('Statue Info',style: CustomTextStyle.commonFontThin,),
              Container(
                padding: const EdgeInsets.all(10),
                height: height*0.2,
                width: width,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(blurRadius: 4,offset: Offset(0, 4)),
                  ],
                  color: thirdColor,
                  borderRadius: commonBorderRadius(),
                ),
                child:const SingleChildScrollView(child: Text('that statue called king Akhenaton and he belongs to the fifth royal family fdakasfj fdkfskdfs fsdkfsdkfmksf fsdkfskfm fdksmfksm sdfkmsdk fmskfm sfkmsd fkmskfm sfsdkds dfkmskdmf sfksdfksd  fksdfsdk sfjdfkj sdf sdfkskfjs sfsdkds dfkmskdmf sfksdfksd  fksdfsdk sfjdfkj sdf sdfkskfjs sfsdkds dfkmskdmf sfksdfksd  fksdfsdk sfjdfkj sdf sdfkskfjs sfsdkds dfkmskdmf sfksdfksd  fksdfsdk sfjdfkj sdf sdfkskfjs sfsdkds dfkmskdmf sfksdfksd  fksdfsdk sfjdfkj sdf sdfkskfjs ',style: TextStyle(fontSize: 14,color: basicColor),)),
              ),
              const Expanded(child: SizedBox(height: 5,)),
            ],
          ),
        ),
      ),
    );
  }
}