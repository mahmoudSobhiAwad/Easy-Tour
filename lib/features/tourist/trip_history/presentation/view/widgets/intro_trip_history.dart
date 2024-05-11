import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/tourist/trip_history/presentation/view/trip_history_view.dart';
class TripHistoryIntroView extends StatelessWidget {
  const TripHistoryIntroView({super.key});

  @override
  Widget build(BuildContext context) {
    final double height =BasicDimension.screenHeight(context);
    final double width =BasicDimension.screenHeight(context);

    return  Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 20.0,right: 20,bottom: 20,top: height*0.08),
        child: Column(
          children: [
            Image.asset('assets/tourist_home/trip_intro.png',fit: BoxFit.fill,height: height*0.4,),
            SizedBox(
                width: width*0.6,
                child: Text('Manage Your Trips',style: CustomTextStyle.resetPassTitle.copyWith(fontSize: 40),maxLines: 2,textAlign: TextAlign.center,)),
            const SizedBox(height: 10,),
            SizedBox(
                width: width*0.6,
                child: const Text('You can organize your trips by adding your tasks into separate categories',style: CustomTextStyle.commonSignDark,maxLines: 3,textAlign: TextAlign.center,)),
            const Expanded(child: SizedBox(height: 20,)),
            CustomLoginButton(altWidth: width*0.5,label: 'Let\'s Go',enable: true,onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const TripHistoryView()));
            },),
          ],
        ),
      ),
    );
  }
}
