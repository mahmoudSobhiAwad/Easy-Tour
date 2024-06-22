import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/login_sign_up/create_acc_title.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
class GenerateAiTripIntro extends StatelessWidget {
  const GenerateAiTripIntro({
    super.key,
    required this.height,
    required this.width,
    required this.onTap,
  });

  final double height;
  final double width;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset('assets/tourist_home/generate_trip.jpg',fit: BoxFit.fitHeight,height: height,width: width,),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: height*0.1),
            child: Container(
              height: height*0.2,
              width: width,
              padding:const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  boxShadow:[
                    BoxShadow(
                      color:const Color(0xff000000).withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 4),
                    )],
                  borderRadius: BorderRadius.circular(30),
                  color: const Color(0xffFFE7CD).withOpacity(0.7)),
              child:  TitleOfCreateAcc(mainStyle: CustomTextStyle.fontGrover30.copyWith(color: Colors.black),
                secondaryStyle: CustomTextStyle.fontBold16.copyWith(color: Colors.black),
                mainText: 'Plan Your Trip With AI',
                secondaryText: 'you can select the places you want to visit, the numbers of Days and the type of the tourism you prefer.',),
            ),
          ),
        ),
        Padding(
          padding:  const EdgeInsets.only(bottom: 30),
          child:  Align(
              alignment: Alignment.bottomCenter,
              child: CustomLoginButton(label: 'let’s Go',color: const Color(0xff000000),onTap: onTap,enable: true,altWidth: width*0.5,)),
        )
      ],
    );
  }
}