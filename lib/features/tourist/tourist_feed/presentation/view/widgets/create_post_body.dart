import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/custom_app_bar_trip_generated.dart';
import 'package:prepare_project/features/tourist/tourist_feed/presentation/manager/create_post_cubit/create_post_cubit.dart';
import 'package:prepare_project/features/tourist/tourist_feed/presentation/view/widgets/create_post_container.dart';
class CreatePostBody extends StatelessWidget {
  const CreatePostBody({
    super.key,
    required this.height,
    required this.width,
    required this.cubit,
  });

  final double height;
  final double width;
  final CreatePostCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: 10,right: 10,bottom: MediaQuery.viewInsetsOf(context).bottom+10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomGeneratedAiTripAppBar(height: height, width: width,
                menuToSaveTrip: Container(
                  decoration: BoxDecoration(
                    color: forthColor,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  padding:const EdgeInsets.all(7),
                  child:GestureDetector(
                      onTap: ()async{
                        cubit.uploadFullPost();
                      },
                      child: const  Text("Post",style: CustomTextStyle.font16NormalWhite,)),
                ),
                appBarTitle: 'Create new Post',appBarStyle: CustomTextStyle.fontBold16.copyWith(fontSize: 20),),
              SizedBox(height: height*0.02,),
              CreatePostContainer(width: width, cubit: cubit, height: height)
            ],
          ),
        ),
      ),
    );
  }
}
