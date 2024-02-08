import 'package:flutter/material.dart';
import 'package:prepare_project/core/utilities/basics.dart';
class MyBottomNavBar extends StatelessWidget {
  const MyBottomNavBar({
    super.key,
    required this.height,
    required this.width,
    required this.barIcons,
    required this.changeBottomNavIndex,
    required this.currIndex,
    this.enableClip=true,
  });

  final double height;
  final double width;
  final int currIndex;
  final List<Icon>barIcons;
  final void Function(int index) changeBottomNavIndex;
  final bool enableClip;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25,right: 25,bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffEEEEEE).withOpacity(0.9),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 5,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 25),
        height: height*0.08,
        width: width,
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...List.generate(barIcons.length, (index) {
              return GestureDetector(
               onTap:(){changeBottomNavIndex(index);},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Opacity(
                          opacity: index==currIndex?1:0.5,
                            child: barIcons[index],
                        ),
                        index==currIndex? Container(
                          margin: const EdgeInsets.only(top: 5),
                          height:3,
                          width: 20,
                      decoration: const BoxDecoration(color: basicColor,borderRadius: BorderRadius.all(Radius.circular(10))),):const SizedBox(height: 0,),
                  ]),
                );
              }),
          ],
        ),
      ),
    );
  }
}

class CustomBottomNavClipPath extends CustomClipper<Path>{

  @override
  Path getClip(Size size) {
    final double h=size.height;
    final double w=size.width;
    final path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(w*0.4,0,w*0.4,0);
    //path.lineTo(w*0.4, 0);
    path.arcToPoint(Offset(w * 0.6, 5), radius:const Radius.circular(20), clockwise: false);
    path.quadraticBezierTo(w*0.6, 0,w*0.65,0);
    //path.lineTo(w*0.6, 0);
    path.lineTo(w, 0);
    path.lineTo(w, h);
    path.lineTo(0, h);
    path.close();
    return path;

  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }

}
