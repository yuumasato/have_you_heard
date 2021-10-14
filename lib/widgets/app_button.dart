import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:have_you_heard/constants/colors.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.width,
    this.color = kYellow,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  final Color color;
  final VoidCallback? onPressed;
  final Widget child;
  final double width;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          primary: color,
          fixedSize: Size(width, AppBar().preferredSize.height * 0.8),
        ),
        onPressed: onPressed,
        child: child);
  }
}
