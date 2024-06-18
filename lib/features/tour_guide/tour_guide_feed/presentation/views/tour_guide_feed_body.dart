import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prepare_project/features/tourist/tourist_feed/presentation/manager/view_posts_cubit/view_post_cubit.dart';
import 'package:prepare_project/features/tourist/tourist_feed/presentation/view/widgets/social_one_item.dart';
class TourGuideFeedBody extends StatelessWidget {
  const TourGuideFeedBody({super.key,required this.cubit,required this.width,required this.height});
  final ViewPostsCubit cubit;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future:cubit.postsFuture,
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasError){
            return Center(child: Text("SomeThing Went Wrong Please Try Later, may be :${snapshot.error.toString()}"),);
          }
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child:  CircularProgressIndicator());
          }
          else{
            cubit.getDataOnce(snapshot.data!.docs.cast<QueryDocumentSnapshot<Map<String, dynamic>>>());
            return ListView.separated(
              itemCount: cubit.postsList.length,
              padding: const EdgeInsets.all(15).copyWith(bottom: height*0.12),
              separatorBuilder: (context,index){
                return const SizedBox(height: 15,);
              },
              itemBuilder: (context,index){
                return SocialItemPost(height: height, role:'tourGuide',width: width,model: cubit.postsList[index],);
              },
            );
          }
        });
  }
}