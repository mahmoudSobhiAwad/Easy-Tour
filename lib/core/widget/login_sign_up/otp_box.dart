import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prepare_project/core/widget/login_sign_up/custom_text_form.dart';
class OtpBox extends StatelessWidget {
  const OtpBox({super.key,required this.otpKey,required this.otpController});
  final Key otpKey;
  final TextEditingController otpController;
  @override
  Widget build(BuildContext context) {
    return Form(
      key:otpKey ,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...List.generate(6, (index) =>SizedBox(
                width: MediaQuery.of(context).size.width*0.12,
                child:  CustomTextFormField(
                  onChanged: (value){
                    if(value.length==1){
                      otpController.text='${otpController.text}$value';
                      FocusScope.of(context).nextFocus();
                    }
                    else if(value.isEmpty){
                      otpController.text = otpController.text.substring(0, otpController.text.length - 1);
                      FocusScope.of(context).previousFocus();
                    }
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  // controller: TextEditingController(),
                  label: '',
                  border: 10,
                  type: TextInputType.number,
                  align: TextAlign.center,
                  style: const TextStyle(fontSize: 25,),
                  validator: (value){if(value==null||value.isEmpty){return '';}
                  return null;
                  },
                )
            )
            )
          ]
      ),
    );
  }
}