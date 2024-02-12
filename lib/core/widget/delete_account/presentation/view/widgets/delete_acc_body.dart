import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/widget/change_passowrd/presentation/views/widgets/old_pass_form.dart';
import 'package:prepare_project/core/widget/delete_account/presentation/manager/delete_acc_cubit.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
class DeleteAccountBody extends StatelessWidget {
  const DeleteAccountBody({
    super.key,
    required this.cubit,
    required this.height,
  });

  final DeleteAccountCubit cubit;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20,right: 20,top:30,bottom:MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        physics:const BouncingScrollPhysics(),
        child: Form(
          key: cubit.formKey,
          child: Column(
            children: [
              OldPassword(height: height, title:'Enter the Password to Confirm', oldPassVis: cubit.oldPassVis, oldPassController: cubit.passwordController, changeOldVis: () {
                cubit.changeOldPassVis();
              },),
              SizedBox(height: height*0.15,),
              CustomLoginButton(label: 'Delete',color: closeColor,
                isLoading: cubit.isLoading,
                onTap: ()async{
                await cubit.deleteAccount();
              },)
            ],
          ),
        ),
      ),
    );
  }
}