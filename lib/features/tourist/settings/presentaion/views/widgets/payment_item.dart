import 'package:flutter/material.dart';

class PaymentItem extends StatelessWidget {
  const PaymentItem({super.key,required this.height,required this.width,required this.imagePath,required this.title});
  final double height;
  final double width;
  final String imagePath;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ClipPath(
          clipper: CustomClipPayment(),
          child: Image.asset(
            height: height*0.1,
            width: width*0.3,
            imagePath,
          ),
        ),
        Text(title)
      ],
    );
  }
}
class CustomClipPayment extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    double h=size.height;
    double w=size.width;
    // TODO: implement getClip
    final path=Path();
    path.moveTo(0, h-h*0.8);
    path.quadraticBezierTo(0, 0, w-w*0.8, 0);
    path.lineTo(w-w*0.2, 0);
    path.quadraticBezierTo(w, 0, w, h-h*0.8);
    path.lineTo(w, h-h*0.2);
    path.quadraticBezierTo(w, h, w-w*0.2, h);
    path.lineTo(w-w*0.8, h);
    path.quadraticBezierTo(0, h,0,h-h*0.2);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
   return false;
  }

}