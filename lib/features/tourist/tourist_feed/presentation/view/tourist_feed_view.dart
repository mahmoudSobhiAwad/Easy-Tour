import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/tourist_feed/presentation/view/widgets/small_profile_pic.dart';
import 'package:prepare_project/features/tourist/tourist_feed/presentation/view/widgets/social_one_item.dart';
class TouristFeedView extends StatelessWidget {
  const TouristFeedView({super.key});

  @override
  Widget build(BuildContext context){
    final double width=BasicDimension.screenWidth(context);
    final double height=BasicDimension.screenHeight(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Easy Tour",style: CustomTextStyle.resetPassTitle.copyWith(fontSize: 40),),
        actions: [
          CircleAvatar(
              backgroundColor: thirdColor,
              radius: width*0.06,
              child:const Center(child: IconButton(onPressed: null, icon: Icon(Icons.add)))),
          const SizedBox(width: 15,),
          SmallProfilePic(width: width),
          const SizedBox(width: 15,),
        ],
      ),
      body: ListView.separated(
        itemCount: 5,
        padding: const EdgeInsets.all(15).copyWith(bottom: height*0.12),
        separatorBuilder: (context,index){
          return const SizedBox(height: 15,);
        },
        itemBuilder: (context,index){
          return SocialItemPost(height: height, width: width);
        },
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: height*0.1),
        child: CircleAvatar(
          radius: width*0.075,
          backgroundColor: forthColor,
          child:const IconButton(icon: FaIcon(FontAwesomeIcons.penToSquare,color: Colors.white,),onPressed:null,),
        ),
      ),
    );
  }
}








