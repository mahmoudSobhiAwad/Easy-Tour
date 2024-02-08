import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prepare_project/core/utilities/basics.dart';
import 'package:prepare_project/core/widget/custom_alert_widget/alert_types.dart';

class ContainerAlertWidget extends StatelessWidget {
  const ContainerAlertWidget({super.key,required this.types,this.content, this.onTap,this.onTapYes,this.onTapNo});
final AlertTypes types;
final String?content;
final void Function()? onTap;
final void Function()? onTapYes;
final void Function()? onTapNo;
  @override
  Widget build(BuildContext context) {
    final double width=BasicDimension.screenWidth(context);
    final double height=BasicDimension.screenHeight(context);
    Widget buildHeader(){
      switch(types){
        case AlertTypes.success:
          return HeaderOption.successWidget;
        case AlertTypes.failed:
          return HeaderOption.errorWidget;
        case AlertTypes.warning:
          return HeaderOption.warningWidget;
        case AlertTypes.optionChoice:
          return HeaderOption.warningWidget;
        default:
          return HeaderOption.successWidget;
      }
    }
    Widget buildButton(){
      switch(types){
        case AlertTypes.success:
          return const SizedBox(height: 0,);
        case AlertTypes.failed:
          return ButtonOption.errorButton;
        case AlertTypes.warning:
          return ButtonOption.warningButton;
        case AlertTypes.optionChoice:
          return OptionChoice(onTapNo: onTapNo, onTapYes: onTapYes);


      }
    }
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Center(
        child: Container(
          height: height*0.3,
          width: width*0.9,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                blurRadius: 4,
                offset: Offset(0, 4)
              )
            ],
            borderRadius: BorderRadius.circular(20),color: Colors.white,),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildHeader(),
              const SizedBox(height: 20,),
              DefaultTextStyle(style: const TextStyle(color: basicColor,fontSize: 16,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis,),textAlign: TextAlign.center, child: Text('$content')),
              const SizedBox(height: 20,),
              GestureDetector(onTap: (){
                onTap!();
              },child: buildButton()),
            ],
          ),
        ),
      ),
    );
  }
}
class HeaderOption{
  static Widget warningWidget=const CircleAvatar(
    radius: 30,
    backgroundColor: Color(0xffFFB636),
    child:  FaIcon(FontAwesomeIcons.exclamation,color: Colors.white,),
  );
  static Widget errorWidget=const CircleAvatar(
    radius: 30,
    backgroundColor: closeColor,
    child:  FaIcon(FontAwesomeIcons.xmark,color: Colors.white,),
  );
  static Widget successWidget=const CircleAvatar(
    radius: 30,
    backgroundColor: Color(0xff4BD37B),
    child:  FaIcon(FontAwesomeIcons.check,color: Colors.white,),
  );
}

class ButtonOption{
  static Widget warningButton=Container(
    height: 50,
    width: 150,
    decoration: BoxDecoration(
      boxShadow: const [
        BoxShadow(
            blurRadius: 4,
            offset: Offset(0, 4)
        )
      ],
      borderRadius: BorderRadius.circular(20),
      color: thirdColor,),
    child: const Center(child:  DefaultTextStyle(style:TextStyle(color: basicColor,fontWeight: FontWeight.bold,fontSize: 16),child:Text('Send',))),
  );
  static Widget errorButton=Container(
    height: 50,
    width: 150,
    decoration: BoxDecoration(
      boxShadow: const [
        BoxShadow(
            blurRadius: 4,
            offset: Offset(0, 4)
        )
      ],
      borderRadius: BorderRadius.circular(20),
      color: thirdColor,),
    child: const Center(child:  DefaultTextStyle(style:TextStyle(color: basicColor,fontWeight: FontWeight.bold,fontSize: 16),child:Text('Ok',))),
  );

}

class OptionChoice extends StatelessWidget {
  const OptionChoice({super.key, required this.onTapNo, required this.onTapYes,});
  final void Function()? onTapYes;
  final void Function()? onTapNo;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap:onTapYes,
          child: Container(
            height: 50,
            width: 100,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
              color: thirdColor,),
            child: const Center(child:  DefaultTextStyle(style:TextStyle(color: basicColor,fontWeight: FontWeight.bold,fontSize: 16),child:Text('Yes',))),
          ),
        ),
        const SizedBox(width: 30,),
        GestureDetector(
          onTap: onTapNo,
          child: Container(
            height: 50,
            width: 100,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
              color: thirdColor,),
            child: const Center(child:  DefaultTextStyle(style:TextStyle(color: basicColor,fontWeight: FontWeight.bold,fontSize: 16,),child:Text('No',))),
          ),
        ),
      ],
    );
  }
}
