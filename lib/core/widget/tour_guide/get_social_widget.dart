import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prepare_project/core/utilities/basics.dart';

Widget getSocialIcon(String name){
  if(name=='whatsapp'){
    return const FaIcon(FontAwesomeIcons.whatsapp,color: whatsAppColor,);
  }
  else if(name=='facebook'){
    return const Icon(Icons.facebook,color: faceBookColor,);
  }
  else if(name=='instagram'){
    return const FaIcon(FontAwesomeIcons.instagram,color: faceBookColor,);
  }
  else if(name=='linkedIn'){
    return const FaIcon(FontAwesomeIcons.linkedinIn,color: basicColor,);
  }
  else if(name=='twitter'){
    return const FaIcon(FontAwesomeIcons.xTwitter,);
  }
  else{
    return const Icon(Icons.hourglass_empty_outlined);

  }
}
List<String>socialLinks=const ['whatsapp','facebook','linkedIn','twitter','instagram'];