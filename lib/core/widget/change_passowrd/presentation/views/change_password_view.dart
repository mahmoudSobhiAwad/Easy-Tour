import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/core/widget/change_passowrd/data/repos/change_password_repo_impl.dart';
import 'package:prepare_project/core/widget/change_passowrd/presentation/manager/change_pass_state.dart';
import 'package:prepare_project/core/widget/change_passowrd/presentation/manager/change_password_cubit.dart';
import 'package:prepare_project/core/widget/change_passowrd/presentation/views/widgets/change_pass_body.dart';

import '../../../custom_alert_widget/alert_container.dart';
import '../../../custom_alert_widget/alert_types.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({
    super.key,});

  @override
  Widget build(BuildContext context) {
    double height=BasicDimension.screenHeight(context);
    return BlocProvider(
      create: (context)=>ChangePasswordCubit(changePasswordRepo: getIt.get<ChangePasswordRepoImp>()),
      child: BlocConsumer<ChangePasswordCubit,ChangePasswordState>(
        builder: (context,state){
          var cubit=BlocProvider.of<ChangePasswordCubit>(context);
          return ChangePasswordBody(cubit: cubit, height: height);
        },
        listener: (context,state){
          if(state is SuccessNewPasswordState){
            showDialog(context: context, builder: (context)=>const ContainerAlertWidget(types: AlertTypes.success,content: 'Updated Successfully !',)).then((value) {
              context.pop();
            });

          }
          else if (state is FailureOldPasswordState){
            showDialog(context: context, builder: (context)=>ContainerAlertWidget(types: AlertTypes.failed,content: state.errMessage,onTap:(){context.pop();},));
          }
          else if (state is FailureNewPasswordState){
            showDialog(context: context, builder: (context)=>ContainerAlertWidget(types: AlertTypes.failed,content: state.errMessage,onTap:(){context.pop();},));
          }
        },

      ),
    );
  }
}

