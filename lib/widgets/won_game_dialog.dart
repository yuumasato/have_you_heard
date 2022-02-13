import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:have_you_heard/constants/colors.dart';
import 'package:have_you_heard/constants/styles.dart';

import 'app_button.dart';

class WonGameDialog extends StatelessWidget {
  const WonGameDialog({
    Key? key,
    required this.onPLayAgainPressed,
    required this.onEndGamePressed,
    this.ribbonText = '',
  }) : super(key: key);

  final VoidCallback onPLayAgainPressed;
  final VoidCallback onEndGamePressed;
  final String ribbonText;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Center(child: Text('congratulations'.tr)),
      titleTextStyle: HyhTextStyle.heading24BoldYellow,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          child: Stack(alignment: Alignment.center, children: [
            const Image(
              image: Svg("assets/images/trophy.svg", size: Size(215, 215)),
            ),
            const Positioned(
              bottom: 20,
              child: Image(
                  image: Svg("assets/images/ribbon.svg", size: Size(325, 65),
                  color: kLightBlue)),
            ),
            Positioned(
                bottom: 45,
                child: Text(
                  'youWonThisGame'.tr,
                  style: HyhTextStyle.body14Bold,
                  textAlign: TextAlign.center,
                ))
          ]),
        ),
        FractionallySizedBox(
          widthFactor: 0.85,
          child: AppButton(
              onPressed: onPLayAgainPressed,
              color: kPink,
              textColor: kGrayScaleLightest,
              text: 'playAgain'.tr),
        ),
        TextButton(onPressed: onEndGamePressed, child: Text('endGame'.tr))
      ],
    );
  }
}
