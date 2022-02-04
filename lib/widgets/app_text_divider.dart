import 'package:flutter/material.dart';
import 'package:have_you_heard/constants/colors.dart';

class AppTextDivider extends StatelessWidget {
  const AppTextDivider({
    Key? key,
    required this.padding,
    required this.text,
    required this.lineWidth,
    this.spacing = 0,
    this.lineThickness = 2,
  }) : super(key: key);

  final EdgeInsetsGeometry padding;
  final String text;
  final double lineWidth;
  final double spacing;
  final double lineThickness;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: lineWidth + spacing,
            child: Divider(
              color: kGrayScaleMediumDark,
              thickness: lineThickness,
              endIndent: spacing,
            ),
          ),
          Text(
            text,
            style: const TextStyle(
                fontSize: 16, color: kGrayScaleMedium),
          ),
          SizedBox(
            width: lineWidth + 8,
            child: Divider(
              indent: spacing,
              color: kGrayScaleMediumDark,
              thickness: lineThickness,
            ),
          ),
        ],
      ),
    );
  }
}