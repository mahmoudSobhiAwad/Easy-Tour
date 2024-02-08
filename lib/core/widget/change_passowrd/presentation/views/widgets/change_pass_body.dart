import 'package:flutter/material.dart';
import 'package:prepare_project/core/widget/change_passowrd/presentation/manager/change_password_cubit.dart';
import 'package:prepare_project/core/widget/change_passowrd/presentation/views/widgets/confirm_pass_form.dart';
import 'package:prepare_project/core/widget/change_passowrd/presentation/views/widgets/old_pass_form.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';

class ChangePasswordBody extends StatelessWidget {
  const ChangePasswordBody({
    super.key,
    required this.cubit,
    required this.height,
  });

  final ChangePasswordCubit cubit;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20,right: 20,top:30,bottom:MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: cubit.formKey,
          child: Column(
            children: [
              OldPassword(height: height,title: 'Enter the Old Password', oldPassVis: cubit.oldPassVis,
                oldPassController: cubit.passwordController, changeOldVis: () {
                  cubit.changeOldVisibility();
                },),
              const SizedBox(height: 20,),
              ConfirmNewPassword(height: height, cubit: cubit),
              SizedBox(height: height*0.22,),
              CustomLoginButton(label: 'Update',onTap: ()async
              {
                await cubit.changeNewPassword();
              },),
              SizedBox(height: height*0.05,),
            ],
          ),
        ),
      ),
    );
  }
}