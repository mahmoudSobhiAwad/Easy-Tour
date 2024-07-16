import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/go_router/go_router.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tour_guide/profile/data/model/guide_personal_info_model.dart';
import 'package:prepare_project/features/tour_guide/profile/presentation/view/widgets/custom_guide_profile_pic.dart';
import 'package:prepare_project/features/tour_guide/profile/presentation/view/widgets/licence_button.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/managers/guide_view_cubit/guide_view_for_tourist_cubit.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/views/widgets/contact_info_button.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/views/widgets/custom_two_button.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/views/widgets/personal_guide_info_for_tourist.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/views/widgets/review_button.dart';
import 'package:prepare_project/features/tourist/booking_collection/book_with_tour_guide/presentation/views/widgets/tour_guide_trips_for_tourist_body.dart';
class ViewGuideProfileForTouristBody extends StatelessWidget {
  const ViewGuideProfileForTouristBody({
    super.key,
    required this.height,
    required this.width,
    required this.cubit,
    required this.model,
  });

  final double height;
  final double width;
  final ViewGuideCubitForTourist cubit;
  final TourGuidePersonalInfoModel? model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: cubit.refreshIndicatorKey,
        backgroundColor: thirdColor,
        color: basicColor,
        onRefresh: () async{
         await cubit.getTourGuideData();
        },
        child: !cubit.isLoading?
        ListView(
          children: [
            ProfilePicWithClipper(height: height, width: width,profileUrl: model?.profileUrl??'',),
            Center(child: Text('${model?.firstName} ${model?.lastName}',style: CustomTextStyle.fontBold16,)),
            Center(child: Text('${model?.describeText}',style: CustomTextStyle.font14Light,maxLines: 2,textAlign: TextAlign.center,)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width*0.025),
              child: Column(
                children: [
                  CustomTwoButton(firstTap: (){
                    context.push(RouterApp.kChatTouristView);
                  },width: width, height: height,secondTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return Scaffold(
                          body: TourGuideTripForTouristList(isLoading: false,viewProfile: false,height: height, width: width, tripList: model?.trips??[],tourName: '${model?.firstName}${model?.lastName}',));
                    }));
                  },),
                  const SizedBox(height: 15,),
                  PersonalInfoOfTourToViewTourist(height: height,model: model,),
                  LicenceButton(height: height, width: width,licenceNames: [model?.minId??'',model?.synId??''],cvUrl: model?.cvUrl,),
                  ContactInfoButton(height: height,socialLinks: model?.contactInfo,),
                  ReviewToViewForTourist( height: height),
                ],
              ),
            ),
          ],
        ):
        Center(child: CircularProgressIndicator()),
      ),
    );
  }
}