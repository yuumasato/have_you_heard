import 'package:flutter/material.dart';
import 'package:have_you_heard/constants/colors.dart';

class GrayStripe extends StatelessWidget {
  final String text;

  const GrayStripe({
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppBar().preferredSize.height * 0.73,
      alignment: Alignment.center,
      color: kBackgroundDarkGray,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
