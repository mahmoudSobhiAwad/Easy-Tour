import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_container.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_types.dart';
import 'package:prepare_project/features/tour_guide/private_tour/data/model/private_tour_model.dart';
import 'package:prepare_project/features/tour_guide/private_tour/data/repos/private_tour_repo_impl.dart';
import 'package:prepare_project/features/tour_guide/private_tour/presentation/manager/edit_create_tour/edit_create_state.dart';
import 'package:prepare_project/features/tour_guide/private_tour/presentation/manager/edit_create_tour/edit_create_tour_cubit.dart';
import 'package:prepare_project/features/tour_guide/private_tour/presentation/manager/tour_cubit/private_tour_cubit.dart';
import 'package:prepare_project/features/tour_guide/private_tour/presentation/view/widgets/create_or_edit_tour_body.dart';

class CreateOrEditPrivateTourView extends StatelessWidget {
  const CreateOrEditPrivateTourView({super.key,required this.appBarTitle,required this.privateCubit,this.createOrEdit=CreateOrEdit.edit,this.model,this.tourList,this.editedTourIndex=0});
  final String appBarTitle;
  final Trip? model;
  final Trip? tourList;
  final int editedTourIndex;
  final CreateOrEdit createOrEdit;
  final PrivateTourCubit privateCubit;
  @override
  Widget build(BuildContext context) {
    final double height=BasicDimension.screenHeight(context);
    final double width=BasicDimension.screenWidth(context);
    return BlocProvider(create: (context)=>CreateEditPrivateTourCubit(privateTourRepo: getIt.get<PrivateTourRepoImp>(),trip:tourList )..prepareFields(),
      child: BlocConsumer<CreateEditPrivateTourCubit,CreateEditPrivateTourState>(
        builder:(context,state) {
          var cubit=BlocProvider.of<CreateEditPrivateTourCubit>(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: thirdColor,
              title:Text(appBarTitle,style: CustomTextStyle.fontBold16,),
              centerTitle: true,
              leading: IconButton(onPressed: (){
                if(cubit.checkIsThereChanges()){
                  showDialog(context: context, builder: (context)=> ContainerAlertWidget(
                    types: AlertTypes.optionChoice,
                    onTapYes: (){
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    onTapNo: (){
                      Navigator.pop(context);
                    },
                    content: 'Discard Changes',));
                }
                else{
                Navigator.pop(context);}
              }, icon:const Icon(Icons.arrow_back_ios_new)),
            ),
            body: WillPopScope(
                onWillPop: ()async{
                  if(cubit.showAddDay){
                    cubit.changeShowAddDays();
                    return false;
                  }
                  else if(cubit.checkIsThereChanges()){
                    showDialog(context: context, builder: (context)=> ContainerAlertWidget(
                      types: AlertTypes.optionChoice,
                      onTapYes: (){
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      onTapNo: (){
                        Navigator.pop(context);
                      },
                      content: 'Discard Changes',));
                    return false;
                  }
                  else{
                    return true;
                  }
                },
                child: CreateOrEditPrivateTourBody(cubit: cubit, height: height, width: width,index: editedTourIndex,editOrCreate: createOrEdit,)),

          );
        } ,
        listener: (context,state){
          if(state is FailureCreateTrip){
            showDialog(context: context, builder: (context)=> ContainerAlertWidget(
              types: AlertTypes.failed,
              onTap: (){
                Navigator.pop(context);
              },
              content: '${state.errMessage}',));
          }
          else if(state is FailureEditTrip){
            showDialog(context: context, builder: (context)=> ContainerAlertWidget(
              types: AlertTypes.failed,
              onTap: (){
                Navigator.pop(context);
              },
              content: '${state.errMessage}',));
          }
          else if(state is SuccessCreateTrip){
            showDialog(context: context, builder: (context)=> const ContainerAlertWidget(
              types: AlertTypes.success,
              content: 'Successfully Created ',)).then((value){
                Navigator.pop(context);
                privateCubit.getAllMyTrip();
            });
          }
          else if(state is SuccessEditTrip){
            showDialog(context: context, builder: (context)=>const ContainerAlertWidget(
              types: AlertTypes.success,
              content: 'Successfully Edited ',)).then((value){
                Navigator.pop(context);
                privateCubit.getAllMyTrip();
            });
          }
        }
      ),
    );
  }

}