import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
class CustomIntroScreen extends StatelessWidget {
  const CustomIntroScreen({super.key,required this.mainTitle,this.colorButton,required this.imagePath,required this.secondaryTitle,required this.screenToGo});
final String imagePath;
final String mainTitle;
final String secondaryTitle;
final void Function() screenToGo;
final Color?colorButton;
  @override
  Widget build(BuildContext context) {
    final double height =BasicDimension.screenHeight(context);
    final double width =BasicDimension.screenHeight(context);

    return  Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 20.0,right: 20,bottom: 20,top: height*0.08),
        child: Column(
          children: [
            Image.asset(imagePath,fit: BoxFit.fill,height: height*0.4,),
            SizedBox(
                width: width*0.6,
                child: Text(mainTitle,style: CustomTextStyle.resetPassTitle.copyWith(fontSize: 40),maxLines: 3,textAlign: TextAlign.center,)),
             SizedBox(height: height*0.05,),
            SizedBox(
                width: width*0.6,
                child: Text(secondaryTitle,style: CustomTextStyle.commonFontThinLight.copyWith(fontSize: 16),maxLines: 3,textAlign: TextAlign.center,)),
            const Expanded(child: SizedBox(height: 20,)),
            CustomLoginButton(altWidth: width*0.5,label: 'Let\'s Go',enable: true,onTap: screenToGo,color: colorButton,),
          ],
        ),
      ),
    );
  }
}
