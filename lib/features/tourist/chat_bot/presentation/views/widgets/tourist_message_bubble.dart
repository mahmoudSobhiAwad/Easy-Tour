import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
class TouristBubble extends StatelessWidget {
  const TouristBubble({Key? key,required this.message,required this.isLoading}) : super(key: key);
  final String message;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              padding: const EdgeInsets.all(
                12,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomLeft,
                    colors: [Color(0xff5F92D9), Color(0xffB588DC),]
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                ),
                color: basicColor ,
              ),
              child: Text(message,style: const TextStyle(color: Colors.white),),
            ),
            Padding(padding:const EdgeInsets.all(5),
              child:isLoading?
              const Align(
                  alignment: Alignment.bottomRight,
                  child:  Icon(Icons.check,color: Colors.white,size: 12,)):
              const Align(
                  alignment: Alignment.bottomRight,
                  child:Icon(Icons.access_time_rounded,color: Colors.white,size: 12,)),
            ),
          ],
        ),
      ),
    );
  }
}