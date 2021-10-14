import 'package:flutter/material.dart';

import 'package:have_you_heard/constants/colors.dart';

class ChatBalloon extends StatelessWidget {
  const ChatBalloon({
    Key? key,
    required this.balloonHeader,
    required this.balloonText,
    this.color = kGrayScaleMediumDark,
  }) : super(key: key);

  final Text balloonHeader;
  final RichText balloonText;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 25),
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(36.0))),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                balloonHeader,
                balloonText,
              ])),
      Container(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 25 + 25),
          alignment: Alignment.centerRight,
          child: CustomPaint(
              size: Size(51, 29),
              painter: TrianglePainter(
                strokeColor: color,
                strokeWidth: 2,
                paintingStyle: PaintingStyle.fill,
              ))),
    ]);
  }
}

// The triangle is only used in the ChatBalloon
class TrianglePainter extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;

  TrianglePainter(
      {this.strokeColor = Colors.black,
      this.strokeWidth = 3,
      this.paintingStyle = PaintingStyle.stroke});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    canvas.drawPath(getTrianglePath(size.width, size.height), paint);
  }

  Path getTrianglePath(double x, double y) {
    return Path()
      ..lineTo(x, 0)
      ..lineTo(x / 2, y)
      ..lineTo(0, 0);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
