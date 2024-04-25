import 'package:country_picker/country_picker.dart';

class CurrencyCodesModel{
  String?currencyCode;
  String?currencyName;
  String?currencyIcon;
  CurrencyCodesModel({
   this.currencyCode,
   this.currencyIcon,
   this.currencyName,
});
  factory CurrencyCodesModel.fromJson(List<dynamic>json){
    return CurrencyCodesModel(
      currencyCode: json[0],
      currencyName: json[1],
      currencyIcon: CurrencyCodesModel().getCurrencyIcon(json[0]),
    );
  }
  dynamic getCurrencyIcon(String code){
    code=code.substring(0,2);
    return Country.tryParse(code)?.flagEmoji;
  }
}
class CurrencyConverterModel{
  CurrencyCodesModel based;
  CurrencyCodesModel target;
  num?amount;
  CurrencyConverterModel({this.amount,required this.target,required this.based});
}