import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_project/core/utilities/go_router/go_router.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_container.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_types.dart';
import 'package:prepare_project/features/sign_up/data/repos/sign_up_repo_imp.dart';
import 'package:prepare_project/features/sign_up/presentation/manager/sign_up_cubit.dart';
import 'package:prepare_project/features/sign_up/presentation/manager/sign_up_states.dart';
import 'package:prepare_project/features/sign_up/presentation/views/widgets/sign_up_body.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(getIt.get<SignUpRepoImp>()),
      child: BlocConsumer<SignUpCubit, SignUpStates>(
          builder: (context, state) {
            var cubit=BlocProvider.of<SignUpCubit>(context);
            return  Scaffold(
              backgroundColor: Colors.white,
              resizeToAvoidBottomInset: false,
              body: SignUpBody(cubit: cubit,),
            );
          },
        listener: (context,state){
            if(state is ThereIsNoInternetState)
            {
             showDialog(context: context, builder: (context)=> ContainerAlertWidget(
               types: AlertTypes.failed,
               onTap: (){
                 context.pop();
               },
               content: 'There is No Internet Connection',),
             );
            }
            else if(state is SuccessSignUpState) {
              showDialog(context: context, builder: (context)=>const ContainerAlertWidget(types: AlertTypes.success,content: 'Created Account Success',));
              context.go(RouterApp.kLoginView);
            }
            else if(state is SuccessTourGuideSignUpState){
              showDialog(context: context, builder: (context)=>const ContainerAlertWidget(types: AlertTypes.success,content: 'Created Account Success',));
              context.go(RouterApp.kLoginView);
            }
            else if(state is FailureSignUpState)
            {
              showDialog(context: context, builder: (context)=> ContainerAlertWidget(onTap: (){
                context.pop();
              },types: AlertTypes.failed,content:'${state.error}',));
            }
            else if(state is FrontAndBackImageIsNullState)
            {
              showDialog(context: context,builder: (context)=> ContainerAlertWidget(onTap: (){
                context.pop();
              },types: AlertTypes.failed,content:'Images Can\'t be empty',));
            }
            else if(state is DetailsIsNullState)
            {
              showDialog(context: context,builder: (context)=> ContainerAlertWidget(onTap: (){
                context.pop();
              },types: AlertTypes.failed,content:'There are Fields are not allowed to be empty ',));
            }
            else if(state is SignUpCredentialInValid){
              showDialog(context: context,builder: (context)=> ContainerAlertWidget(onTap: (){
                context.pop();
              },types: AlertTypes.failed,content:'Invalid Sign Up Please Complete All Fields',));
            }

        },
          ),
    );
  }
}


