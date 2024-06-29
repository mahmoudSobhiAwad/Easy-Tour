import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/features/tourist/tourist_feed/data/repo/filter_post_repo.dart';
import 'package:prepare_project/features/tourist/tourist_feed/presentation/manager/create_post_cubit/create_post_cubit.dart';
import 'package:prepare_project/features/tourist/tourist_feed/presentation/manager/create_post_cubit/create_post_states.dart';
import 'package:prepare_project/features/tourist/tourist_feed/presentation/view/widgets/create_post_body.dart';
class CreatePostView extends StatelessWidget {
  const CreatePostView({super.key});

  @override
  Widget build(BuildContext context) {
    final double width=BasicDimension.screenWidth(context);
    final double height=BasicDimension.screenHeight(context);
    return BlocProvider(
      create: (context)=>CreatePostCubit(filterPostRepoImpl: getIt.get<FilterPostRepoImpl>()),
      child:BlocConsumer<CreatePostCubit,CreatePostStates>(
          builder: (context,state){
            var cubit=BlocProvider.of<CreatePostCubit>(context);
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: CreatePostBody(height: height, width: width, cubit: cubit),
            );
      }, listener: (context,state){
            if(state is SuccessUploadPostState){
               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text("Uploaded Successfully"),backgroundColor: whatsAppColor,width: 200,),);
               Navigator.pop(context);
            }
      }) ,);
  }
}





