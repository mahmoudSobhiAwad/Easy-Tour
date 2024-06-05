import 'package:flutter/services.dart';

class CardNumberInputFormatter extends TextInputFormatter{
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if(newValue.selection.baseOffset==0){
      return newValue;
    }
    String inputValue=newValue.text;
    StringBuffer buffer=StringBuffer();
    for(int i=0;i<inputValue.length;i++){
      buffer.write(inputValue[i]);
      int index=i+1;
      if(index % 4 ==0&&inputValue.length!=index){
        buffer.write('  ');
      }
    }
    return TextEditingValue(text:buffer.toString() ,selection:TextSelection.collapsed(offset: buffer.toString().length));
  }

}

class ExpiryDateInputFormatter extends TextInputFormatter{
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if(newValue.selection.baseOffset==0){
      return newValue;
    }
    String inputValue=newValue.text;
    StringBuffer buffer=StringBuffer();
    for(int i=0;i<inputValue.length;i++){
      buffer.write(inputValue[i]);
      var nonZeroIndex=i+1;
      if(nonZeroIndex % 2 ==0&&nonZeroIndex!=inputValue.length){
        buffer.write('/');
      }
    }
    return TextEditingValue(text:buffer.toString() ,selection:TextSelection.collapsed(offset: buffer.toString().length));
  }

}