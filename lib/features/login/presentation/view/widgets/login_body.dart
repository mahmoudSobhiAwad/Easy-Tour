import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/go_router/go_router.dart';
import 'package:prepare_project/features/login/presentation/manager/login_cubit.dart';
import 'package:prepare_project/features/login/presentation/manager/login_state.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/button_swap_role_signed_in.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/role_sign_in_pic.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/title_sign_in.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/tourism_login.dart';
import '../../../../../core/widget/custom_alert_widget/alert_container.dart';
import '../../../../../core/widget/custom_alert_widget/alert_types.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key,});
  @override
  Widget build(BuildContext context) {
    final double height=BasicDimension.screenHeight(context);
    final double width=BasicDimension.screenWidth(context);
    return BlocConsumer<LoginCubit,LoginState>(
      builder: (context,state){
        var cubit=BlocProvider.of<LoginCubit>(context);
        return Padding(
          padding: EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom,),
          child: SingleChildScrollView(
            physics:const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Stack(
                  children: [
                    TitleSignIn(height: height,width: width,),
                    Positioned(
                      top: height*0.13,
                        left: width*0.15,
                        child: RoleSignInPic(toggleRole: cubit.toggleRoleIndex,height: height,width: width,)),
                  ],
                ),
                SwapButtonRole(
                  changToggle: (index)
                  {
                    cubit.changeToggleIndex(index);
                  },
                  height: height,
                  width: width,
                  toggleRoleIndex: cubit.toggleRoleIndex,
                ),
                const SizedBox(height: 25,),
                Container(
                  padding: EdgeInsets.only(top: height*0.03,left: 20,right: 20),
                  height: height*0.58,
                  decoration: BoxDecoration(
                  color: thirdColor,
                  borderRadius: BorderRadius.circular(30),
                  ),
                  child: LoginOfTourism(cubit: cubit,height: height,width: width,),
                )
              ],
            ),
          ),
        );
      },
      listener: (context,state){
        if(state is FailureLoginState){
          showDialog(context: context, builder: (context)=> ContainerAlertWidget(
            types: AlertTypes.failed,
            onTap: (){
              context.pop();
            },
            content: '${state.errorLogin}',));
        }
        else if(state is SuccessLoginState||state is SuccessLoginWithGoogleState){
          showDialog(context: context, builder: (context)=> const ContainerAlertWidget(
            types: AlertTypes.success,
            content: 'Success Login',)).then((value){
              context.go(RouterApp.kHomeView);
          }
          );
        }
        else if(state is SuccessTourGuideLoginState){
          showDialog(context: context, builder: (context)=> const ContainerAlertWidget(
            types: AlertTypes.success,
            content: 'Success Login',)).then((value){
              context.go(RouterApp.kTourGuideHome);
          }
          );
        }
      },
    );
  }
}



