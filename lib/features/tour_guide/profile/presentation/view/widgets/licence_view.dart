import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_container.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_types.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/tour_guide/profile/data/repos/tour_guide_profile_repo_imp.dart';
import 'package:prepare_project/features/tour_guide/profile/presentation/manager/licences_update/licences_cubit_update.dart';
import 'package:prepare_project/features/tour_guide/profile/presentation/manager/licences_update/licences_state_update.dart';
import '../../../../../../core/utilities/basics.dart';

class LicencesView extends StatelessWidget {
  const LicencesView({super.key,required this.height,required this.width,this.cvUrl,required this.licences});
  final double width;
  final double height;
  final List<String>licences;
  final String? cvUrl;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>LicencesCubit(tourGuideProfileRepo:getIt.get<TourGuideProfileRepoImp>(),cvUrl: cvUrl),
      child:BlocConsumer<LicencesCubit,LicencesStates>(
          builder: (context,state){
            var cubit=BlocProvider.of<LicencesCubit>(context);
            return Scaffold(
              body: Padding(
                padding:const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20,),
                      IconButton(onPressed: (){
                        context.pop();
                        }, icon: const Icon(Icons.close),),
                      ...List.generate(licences.length, (index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(['Ministry ID','Syndicate ID'][index],style: CustomTextStyle.fontGrover22,),
                          Padding(
                            padding:const EdgeInsets.only(bottom: 20),
                            child: Container(
                              width: width,
                              height: height*0.3,
                              decoration: BoxDecoration(color: thirdColor,borderRadius: BorderRadius.circular(20),),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(licences[index],fit: BoxFit.fill,
                                  errorBuilder: (context,ob,e)=>const Icon(Icons.error,color: closeColor,),

                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ),
                      const SizedBox(height: 10,),
                      Text('CV',style: CustomTextStyle.fontGrover22,),
                      const SizedBox(height: 10,),
                      cubit.cvFile==null? CvFileExist(pickFile: (){
                        cubit.pickFile();
                      },cvUrl: cubit.cvUrl,openFile: (){
                        cubit.downloadAndOpenFile();
                      },):
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                            child:  ColoredBox(
                              color: basicColor,child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: (){},
                                    child: SizedBox(
                                        width: width*0.7,
                                        child: Text('${cubit.name}${cubit.extension}',style: CustomTextStyle.font16Light.copyWith(color: Colors.white),)),
                                  ),
                                  IconButton(
                                      padding:const EdgeInsets.only(left:10),
                                      onPressed: (){
                                    cubit.removePickedFile();
                                  }, icon:const Icon(Icons.close,color: Colors.white,))
                                ],
                              ),
                            ),),
                          ),
                      cubit.cvFile==null?const SizedBox(): Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(child: CustomLoginButton(onTap: ()async{
                         await cubit.updateCvInfo();
                        },label: 'Update CV File',isLoading: cubit.isLoading,)),
                      ),

                    ],
                  ),
                ),
              ),
            );
          },
          listener: (context,state){
            if(state is FailureUpdateLicencesState){
              showDialog(context: context, builder: (context)=> ContainerAlertWidget(
                types: AlertTypes.failed,
                onTap: (){
                  context.pop();
                },
                content: '${state.errMessage}',));
            }
            else if(state is SuccessUpdateLicencesState){
              showDialog(context: context, builder: (context)=> const ContainerAlertWidget(
                types: AlertTypes.success,
                content: 'Updated Successfully',)).then((value){
                  Navigator.pop(context);
              });

            }
          }),
    );
  }
}
class CvFileExist extends StatelessWidget {
  const CvFileExist({super.key,required this.pickFile,required this.cvUrl,required this.openFile});
final void Function() pickFile;
final void Function() openFile;
final String? cvUrl;
  @override
  Widget build(BuildContext context) {
    return cvUrl==''?
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: pickFile,
          child: Container(
            padding:const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: basicColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Upload your resume',style: CustomTextStyle.font16Light.copyWith(color: Colors.white),),
                const SizedBox(width: 5,),
                const Icon(Icons.cloud_upload_rounded,color: thirdColor,)
              ],
            ),
          ),
        ),
        const Align(
            alignment: Alignment.bottomRight,
            child: Text('Doc ,Docx, Pdf (1 MB)',style: CustomTextStyle.font12WithEllipsis,)),
      ],
    ) :
    Row(children: [
        Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: basicColor,borderRadius: commonBorderRadius()),child: GestureDetector(
            onTap: openFile,
            child:  Text('Your CV File',style: CustomTextStyle.font16Light,))),
        IconButton(onPressed: pickFile, icon:const Icon(Icons.upload,color: basicColor,))
    ],
    );
  }
}