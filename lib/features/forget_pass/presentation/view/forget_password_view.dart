import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_project/features/forget_pass/data/repo/forget_pass_repo_imp.dart';
import 'package:prepare_project/features/forget_pass/presentation/manager/forget_pass_cubit.dart';
import 'package:prepare_project/features/forget_pass/presentation/manager/forget_pass_states.dart';
import 'package:prepare_project/features/forget_pass/presentation/view/widgets/forget_pass_body.dart';

import '../../../../core/utilities/function/service_locator.dart';
import '../../../../core/utilities/go_router/go_router.dart';
import '../../../../core/widget/custom_alert_widget/alert_container.dart';
import '../../../../core/widget/custom_alert_widget/alert_types.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key,});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context)=>ForgetPassCubit(forgetPassRepo: getIt.get<ForgetPassRepoImpl>()),
      child: BlocConsumer<ForgetPassCubit,ForgetPasswordState>(
        builder: (context,state){
          var cubit=BlocProvider.of<ForgetPassCubit>(context);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: ForgetPasswordBody(cubit: cubit,),
          );
        },
        listener: (context,state){
          if(state is ErrorSendEmailForForgetPassState){
            showDialog(context: context, builder: (context)=> ContainerAlertWidget(
              types: AlertTypes.failed,
              onTap: (){
                context.pop();
              },
              content: '${state.errMessage}',));
          }
          else if (state is OtpCodeFailedState){
            showDialog(context: context, builder: (context)=> ContainerAlertWidget(
              types: AlertTypes.failed,
              onTap: (){
                context.pop();
              },
              content: 'Code is not correct ',));
          }
          else if (state is ErrorResetPasswordState){
            showDialog(context: context, builder: (context)=> ContainerAlertWidget(
              types: AlertTypes.failed,
              onTap: (){
                context.pop();
              },
              content: '${state.errorChangePassword}',));
          }
          else if (state is SuccessResetPasswordState){
            showDialog(context: context, builder: (context)=>const ContainerAlertWidget(
              types: AlertTypes.success,
              content: 'Password Updated Successfully',)).then((value){
              Future.delayed(const Duration(seconds:1),(){
                context.go(RouterApp.kLoginView);
              });
            });
          }
        },
      ),
    );

  }
}