import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:have_you_heard/constants/styles.dart';
import 'package:have_you_heard/utilities/LayoutUtility.dart';
import 'package:have_you_heard/widgets/chat_balloon.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

import 'set_user_name.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  static const routeName = '/onboarding-1';
  static const route = '/onboarding-1';

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _currentPageNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    final size = query.size;
    final mediaWidth = size.width;
    final mediaHeight = size.height;
    final layoutUtility = LayoutUtility(query);
    var logoHeight =
        (layoutUtility.isTablet() && mediaHeight > 770) ? 240.0 : 154.0;
    //770 was the smallest height in tablets that didn't overflowed
    final mediaTopPadding = query.padding.top;
    final PageController controller = PageController(initialPage: 0);

    return Stack(children: [
      PageView(
          scrollDirection: Axis.horizontal,
          controller: controller,
          onPageChanged: (int index) {
            _currentPageNotifier.value = index;
          },
          children: [
            Scaffold(
              body: Center(
                child: Container(
                  height: mediaHeight,
                  width: (mediaWidth >= 620) ? 620 : mediaWidth,
                  // 620 is 540(balloon width + 2*padding)
                  padding: const EdgeInsets.all(40.0),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ChatBalloon(
                        balloonHeader: Text('haveYouHeard...'.tr,
                            style:
                                (layoutUtility.isTablet() && mediaHeight > 770)
                                    ? HyhTextStyle.body40Bold
                                    : HyhTextStyle.body16Height15Bold),
                        balloonText: RichText(
                            text: TextSpan(
                                text: 'gameExplanation'.tr,
                                style: (layoutUtility.isTablet() &&
                                        mediaHeight > 770)
                                    ? HyhTextStyle.body32
                                    : HyhTextStyle.body16Height15)),
                      ),
                      Hero(
                          tag: 'logo',
                          child: Container(
                              alignment: Alignment.topRight,
                              height: logoHeight,
                              child: SvgPicture.asset('assets/images/logo.svg',
                                  width: logoHeight, height: logoHeight))),
                      SizedBox(
                          height:
                              (layoutUtility.isTablet() && mediaHeight > 770)
                                  ? 200
                                  : 128)
                    ],
                  ),
                ),
              ),
            ),
            Scaffold(
              body: Center(
                child: Container(
                  height: mediaHeight,
                  width: (mediaWidth >= 620) ? 620 : mediaWidth,
                  // 620 is 540(balloon width + 2*padding)
                  padding: const EdgeInsets.all(40.0),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ChatBalloon(
                        balloonHeader: Text('character'.tr,
                            style:
                                (layoutUtility.isTablet() && mediaHeight > 770)
                                    ? HyhTextStyle.body40Bold
                                    : HyhTextStyle.body16Height15Bold),
                        balloonText: RichText(
                            text: TextSpan(
                                text: 'characterExplanation'.tr,
                                style: (layoutUtility.isTablet() &&
                                        mediaHeight > 770)
                                    ? HyhTextStyle.body32
                                    : HyhTextStyle.body16Height15)),
                      ),
                      SizedBox(
                          height: logoHeight,
                          width: mediaWidth,
                          child: personaStack(Size(
                              ((mediaWidth >= 620) ? 620 : mediaWidth) - 80,
                              logoHeight))),
                      SizedBox(
                        height: (layoutUtility.isTablet() && mediaHeight > 770)
                            ? 200
                            : 128,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Scaffold(
              body: Center(
                child: Container(
                  height: mediaHeight,
                  width: (mediaWidth >= 620) ? 620 : mediaWidth,
                  // 620 is 540(balloon width + 2*padding)
                  padding: const EdgeInsets.all(40.0),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ChatBalloon(
                        balloonHeader: Text('rounds'.tr,
                            style:
                                (layoutUtility.isTablet() && mediaHeight > 770)
                                    ? HyhTextStyle.body40Bold
                                    : HyhTextStyle.body16Height15Bold),
                        balloonText: RichText(
                            text: TextSpan(
                                style: (layoutUtility.isTablet() &&
                                        mediaHeight > 770)
                                    ? HyhTextStyle.body32
                                    : HyhTextStyle.body16Height15,
                                children: <TextSpan>[
                              TextSpan(text: 'roundExplanationStart'.tr),
                              TextSpan(
                                  text: 'roundLinedExplanation'.tr,
                                  style: const TextStyle(
                                      decoration: TextDecoration.lineThrough)),
                              TextSpan(text: 'roundExplanationEnd'.tr)
                            ])),
                      ),
                      SizedBox(
                        height: (layoutUtility.isTablet() && mediaHeight > 770)
                            ? 27.31
                            : 21,
                      ),
                      SizedBox(
                          width: (mediaWidth >= 620) ? 620 : mediaWidth,
                          child: SvgPicture.asset(
                              'assets/images/carWithLulo.svg',
                              alignment: Alignment.topRight,
                              width: (layoutUtility.isTablet() &&
                                      mediaHeight > 770)
                                  ? 375.53
                                  : 240.34)),
                      SizedBox(
                        height: (layoutUtility.isTablet() && mediaHeight > 770)
                            ? 200
                            : 128,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const UserNameScreen()
          ]),
      Positioned(
          left: 0.0,
          right: 0.0,
          bottom: 80.0,
          child: CirclePageIndicator(
            size: 10.0,
            selectedSize: 12.0,
            itemCount: 4,
            currentPageNotifier: _currentPageNotifier,
          )),
    ]);
  }

  Widget personaStack(Size size) {
    final availableWidth = size.width / 9; // 9 half persons
    final availableHeight = size.height;
    return Stack(children: [
      Positioned(
          left: 0,
          child: SizedBox(
            width: 2 * availableWidth,
            height: availableHeight,
            child: SvgPicture.asset('assets/images/bodySalvio.svg'),
          )),
      Positioned(
          left: availableWidth,
          child: SizedBox(
              width: 2 * availableWidth,
              height: availableHeight,
              child: SvgPicture.asset('assets/images/bodyLulo.svg'))),
      Positioned(
          left: 2 * availableWidth,
          child: SizedBox(
            width: 2 * availableWidth,
            height: availableHeight,
            child: SvgPicture.asset(
              'assets/images/bodyAntivacina.svg',
            ),
          )),
      Positioned(
          left: 3 * availableWidth,
          child: SizedBox(
            width: 2 * availableWidth,
            height: availableHeight,
            child: SvgPicture.asset(
              'assets/images/bodyVegana.svg',
            ),
          )),
      Positioned(
          left: 4 * availableWidth,
          child: SizedBox(
            width: 2 * availableWidth,
            height: availableHeight,
            child: SvgPicture.asset(
              'assets/images/bodyTump.svg',
            ),
          )),
      Positioned(
          left: 5 * availableWidth,
          child: SizedBox(
            width: 2 * availableWidth,
            height: availableHeight,
            child: SvgPicture.asset(
              'assets/images/bodyBonosaro.svg',
            ),
          )),
      Positioned(
          left: 6 * availableWidth,
          child: SizedBox(
            width: 2 * availableWidth,
            height: availableHeight,
            child: SvgPicture.asset(
              'assets/images/bodyEronMust.svg',
            ),
          )),
      Positioned(
          right: 0,
          child: SizedBox(
            width: 2 * availableWidth,
            height: availableHeight,
            child: SvgPicture.asset(
              'assets/images/bodyTiadoZap.svg',
            ),
          )),
    ]);
  }

  Widget pageBuilder(
      Text balloonHeader, RichText balloonText, Widget illustration) {
    final query = MediaQuery.of(context);
    final size = query.size;
    final mediaHeight = size.height;
    final mediaTopPadding = query.padding.top;
    final mediaViewHeight = mediaHeight - mediaTopPadding;

    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 47),
            height: (mediaViewHeight) / 2,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ChatBalloon(
                balloonHeader: balloonHeader,
                balloonText: balloonText,
              ),
            )),
        illustration
      ],
    )));
  }
}
