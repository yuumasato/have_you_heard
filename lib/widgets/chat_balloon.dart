import 'package:flutter/material.dart';

import 'package:have_you_heard/constants/colors.dart';

Widget ChatBalloon(Text balloonHeader, Text balloonText) {
  return Column(
      mainAxisSize:MainAxisSize.min,
      children: [
        Container(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 25),
            decoration: BoxDecoration(
                color: kBackgroundDarkGray,
                borderRadius: BorderRadius.all(
                    Radius.circular(36.0))),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize:MainAxisSize.min,
                children: [
                  balloonHeader,
                  balloonText,
                ])
        ),
        Container(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 25+25),
          alignment: Alignment.centerRight,
        child: CustomPaint(
            size: Size(51,29),
            painter: TrianglePainter(
              strokeColor: kBackgroundDarkGray,
              strokeWidth: 2,
              paintingStyle: PaintingStyle.fill,
            ))),
      ]
  );
}

// The triangle is only used in the ChatBalloon
class TrianglePainter extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;

  TrianglePainter({this.strokeColor = Colors.black, this.strokeWidth = 3, this.paintingStyle = PaintingStyle.stroke});

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
