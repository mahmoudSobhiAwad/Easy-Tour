import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/features/tourist/profile/presentation/manager/profile_cubit.dart';
import 'package:prepare_project/features/tourist/profile/presentation/views/widgets/edit_profile_view.dart';
import '../../../../../../core/utilities/textStyle/font_styles.dart';


class BioAndEditButton extends StatelessWidget {
  const BioAndEditButton({super.key, required this.screenHeight, required this.cubit, required this.screenWidth,});
  final double screenHeight;
  final ProfileCubit cubit;
  final double screenWidth;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight*0.06,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${cubit.name}',style:CustomTextStyle.commonProfileDark,),
              const SizedBox(height: 5,),
              Text('${cubit.touristModel.flagName??""}  ${cubit.touristModel.nationality??""}'),
            ],
          ),
          InkWell(
            onTap: ()async{

              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ProfileEditView(model: cubit.touristModel);
              }));
            },
            child: Container(
              width: screenWidth*0.35,
              decoration: BoxDecoration(
                border: Border.all(color:secondaryColor),
                borderRadius: BorderRadius.circular(20),
                color: formFillColor,
              ),
              child: const Center(child: Text('Edit Profile',style: CustomTextStyle.commonProfileDark,)),

            ),
          ),
        ],
      ),
    );
  }
}
