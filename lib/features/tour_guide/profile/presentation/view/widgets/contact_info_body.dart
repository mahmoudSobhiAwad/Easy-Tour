import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/widget/tour_guide/custom_border_raduis.dart';
import 'package:prepare_project/core/widget/tour_guide/get_social_widget.dart';
import 'package:prepare_project/features/login/presentation/view/widgets/login_button.dart';
import 'package:prepare_project/features/tour_guide/profile/presentation/manager/contact_info/contact_info_cubit.dart';

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
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(20),
              itemCount: cubit.editSocialLinks.length,
              itemBuilder: (context,index){
                return ContactShowItem(name: cubit.editSocialLinks.keys.elementAt(index), contactData:cubit.editSocialLinks.values.elementAt(index), width: width, removeFromSocialLinks: (){
                  cubit.removeFromSocialLinks(name:  cubit.editSocialLinks.keys.elementAt(index));
                });
                //return ContactItem(name: cubit.editSocialLinks.keys.elementAt(index), cubit: cubit,initialText:cubit.editSocialLinks.values.elementAt(index),);
              }),
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
class ContactShowItem extends StatelessWidget {
  const ContactShowItem({super.key,required this.name,required this.contactData,required this.width,required this.removeFromSocialLinks});
final String name;
final String contactData;
final double width;
final void Function() removeFromSocialLinks;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width:width*0.75,
          decoration: BoxDecoration(
          borderRadius: commonBorderRadius(),
          color: Colors.white,
          border: Border.all(color: secondaryColor,width: 1),
          boxShadow: const [
            BoxShadow(
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ]
        ),
          child: Row(
            children: [
              SizedBox(
                width: 60,
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getSocialIcon(name),
                      const VerticalDivider(thickness: 1,color:Color(0xffCDCDCD),indent: 5,endIndent: 5,),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 5,),
              Text(contactData),
            ],
          ),
        ),
        IconButton(onPressed: removeFromSocialLinks, icon: const Icon(Icons.delete_rounded,color: closeColor,))
      ],
    );
  }
}
