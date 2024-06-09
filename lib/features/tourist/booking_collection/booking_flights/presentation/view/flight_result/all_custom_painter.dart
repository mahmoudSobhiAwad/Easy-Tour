import 'package:flutter/material.dart';

class ArcPainter extends CustomPainter {
  final double width;
  final double height;
  ArcPainter({required this.height,required this.width});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    Rect rect = Rect.fromLTWH(0,-20,width*0.7,height*0.2);

    double startAngle = -20 * 3.1415927 / 180; // Start angle in radians
    double sweepAngle = -140 * 3.1415927 / 180; // Sweep angle in radians

    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    const double cutRadius = 15.0;

    // Start from the top-left corner
    path.moveTo(0, 0);

    // Top side
    path.lineTo(size.width, 0);

    // Top-right corner
    path.lineTo(size.width, size.height * 0.7 - cutRadius);

    // Right side curve cut
    path.arcToPoint(
      Offset(size.width, size.height * 0.7 + cutRadius),
      radius: const Radius.circular(cutRadius),
      clockwise: false,
    );

    path.lineTo(size.width, size.height);

    // Bottom side
    path.lineTo(0, size.height);

    // Bottom-left corner
    path.lineTo(0, size.height * 0.7 + cutRadius);

    // Left side curve cut
    path.arcToPoint(
      Offset(0, size.height * 0.7 - cutRadius),
      radius: const Radius.circular(cutRadius),
      clockwise: false,
    );

    path.lineTo(0, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class DashedLine extends StatelessWidget {
  final double height;
  final Color color;
  final double dashWidth;
  final double dashGap;
  final double length;

  const DashedLine({
    super.key,
    required this.height,
    required this.color,
    required this.dashWidth,
    required this.dashGap,
    required this.length,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(length, height),
      painter: DashedLinePainter(
        height: height,
        color: color,
        dashWidth: dashWidth,
        dashGap: dashGap,
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  final double height;
  final Color color;
  final double dashWidth;
  final double dashGap;

  DashedLinePainter({
    required this.height,
    required this.color,
    required this.dashWidth,
    required this.dashGap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = height;

    double startX = 0;
    final space = (dashWidth + dashGap);
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashWidth, size.height / 2),
        paint,
      );
      startX += space;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}