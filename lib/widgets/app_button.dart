import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:have_you_heard/constants/colors.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    this.color = kYellow,
    this.textColor = kGrayScaleDarkest,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  final Color color;
  final VoidCallback? onPressed;
  final String text;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          primary: color,
          fixedSize: Size(double.infinity, AppBar().preferredSize.height * 0.8),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.bold),
        ));
  }
}
