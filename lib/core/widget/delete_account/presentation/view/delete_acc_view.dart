import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/core/utilities/go_router/go_router.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_container.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_types.dart';
import 'package:prepare_project/core/widget/delete_account/data/repos/delete_acc_repo_imp.dart';
import 'package:prepare_project/core/widget/delete_account/presentation/manager/delete_acc_cubit.dart';
import 'package:prepare_project/core/widget/delete_account/presentation/manager/delete_account_states.dart';
import 'package:prepare_project/core/widget/delete_account/presentation/view/widgets/delete_acc_body.dart';
class DeleteAccountView extends StatelessWidget {
  const DeleteAccountView({super.key,required this.height});
  final double height;
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context)=>DeleteAccountCubit(deleteAccountRepo: getIt.get<DeleteAccountRepoImpl>()),
      child: BlocConsumer<DeleteAccountCubit,DeleteAccountState>(
        builder: (context,state){
          var cubit=BlocProvider.of<DeleteAccountCubit>(context);
          return DeleteAccountBody(cubit: cubit, height: height);
        },
        listener: (context,state){
          var cubit=BlocProvider.of<DeleteAccountCubit>(context);
          if(state is SuccessDeleteAccountState){
            showDialog(context: context, builder: (context)=>const ContainerAlertWidget(types: AlertTypes.success,content: 'User Deleted !',));
            Future.delayed(const Duration(seconds: 2),(){
              context.go(RouterApp.kLoginView);
            });

          }
          else if (state is FailureDeleteAccountState){
            showDialog(context: context, builder: (context)=>ContainerAlertWidget(types: AlertTypes.failed,content: state.errMessage,onTap:(){context.pop();},));
          }
          else if (state is FailureCheckOldPasswordState){
            showDialog(context: context, builder: (context)=>ContainerAlertWidget(types: AlertTypes.failed,content: state.errMessage,onTap:(){context.pop();},));
          }
          else if(state is RefreshTokenFailureState) {
            showDialog(context: context, builder: (context)=> ContainerAlertWidget(
              types: AlertTypes.failed,
              onTap: (){
                cubit.checkOldPassword().then((value){Navigator.pop(context);});
              },
              content: '${state.errMessage}',));
          }

        },
      ),
    );
  }
}

