import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/tour_guide/profile/presentation/manager/contact_info/contact_info_cubit.dart';
import 'package:prepare_project/features/tour_guide/profile/presentation/view/widgets/contact_item_to_view.dart';

class ContactInfoBody extends StatelessWidget {
  const ContactInfoBody({
    super.key,
    required this.cubit,
    required this.width,
  });

  final ContactInfoCubit cubit;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
            padding: const EdgeInsets.only(top: 40,left: 20,bottom: 10),
            onPressed: (){
              context.pop();
            }, icon: const Icon(Icons.close,color: basicColor,)),
        Expanded(
          child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(20),
              itemCount: cubit.editSocialLinks.length,
              itemBuilder: (context,index){
                return ContactShowItem(name: cubit.editSocialLinks.keys.elementAt(index), contactData:cubit.editSocialLinks.values.elementAt(index), width: width, removeFromSocialLinks: (){
                  cubit.removeFromSocialLinks(name:  cubit.editSocialLinks.keys.elementAt(index));
                });
              }, separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 20,
                );
          },),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 10),
            child: CustomLoginButton(
              label: 'Update',
              isLoading:cubit.isLoading,
              onTap: (){
                cubit.updateContactInfo();
              },
            ),
          ),
        ),
      ],
    );
  }
}

