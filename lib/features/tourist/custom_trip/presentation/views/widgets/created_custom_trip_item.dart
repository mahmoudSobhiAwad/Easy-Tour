import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
class CreatedCustomTripItem extends StatelessWidget {
  const CreatedCustomTripItem({super.key,required this.width,required this.height});
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: secondaryColor,width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network('https://th.bing.com/th/id/OIP.qa3Wfem8AKuNkz6Eq1kvVAHaH9?rs=1&pid=ImgDetMain',width: width,height: height*0.15,fit: BoxFit.cover,)),
          SizedBox(height: height*0.02,),
          SizedBox(
            height: height*0.05,
            child: ListView.builder(
              itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: forthColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding:const EdgeInsets.all(5),
                    child: Center(child: Text("Pyramids",style: CustomTextStyle.commonFontThin.copyWith(color: Colors.white),)),
                  ),
                );
              },
              scrollDirection: Axis.horizontal,

            ),
          ),
          SizedBox(height: height*0.015,),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Egypt 3 Days'),
              Row(
                children: [
                  Text('28 May 2024'),
                  Icon(Icons.arrow_forward),
                  Text('30 May 2024'),
                ],
              ),
            ],
          ),
          SizedBox(height: height*0.015,),
          const Text('Discovering Spiritual Egypt in 3 days',style: CustomTextStyle.privateTourTitle,maxLines: 2,),
          const Text('Pyramids Meditation, Luxor Banks, 3-night Dahabiya Nile Cruise,Pyramids Meditation, Luxor Banks, 3-night Dahabiya ',maxLines: 2,overflow: TextOverflow.ellipsis,),
          SizedBox(height: height*0.02,),
          CustomLoginButton(
            altWidth: width*0.4,
            borderRadius: 10,
            label: 'See Details',
            enable: true,
          ),
        ],
      ),
    );
  }
}