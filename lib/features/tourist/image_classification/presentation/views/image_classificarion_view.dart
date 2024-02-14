import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_container.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_types.dart';
import 'package:prepare_project/features/tourist/image_classification/presentation/manager/image_classification_cubit.dart';
import 'package:prepare_project/features/tourist/image_classification/presentation/manager/image_classification_states.dart';
import 'package:prepare_project/features/tourist/image_classification/presentation/views/widgets/image_classification_body.dart';

class ImageClassificationView extends StatelessWidget {
  const ImageClassificationView({super.key});

  @override
  Widget build(BuildContext context) {
    double width=BasicDimension.screenWidth(context);
    double height=BasicDimension.screenHeight(context);
    return  BlocProvider(create: (context)=>ImageClassificationCubit(),
      child: BlocConsumer<ImageClassificationCubit,ImageClassificationStates>(builder:(context,state){
        var cubit=BlocProvider.of<ImageClassificationCubit>(context);
        return ImageClassificationBody(height: height, width: width, cubit: cubit);
      }, listener: (context,state){
        if(state is FailedInitialImageClassificationState){
           showDialog(context: context, builder: (context){
             return ContainerAlertWidget(types: AlertTypes.failed,content: state.errMessage,);
           });
        }

        else if (state is FailedPickedImageClassificationState){
           showDialog(context: context, builder: (context){
             return ContainerAlertWidget(types: AlertTypes.failed,content: state.errMessage,);
           });
        }

      },),
    );
  }
}







