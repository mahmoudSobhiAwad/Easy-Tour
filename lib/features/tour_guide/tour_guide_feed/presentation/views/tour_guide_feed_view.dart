import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/go_router/go_router.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tour_guide/tour_guide_feed/presentation/views/tour_guide_feed_body.dart';
import 'package:prepare_project/features/tourist/tourist_feed/presentation/manager/view_posts_cubit/view_post_cubit.dart';
import 'package:prepare_project/features/tourist/tourist_feed/presentation/manager/view_posts_cubit/view_post_states.dart';
import 'package:prepare_project/features/tourist/tourist_feed/presentation/view/widgets/small_profile_pic.dart';

class TourGuideFeedsView extends StatelessWidget {
  const TourGuideFeedsView({super.key});

  @override
  Widget build(BuildContext context) {
    final double width=BasicDimension.screenWidth(context);
    final double height=BasicDimension.screenHeight(context);
    return BlocProvider(
      create: (context)=>ViewPostsCubit(),
      child:BlocConsumer<ViewPostsCubit,ViewPostStates>(builder: (context,state){
        var cubit=BlocProvider.of<ViewPostsCubit>(context);
        return Scaffold(
          appBar:AppBar(
            forceMaterialTransparency: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            automaticallyImplyLeading: false,
            title: Text("My Posts",style: CustomTextStyle.fontBold30.copyWith(fontSize: 40),),
            actions: [
              CircleAvatar(
                  backgroundColor: thirdColor,
                  radius: width*0.06,
                  child:Center(child: IconButton(onPressed: (){
                    context.push(RouterApp.kTouristCreatePost);
                  }, icon: const Icon(Icons.add)))),
              const SizedBox(width: 15,),
              SmallProfilePic(width: width),
              const SizedBox(width: 15,),
            ],
          ),
          floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: height*0.1),
            child: CircleAvatar(
              radius: width*0.075,
              backgroundColor: forthColor,
              child: IconButton(icon: const FaIcon(FontAwesomeIcons.penToSquare,color: Colors.white,),onPressed:(){
                context.push(RouterApp.kTouristCreatePost);
              },),
            ),
          ),
          body:TourGuideFeedBody(cubit: cubit, width: width, height: height),
        );
      }, listener: (context,state){}) ,);
  }
}


