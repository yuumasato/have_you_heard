import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:have_you_heard/constants/colors.dart';
import 'package:have_you_heard/constants/styles.dart';

import 'app_button.dart';

class LostGameDialog extends StatelessWidget {
  const LostGameDialog({
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
      title: Center(child: Text('ohNo'.tr)),
      titleTextStyle: HyhTextStyle.heading24BoldYellow,
      contentPadding: const EdgeInsets.all(20),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Stack(alignment: Alignment.center, children: [
            Container(
                width: 325,
                height: 215,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: kGrayScaleDark,
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: Svg(
                        "assets/images/lostGameFrame.svg",
                        size: Size(215, 215),
                      )),
                )),
            const Positioned(
                bottom: 10,
                child: Image(
                  image: Svg(
                    "assets/images/ribbon.svg",
                    color: kGrayScaleDarkest,
                    size: Size(325, 65),
                  ),
                )),
            Positioned(
                bottom: 35,
                child: Text(
                  'youLostThisGame'.tr,
                  style: HyhTextStyle.body14Bold,
                  textAlign: TextAlign.center,
                ))
          ]),
        ),
        FractionallySizedBox(
          widthFactor: 0.95,
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
