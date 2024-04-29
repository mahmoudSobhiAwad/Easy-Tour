import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/features/common_settings/presentation/manager/common_setting_cubit.dart';
import 'package:prepare_project/features/common_settings/presentation/manager/common_setting_states.dart';
import 'package:prepare_project/features/tourist/settings/data/repo/setting_repo_imp.dart';
import 'package:prepare_project/features/tourist/settings/presentaion/views/widgets/general_settings_part.dart';
import 'package:prepare_project/features/tourist/settings/presentaion/views/widgets/payment_settings_part.dart';
import 'package:prepare_project/features/tourist/settings/presentaion/views/widgets/profile_settings_part.dart';

class CommonSettingView extends StatelessWidget {
  const CommonSettingView({super.key});

  @override
  Widget build(BuildContext context) {
    double height=BasicDimension.screenHeight(context);
    double width=  BasicDimension.screenWidth(context);
    return  BlocProvider(
        create: (context)=>CommonSettingCubit(settingRepoImp: getIt.get<SettingRepoImp>()),
        child:
        BlocConsumer<CommonSettingCubit,CommonSettingState>(builder: (context,state){
          var cubit=BlocProvider.of<CommonSettingCubit>(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: thirdColor,
              surfaceTintColor: thirdColor,
              clipBehavior: Clip.none,
              leading:IconButton(onPressed: ()
              {
                context.pop();
              },
                  icon: const Icon(Icons.arrow_back_ios_new,color: basicColor,)),
              title: const Text('Settings',style: TextStyle(color: basicColor,fontWeight: FontWeight.bold,fontSize: 18),),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                physics:const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    ProfileSettingsPart(
                      enableNotification: cubit.enableNotification,
                      changeNotify: () {cubit.changeNotificationMode();},
                      height: height,width: width,
                      enableDarkMode: cubit.enableDarkMode,
                      toggleAppMode: (){cubit.changeMode();},),
                    PaymentSettingsPart(height: height, width: width),
                    const SizedBox(height: 20,),
                    GeneralSettings(height: height,),
                  ],
                ),
              ),
            ),
          );
        }, listener: (context,state){})
    );

  }
}
