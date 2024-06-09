import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/features/tourist/settings/presentaion/manager/tourist_setting_cubit.dart';
import 'package:prepare_project/features/tourist/settings/presentaion/manager/tourist_setting_state.dart';
import 'package:prepare_project/features/tourist/settings/presentaion/views/widgets/general_settings_part.dart';
import 'package:prepare_project/features/tourist/settings/presentaion/views/widgets/payment_settings_part.dart';
import 'package:prepare_project/features/tourist/settings/presentaion/views/widgets/profile_settings_part.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    double height=BasicDimension.screenHeight(context);
    double width=  BasicDimension.screenWidth(context);
    return  Scaffold(
      appBar: AppBar(
        // backgroundColor: thirdColor,
        // surfaceTintColor: thirdColor,
        clipBehavior: Clip.none,
        leading:IconButton(onPressed: ()
        {context.pop();},
            icon: const Icon(Icons.arrow_back_ios_new,)),
        title: Text('Settings',style: CustomTextStyle.fontBold16.copyWith(fontSize: 18),),
        centerTitle: true,
      ),
      body: BlocBuilder<TouristSettingCubit,TouristSettingState>(builder: (context,state) {
        var cubit=BlocProvider.of<TouristSettingCubit>(context);
        return Padding(
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
                  toggleAppMode: (){cubit.changeMode();},
                ),
                PaymentSettingsPart(height: height, width: width),
                const SizedBox(height: 20,),
                GeneralSettings(height: height,),
              ],
            ),
          ),
        );
      },)
    );
  }
}








