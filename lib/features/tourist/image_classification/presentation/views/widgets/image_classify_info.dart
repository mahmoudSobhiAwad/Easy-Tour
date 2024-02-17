import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:prepare_project/features/tourist/chat_bot/presentation/views/chat_bot_view.dart';
import 'package:prepare_project/features/tourist/image_classification/data/models/qr_scanned_model.dart';
class ImageClassificationInfo extends StatelessWidget {
  const ImageClassificationInfo({super.key,required this.height,required this.model,required this.width,});
  final double height;
  final double width;
  final QrScannedModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.network(model.imageUrl??'',
            errorBuilder: (w,r,e){
            return const Center(child:Icon(Icons.error,color: Colors.amber,size: 200,));
            },
            fit: BoxFit.fitHeight,height: height*0.7,width: width,),
          Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                  height: height*0.4,
                  decoration:BoxDecoration(
                    boxShadow: [buildBoxShadow()],
                    color: thirdColor,
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(30),topRight:Radius.circular(30),),
                  ),
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Statue Info',style: CustomTextStyle.commonSignDark,),
                      SizedBox(
                        height: height*0.3,
                        width: width,
                        child:SingleChildScrollView(
                            child: AnimatedTextKit(
                            totalRepeatCount: 1,
                            isRepeatingAnimation: false,
                            animatedTexts: [
                              TyperAnimatedText(model.rawDate??'',textStyle: const TextStyle(color: basicColor,fontSize: 18))
                            ])
                          ),
                      ),
                      const Expanded(child: SizedBox(height: 5,)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: CustomLoginButton(color:const Color(0xff5F92D9),enable: true,altWidth: width*0.4,label: 'Show More',
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>ChatBotView(initialMessage:'Tell Me More About ${model.rawDate?.split(',').first}',)));
                  },),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0,left: 15),
            child: Align(
                alignment: Alignment.topLeft,
              child: CustomGeneratedAiTripAppBar(height: height,width:width,),
            ),
          ),
        ],
      ),
    );
  }
}