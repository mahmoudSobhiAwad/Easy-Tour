import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/go_router/go_router.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/tourist_feed/presentation/manager/view_posts_cubit/view_post_cubit.dart';
import 'package:prepare_project/features/tourist/tourist_feed/presentation/manager/view_posts_cubit/view_post_states.dart';
import 'package:prepare_project/features/tourist/tourist_feed/presentation/view/widgets/small_profile_pic.dart';
import 'package:prepare_project/features/tourist/tourist_feed/presentation/view/widgets/social_one_item.dart';
class TouristFeedView extends StatelessWidget {
  const TouristFeedView({super.key});

  @override
  Widget build(BuildContext context){
    final double width=BasicDimension.screenWidth(context);
    final double height=BasicDimension.screenHeight(context);
    return BlocProvider(
      create: (context)=>ViewPostsCubit(),
      child:BlocConsumer<ViewPostsCubit,ViewPostStates>(
          builder: (context,state){
            var cubit=BlocProvider.of<ViewPostsCubit>(context);
            return Scaffold(
              appBar: AppBar(
                forceMaterialTransparency: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                automaticallyImplyLeading: false,
                title: Text("Easy Tour",style: CustomTextStyle.fontBold30.copyWith(fontSize: 40),),
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
              body: StreamBuilder<QuerySnapshot>(
                  stream: cubit.postsStream.orderBy('dateTime',descending: true).snapshots(includeMetadataChanges: true), builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                if(snapshot.hasError){
                  return Center(child: Text("SomeThing Went Wrong Please Try Later, may be :${snapshot.error.toString()}"),);
                }
                if(snapshot.connectionState==ConnectionState.waiting){
                  return const Center(child:  CircularProgressIndicator());
                }
                else{
                  cubit.getDate(snapshot.data!.docs.cast<QueryDocumentSnapshot<Map<String, dynamic>>>());
                  return ListView.separated(
                    itemCount: cubit.postsList.length,
                    padding: const EdgeInsets.all(15).copyWith(bottom: height*0.12),
                    separatorBuilder: (context,index){
                      return const SizedBox(height: 15,);
                    },
                    itemBuilder: (context,index){
                      return SocialItemPost(height: height, width: width,model: cubit.postsList[index],);
                    },
                  );
                }
              }),
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
            );
      }, listener: (context,state){}) ,
    );
  }
}








