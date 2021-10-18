import 'package:flutter/material.dart';
import 'package:have_you_heard/constants/colors.dart';

class IconAppButton extends StatelessWidget {
  const IconAppButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.color = kYellow,
    this.textColor = kGrayScaleDarkest,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String text;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        primary: color,
        fixedSize: Size(double.infinity, AppBar().preferredSize.height * 0.8),
      ),
      child: Row(
        children: [
          Icon(
            Icons.people_outlined,
            color: textColor,
            size: 24.0,
          ),
          Expanded(
            child: Center(
              child: Text(text,
                  style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}