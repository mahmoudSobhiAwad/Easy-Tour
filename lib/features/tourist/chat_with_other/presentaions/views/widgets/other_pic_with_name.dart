import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/chat_with_other/data/models/view_guide_meta_data.dart';
import 'package:prepare_project/features/tourist/chat_with_other/presentaions/views/widgets/one_to_one_view.dart';
import 'package:prepare_project/features/tourist/profile/presentation/views/widgets/pic_profile_widget.dart';
class OtherPeoplePicWithName extends StatelessWidget {
  const OtherPeoplePicWithName({
    super.key,
    required this.height,
    required this.width,
    this.listOfGuide,
    required this.isGuidesLoading,
  });

  final double height;
  final double width;
  final List<ViewGuideMetaDataModel>?listOfGuide;
  final bool isGuidesLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height*0.15,
      child: isGuidesLoading?
      const Center(child: CircularProgressIndicator(color: basicColor,),):
      ListView.separated(
        padding: EdgeInsets.only(top: height*0.02,left: 20,right: 20),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: listOfGuide?.length??0,
        itemBuilder: (context,index){
          return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return ChatTouristOneToOtherOne(
                  chatId: listOfGuide?[index].chatId,
                  height: height, width: width,
                  name: listOfGuide?[index].fName,
                  profileUrl: listOfGuide?[index].profileUrl,
                  destEmail: listOfGuide?[index].email,
                  status: listOfGuide?[index].status,);
              }));
            },
            child: SizedBox(
              height: height*0.14,
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      ProfilePicWidget(imageUrl: listOfGuide?[index].profileUrl??"", height: height*0.07),
                      Icon(Icons.circle,size: 15,color: listOfGuide?[index].status=='Online'?whatsAppColor:closeColor,)
                    ],
                  ),
                  SizedBox(height: height*0.01,),
                  SizedBox(width:width*0.2,height: height*0.05,child: Text(listOfGuide?[index].fName??"",style: CustomTextStyle.commonFontThin,maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,))
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context,index){
          return SizedBox(width: width*0.04,);
        },
      ),
    );
  }
}