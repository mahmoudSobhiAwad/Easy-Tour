import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:prepare_project/features/tour_guide/private_tour/data/data_ui.dart';
class ActivityDetailsView extends StatelessWidget {
  const ActivityDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    double width=BasicDimension.screenWidth(context);
    double height=BasicDimension.screenHeight(context);
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Image.network(defaultImage,width: width,height: height*0.45,fit: BoxFit.fill,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Pyramids,Giza',style: CustomTextStyle.privateTourTitle,),
                    SizedBox(height: height*0.02,),
                    const Row(
                      children: [
                        Icon(Icons.location_on_rounded,color: entertainmentColor,),
                        Text('Giza,Egypt',style: CustomTextStyle.commonFontThinLight)
                      ],
                    ),
                    SizedBox(height: height*0.02,),
                    Row(
                      children: [
                      const FaIcon(FontAwesomeIcons.ticket,color: entertainmentColor,),
                      SizedBox(width: width*0.025,),
                      const Text('5 \$',style: CustomTextStyle.commonFontThinLight)
                      ],
                    ),
                    SizedBox(height: height*0.02,),
                    const Text('About Destination',style: CustomTextStyle.privateTourTitle,),
                    SizedBox(height: height*0.02,),
                    SizedBox(
                      height: height*0.2,
                      child:const SingleChildScrollView(child:  Text(text3bet,style: CustomTextStyle.commonFontThinLight,)),
                    ),
                    SizedBox(height: height*0.02,),
                    Center(child: CustomLoginButton(altWidth: width*0.9,color: forthColor,label: 'Go Now',)),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0,left: 10,right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              CustomContainerWithStroke(height: height, width: width, containWidget: IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon:const Icon(Icons.arrow_back_sharp))),
              CustomContainerWithStroke(height: height, width: width, containWidget: IconButton(onPressed: (){
              }, icon:const Icon(Icons.bookmark_border,))),
            ],),
          ),

        ],
      ),
    );
  }
}
const String text3bet='You will gYou will get a complete travel package on the beaches. Packages in the form of airline tickets,You will get a complete travel package on the beaches. Packages in the form of airline tickets,You will get a complete travel package on the beaches. Packages in the form of airline tickets,et a complete travel package on the beaches. Packages in the form of airline tickets, recommended Hotel rooms, Transportation, Have you ever been on holiday to the Greek ETC,You will get a complete travel package on the beaches. Packages in the form of airline tickets, ';
