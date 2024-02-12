import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/utilities/textStyle/font_styles.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    double height=BasicDimension.screenHeight(context);
    double width=BasicDimension.screenWidth(context);
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(top:height*0.01,bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          children: [
            Container(height: height*0.1,decoration: const BoxDecoration(color: thirdColor,
                borderRadius: BorderRadius.only(topRight:Radius.circular(20) ,topLeft:Radius.circular(20) )),
              child: Row(
                children: [
                  IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back_ios_new),),
                  SizedBox(
                      width: width*0.7,
                      child: const CustomTextFormField(label: 'Search...',borderColor: thirdColor,floatingLabelBehavior: FloatingLabelBehavior.never,)
                  ),
                  const IconButton(onPressed: null, icon:  FaIcon(FontAwesomeIcons.magnifyingGlass),),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                height: height*0.5,
                child: ListView(
                  padding:const EdgeInsets.symmetric(horizontal: 16,vertical: 20),
                  children: [
                    ...List.generate(5, (index){
                      return const Padding(
                        padding: EdgeInsets.only(bottom: 25),
                        child: Row(
                          children: [
                            Icon(Icons.history,size: 30,),
                            SizedBox(width: 5,),
                            Text('Pyramids',style: CustomTextStyle.commonSignLight,),
                            Spacer(),
                            Icon(Icons.close),
                          ],
                        ),
                      );
                    })
                    ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
