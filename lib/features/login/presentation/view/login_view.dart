import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prepare_project/core/utilities/function/service_locator.dart';
import 'package:prepare_project/features/login/data/repos/login_repo_imp.dart';
import 'package:prepare_project/features/login/presentation/manager/login_cubit.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context)=>LoginCubit(loginRepo:getIt.get<LoginRepoImpl>()),
      child: const Scaffold(
        backgroundColor: Color(0xffFEFEFD),
        resizeToAvoidBottomInset: false,
        body: LoginBody(),
      ),
    );
  }
}












